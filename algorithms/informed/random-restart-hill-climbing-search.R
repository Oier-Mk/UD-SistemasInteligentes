source("/Users/mentxaka/Documents/Universidad De Deusto/2021-22/2do Semestre/Sistemas Inteligentes/algorithms/informed/hill-climbing-search.R")
source("/Users/mentxaka/Documents/Universidad De Deusto/2021-22/2do Semestre/Sistemas Inteligentes/algorithms/blind/expand-node.R")
source("/Users/mentxaka/Documents/Universidad De Deusto/2021-22/2do Semestre/Sistemas Inteligentes/problem/p-hub-problem.R")


random.restart.hill.climbing.search = function(file,
                                                p,
                                                iterations ) { #iterations - número de veces que se repite el hill climbing search
  # file        <- "/Users/mentxaka/Documents/Universidad De Deusto/2021-22/2do Semestre/Sistemas Inteligentes/data/p-hub/AP100.txt"
  # p           <- 3
  # iterations       <- 10
  
  start_time <- Sys.time()
  
  i = 0
  # TO - DO. implementación de la llamada
  while(i<iterations){
    newProblem    <- initialize.problem(file,p)   
    report        <- hill.climbing.search(newProblem, 100, 100, FALSE)
    print(i)
    i = i+1
  }
  print("sale de while")
  end_time <- Sys.time()
  result <- list()
  result$name    <- "Random restart hill climbing"
  result$runtime <- end_time - start_time
  result$report      <- report
  return(result)
}
