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

for(i in 1:10){ #Training 10 times the model and getting the one with best results
  # Create Linear Model using training data. Formula = all the columns except charges
  model <- lm(formula = charges ~., data = training_data) 
  
  # Make the prediction using the model and test data
  prediction <- predict(model, test_data)
  
  # Calculate Mean Average Error - comparar predicción (valor estimado) con valor real para hallar error
  mean_avg_error <- mean(abs(prediction - test_data$charges))
  
  if( mean_avg_error < error_ratio){ #en caso de hallar mejores resultados, asignar modelo y ratio de error
    best <- model
    error_ratio <- mean_avg_error
  }
}

model <- best
mean_avg_error <- error_ratio

# Print Mean Absolute Error
print(paste0("- Mean average error: ", mean_avg_error))

# Print model summary
#summary(model)

#Si una persona deja de fumar, ¿cuánto se reduciría el coste?
#¿Cuánto aumentaría el coste si una persona empieza a fumar?

data$smoker <- "no" #indicamos que todos NO fuman
non_smoker_price <- mean(predict(model, newdata = data)) #extraemos el precio estimado

data$smoker <- "yes" #indicamos que todos fuman
smoker_price <- mean(predict(model, newdata = data)) #extraemos el precio estimado

incremento_por_fumar <- abs(smoker_price - non_smoker_price) #vemos el incremento o decremento que supone fumar o dejar de hacerlo

data <- read.csv("../data/insurance.csv") #releemos el fichero para dejar la columna fumador como por defecto

#¿Quiénes son las 3 personas cuyo coste aumentará más en 5 años?

data$age <- data$age + 5 #incrementamos la edad
data$newCharges <- predict(model, newdata = data) #predecimos el precio en ese tiempo
data$difference <- data$newCharges - data$charges #calculamos el valor de la diferencia
data <- data[order(-data$difference),] #ordenamos la diferencia en descendente
mayor_incremento <- head(data,3) #extraemos los usuarios que mayor incremento tendrían en 5 anyos



