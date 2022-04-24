# Clear plots
if(!is.null(dev.list())) dev.off()
# Clear console
cat("\014") 
# Clean workspace
rm(list=ls())
# Set working directory
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Install required packages
library(lattice)
library(ggplot2)
library(caret)
library(rpart)
library(rpart.plot)

# Read data from CSV
data <- read.csv(file = "../data/CAR-DETAILS-FROM-CAR-DEKHO.csv", sep =",", header = TRUE)

data$name <- NULL

data$year[data$year <= 2000] <- "<= 2000"
data$year[data$year > 2000 & data$year <= 2005] <- "2000 < x <= 2005"
data$year[data$year > 2005 & data$year <= 2010] <- "2005 < x <= 2010"
data$year[data$year > 2010 & data$year <= 2015] <- "2010 < x <= 2015"
data$year[data$year > 2015 & data$year <= 2020] <- "2015 < x <= 2020"

data$selling_price[strtoi(data$selling_price) <= 50000] <- "x <= 50000"
data$selling_price[strtoi(data$selling_price) >  50000 & strtoi(data$selling_price) <= 100000] <- "50000  < x <= 100000"
data$selling_price[strtoi(data$selling_price) > 100000 & strtoi(data$selling_price) <= 200000] <- "100000 < x <= 200000"
data$selling_price[strtoi(data$selling_price) > 200000 & strtoi(data$selling_price) <= 300000] <- "200000 < x <= 300000"
data$selling_price[strtoi(data$selling_price) > 300000 & strtoi(data$selling_price) <= 400000] <- "300000 < x <= 400000"
data$selling_price[strtoi(data$selling_price) > 400000 & strtoi(data$selling_price) <= 500000] <- "400000 < x <= 500000"
data$selling_price[strtoi(data$selling_price) > 500000 & strtoi(data$selling_price) <= 600000] <- "500000 < x <= 600000"
data$selling_price[strtoi(data$selling_price) > 600000] <- "x > 600000"
#data$selling_price <- data$selling_price / 100


# data$selling_price <- NULL

data$km_driven[strtoi(data$km_driven) <= 35000] <- "x <= 35000"
data$km_driven[strtoi(data$km_driven) > 35000 & strtoi(data$km_driven) <= 50000] <- "35000 < x <= 50000"
data$km_driven[strtoi(data$km_driven) > 50000 & strtoi(data$km_driven) <= 65000] <- "50000 < x <= 65000"
data$km_driven[strtoi(data$km_driven) > 65000 & strtoi(data$km_driven) <= 80000] <- "65000 < x <= 80000"
data$km_driven[strtoi(data$km_driven) > 80000 & strtoi(data$km_driven) <= 95000] <- "80000 < x <= 95000"
data$km_driven[strtoi(data$km_driven) > 95000] <- "x > 95000"
# data$km_driven <- NULL

# Convert columns to factors
index <- 1:ncol(data)
data[ , index] <- lapply(data[ , index], as.factor)

# Percentaje of training examples
training_p <- 0.8

# Generate data partition 80% training / 20% test. The result is a vector with the indexes 
# of the examples that will be used for the training of the model.
training_indexes <- createDataPartition(y = data$seller_type, p = training_p, list = FALSE)

# Split training and test data
training_data <- data[training_indexes, ]  # Extract training data using training_indexes
test_data     <- data[-training_indexes, ] # Extract data with the indexes not included in training_indexes 

best <- NULL
best_accuracy <- 0
for (i in 1:10){
  # Create Linear Model using training data. Formula = all the columns except seller_type 
  model <- rpart(formula = seller_type ~., data = training_data)
  
  # Make the prediction using the model and test data
  prediction <- predict(model, test_data, type = "class")
  
  # Calculate accuracy using Confusion Matrix
  prediction_results <- table(test_data$seller_type, prediction)
  matrix <- confusionMatrix(prediction_results)
  accuracy <- matrix$overall[1]
  if (accuracy > best_accuracy){
    best <- model
    best_accuracy <- accuracy
  }
}

# Print the accuracy
accuracy <- paste0("Accuracy = ", round(100*accuracy, digits = 2), "%")
print(accuracy, quote = FALSE)

# Print attributes in descending relevance
attrs <- names(model$variable.importance)

print("Attributes in descending order of relevance")

for (i in 1:length(attrs)) {
  print(paste0("  ", attrs[i]), quote = FALSE)
}

# Plot tree (this method is slow, wait until pot is completed)
rpart.plot(model, 
           type = 2,
           extra = 102,
           tweak = 1.1,
           box.palette = "GnYlRd",
           shadow.col = "darkgray",
           main = "Dealer, indivudial or trustmark dealer?", 
           sub = accuracy)

# Print the rules that represent the Decision Tree
rules <- rpart.rules(model, 
            style="wide", 
            cover = TRUE, 
            eq = "=", 
            when = "IF", 
            and = "&", 
            extra = 4)
rules
