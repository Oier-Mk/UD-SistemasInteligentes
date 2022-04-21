# Clear Environment
rm(list=ls())
# Set working directory
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
# Clear plots & console
if(!is.null(dev.list())) dev.off()
cat("\014") 

# Install required packages
library(ggplot2)
library(lattice)
library(caret)
library(RKEEL)
library(stringr)


# Read data from CSV
data <- read.csv("../data/insurance.csv")

char2num<-function(x){
  groups = unique(x)
  as.numeric(factor(x, levels=groups))
}

data$sex <- char2num(data$sex)
data$smoker <- char2num(data$smoker)
data$region <- char2num(data$region)

# Set plot structure and margins
par(mfrow = c(2,6), mar=c(1,1,1,1))

# Scatter Plot - Check linear relationships
for (col_name in colnames(data)) {
  if (col_name != "charges") {
    scatter.smooth(x=data$charges, y=data[[col_name]], main=col_name, col="lightgreen")
  }
}

# Correlation between variables
print("Correlation between each attribute and charges: A low correlation (-0.2 < x < 0.2)", quote=FALSE)

for (col_name in colnames(data)) {
  print(paste0(col_name, ": ", cor(data$charges, data[[col_name]])), quote=FALSE)
}

# Percentage of training examples
training_p <- 0.8

# Generate data partition 80% training / 20% test. The result is a vector with 
# the indexes of the examples that will be used for the training of the model.
training_indexes <- createDataPartition(y = data$charges, p = training_p, list = FALSE)

# Split training and test data
training_data <- data[training_indexes, ]  # Extract training data using training_indexes
test_data     <- data[-training_indexes, ] # Extract data with the indexes not included in training_indexes 

best <- NULL
error_ratio <- 10000

for(i in 1:10){ #Training 10 times the model and getting the one with best resoults
  # Create Linear Model using training data. Formula = all the columns except charges
  model <- lm(formula = charges ~., data = training_data)
  
  # Make the prediction using the model and test data
  prediction <- predict(model, test_data)
  
  # Calculate Mean Average Error
  mean_avg_error <- mean(abs(prediction - test_data$charges))
  
  if( mean_avg_error < error_ratio){
    best <- model
    error_ratio <- mean_avg_error
  }
}

# Print Mean Absolute Error
print(paste0("- Mean average error: ", mean_avg_error))

# Print model summary
summary(model)

#Si una persona deja de fumar, ¿cuánto se reduciría el coste?
#¿Cuánto aumentaría el coste si una persona empieza a fumar?

age = c(20) #creamos una persona ficticia que no fuma con la media de los atributos
sex = c(2)
bmi = c(30.66)
children = c(1)
smoker = c(2)
region = c(1)

non_smoker_price <- predict(model, newdata = data.frame(age,sex,bmi,children,smoker,region)) #extraemos el precio estimado

smoker = c(1) #indicamos que esa misma persona si fuma para ver el cambio
smoker_price <- predict(model, newdata = data.frame(age,sex,bmi,children,smoker,region)) #extraemos el precio estimado

incremento_por_fumar <- abs(non_smoker_price - smoker_price) #vemos el incremento o decremento que supone fumar o dejar de hacerlo

#¿Quiénes son las 3 personas cuyo coste aumentará más en 5 años?

data$age <- data$age + 5 #incrementamos la edad
data$newCharges <- predict(model, newdata = data) #predecimos el precio en ese tiempo
data$difference <- abs(data$newCharges - data$charges) #calculamos el valor absoluto de la diferencia
data <- data[order(-data$difference),] #ordenamos la diferencia en descendente
mayor_incremento <- head(data,3) #extraemos los usuarios que mayor incremento tendr'an en 5 anyos



