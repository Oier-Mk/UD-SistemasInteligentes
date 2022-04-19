# Clear environment and console
rm(list=ls())
cat("\014")
graphics.off()
# Set working directory
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

#Import the libraries needed to display the results
library(kableExtra)
library(magrittr)

# Include algorithm functions
source("../algorithms/blind/expand-node.R")
source("../algorithms/informed/hill-climbing-search.R")
source("../algorithms/informed/random-restart-hill-climbing-search.R")
source("../algorithms/informed/local-beam-search.R")

# Include functions for data analysis and result plot
source("../algorithms/results-analysis/analyze-results.R")

# Include the problem
source("../problem/p-hub-problem.R")



# Executes hill climbing search and return the results
execute.random.restart.hill.climbing <- function(filename, p, times) {

  # Initialize problem
  # Execute hill climbing 'n' times
  results <- vector(mode = "list", length = times)
  problems <- vector(mode = "list", length = times)
  for (i in 1:times) {
    problems[[i]] <- initialize.problem(filename, p)
    results[[i]] <- random.restart.hill.climbing.search(problems[[i]])
  }
  
  # Analyze results
  
  results_df <- one.by.one.analyze.results(results, problems)

  print(paste0("Best evaluation: ", round(min(results_df$Evaluation), 2),
               " - Mean: ", round(mean(results_df$Evaluation), 2),
               " - SD: ", round(sd(results_df$Evaluation), 2)), quote = FALSE)
  print(paste0("Best runtime: ", round(min(results_df$Runtime), 2),
               " - Mean: ", round(mean(results_df$Runtime), 2),
               " - SD: ", round(sd(results_df$Runtime), 2)), quote = FALSE)

  return(results_df)
}

get.best.one <- function(results_df){
  bestEvaluated <- results_df[order(results_df$Evaluation),]
  return(bestEvaluated[1,])
}

# Executes hill climbing search and return the results
execute.hill.climbing <- function(filename, p) {
  # Initialize problem
  problem <- initialize.problem(p = p, filename = filename)
  # Execute hill climbing
  return(hill.climbing.search(problem = problem))
}

# Execute Hill Climbing several times and analyze results
test.hill.climbing <- function(file, p, times) {
  # Execute hill climbing 'n' times
  results <- vector(mode = "list", length = times)

  for (i in 1:times) {
    results[[i]] <- execute.hill.climbing(filename = file, p = p)
  }

  # Initialize a problem instance for the analysis
  problem <- initialize.problem(filename = file, p = p)

  # Analyze results
  results_df <- local.analyze.results(results, problem)

  print(paste0("Best evaluation: ", round(min(results_df$Evaluation), 2),
               " - Mean: ", round(mean(results_df$Evaluation), 2),
               " - SD: ", round(sd(results_df$Evaluation), 2)), quote = FALSE)
  print(paste0("Best runtime: ", round(min(results_df$Runtime), 2),
               " - Mean: ", round(mean(results_df$Runtime), 2),
               " - SD: ", round(sd(results_df$Runtime), 2)), quote = FALSE)

  return(results_df)
}

# Executes local beam search and return the results
execute.local.beam.search <- function(problem) {
  # Execute local beam search
  return(local.beam.search(problem = problem))
}
test.local.beam.search <- function(filename, p, beams, times) {

  results <- vector(mode = "list", length = beams)
  
  # Initialize a problem instance for the analysis
  problem <- initialize.problem(filename = filename, p = p)
  
  for (i in 1:times) {
    results[[i]] <- execute.local.beam.search(problem)
  }
  
  # Analyze results
  results_df <- local.analyze.results(results, problem)
  
  print(paste0("Best evaluation: ", round(min(results_df$Evaluation), 2),
               " - Mean: ", round(mean(results_df$Evaluation), 2),
               " - SD: ", round(sd(results_df$Evaluation), 2)), quote = FALSE)
  print(paste0("Best runtime: ", round(min(results_df$Runtime), 2),
               " - Mean: ", round(mean(results_df$Runtime), 2),
               " - SD: ", round(sd(results_df$Runtime), 2)), quote = FALSE)
  
  return(results_df)
}


# Clear console
cat("\014")
graphics.off()

file        <- "../data/p-hub/AP40.txt"
p           <- 3
times       <- 10
results_df  <- test.hill.climbing(file, p, times)
hc10        <- get.best.one(results_df)
file        <- "../data/p-hub/AP40.txt"
p           <- 3
times       <- 20
results_df  <- test.hill.climbing(file, p, times)
hc20        <- get.best.one(results_df)
file        <- "../data/p-hub/AP40.txt"
p           <- 3
times       <- 50
results_df  <- test.hill.climbing(file, p, times)
hc50        <- get.best.one(results_df)


file        <- "../data/p-hub/AP40.txt"
p           <- 3
times       <- 10
results_df  <- execute.random.restart.hill.climbing(file,p,times)
rr10 <- get.best.one(results_df)
file        <- "../data/p-hub/AP40.txt"
p           <- 3
times       <- 20
results_df  <- execute.random.restart.hill.climbing(file,p,times)
rr20 <- get.best.one(results_df)
file        <- "../data/p-hub/AP40.txt"
p           <- 3
times       <- 50
results_df  <- execute.random.restart.hill.climbing(file,p,times)
rr50 <- get.best.one(results_df)

file        <- "../data/p-hub/AP40.txt"
p           <- 3
beams       <- 3
times       <- 10
results_df  <- test.local.beam.search(file, p, beams,times) 
beams3      <- get.best.one(results_df)
file        <- "../data/p-hub/AP40.txt"
p           <- 3
beams       <- 5
times       <- 20
results_df  <- test.local.beam.search(file, p, beams,times)
beams5      <- get.best.one(results_df)
file        <- "../data/p-hub/AP40.txt"
p           <- 3
beams       <- 10
times       <- 50
results_df  <- test.local.beam.search(file, p, beams,times)
beams10     <- get.best.one(results_df)

result      <- rbind(hc10,hc20,hc50,rr10,rr20,rr50,beams3,beams5,beams10)

kable_material(kbl(result, caption = "RESULT p-hub AP40"),  c("striped", "hover", "condensed", "responsive"))
