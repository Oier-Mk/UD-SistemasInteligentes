# =========================================================================
# Group Name: 
# Students: Aida Gomezbueno & Oier Mentxaka
# =========================================================================
# You must implement the different functions according to your problem.
# You cannot modify the function headers because they are used by the 
# search algorithms. If you modify any headers the algorithms may not work.
# =========================================================================

# This function must return a list with the information needed to solve the problem.
# (Depending on the problem, it should receive or not parameters)
initialize.problem <- function(file) {
  problem <- list() # Default xvalue is an empty list.
  # file = "~/Documents/Universidad De Deusto/2021-22/2do Semestre/Sistemas Inteligentes/data/laberinto.txt"
  # This attributes are compulsory
  problem$name                <- paste0("Laberinto - [", file, "]")
  problem$size                <- c(as.integer(read.csv(file, sep=";", header = FALSE, nrows=1)[1]),as.integer(read.csv(file, sep=";", header = FALSE, nrows=1)[2]))
  problem$table               <- read.csv(file, sep=";", header = FALSE, skip=1, nrows=problem$size)
  problem$state_initial       <- c(as.integer(substr(read.csv(file, sep=";", header = FALSE, skip=1+problem$size[1], nrows=1), 1,1)),as.integer(substr(read.csv(file, sep=";", header = FALSE, skip=1+problem$size[1], nrows=1), 3,3)))
  problem$state_final       <- c(as.integer(substr(read.csv(file, sep=";", header = FALSE, skip=2+problem$size[1], nrows=1), 1,1)),as.integer(substr(read.csv(file, sep=";", header = FALSE, skip=2+problem$size[1], nrows=1), 3,3)))
  problem$actions_possible    <- data.frame(direction = c("Up", "Down", "Left", "Right"), stringsAsFactors = FALSE)
  
  return(problem)
}

get.state <- function(coordenadas){
  return(problem$table[[coordenadas[1]+1,coordenadas[2]+1]])
}

# Analyzes if an action can be applied in the received state.
# Estado lo que varia y problema lo que mantiene estatico
is.applicable <- function (state, action, problem) {
  result <- FALSE # Default value is FALSE.
  
  state = c(2,2)

  if (action == "Up") {
    condicion1 <- problem$size[1] > state[2]+1 #comprobacion de que no esta en el tope de arriba
    condicion2 <- get.state(state) == "R"
    condicion3 <- get.state(c(state[1],state[2]+1)) == "L"
    condicion4 <- get.state(state) == "L"
    condicion5 <- get.state(c(state[1],state[2]+1)) == "R"
    if(condicion1 && ( (condicion2 && condicion3) || (condicion4 && condicion5) )) return(T)
  }
  
  if (action == "Down") {
    condicion1 <- 0 < state[2]-1 #comprobacion de que no esta en el tope de abajo
    condicion2 <- get.state(state) == "R"
    condicion3 <- get.state(c(state[1],state[2]+1)) == "L"
    condicion4 <- get.state(state) == "L"
    condicion5 <- get.state(c(state[1],state[2]+1)) == "R"
    if(condicion1 && ( (condicion2 && condicion3) || (condicion4 && condicion5) )) return(T)
  }
  
  if (action == "Left") {
    condicion1 <- 0 < state[1]-1 #comprobacion de que no esta en el tope de la izquierda
    condicion2 <- get.state(state) == "R"
    condicion3 <- get.state(c(state[1],state[2]+1)) == "L"
    condicion4 <- get.state(state) == "L"
    condicion5 <- get.state(c(state[1],state[2]+1)) == "R"
    if(condicion1 && ( (condicion2 && condicion3) || (condicion4 && condicion5) )) return(T)
  }
  
  if (action == "Right") {
    condicion1 <- problem$size[2] > state[1]+1 #comprobacion de que no esta en el tope de la derecha
    condicion2 <- get.state(state) == "R"
    condicion3 <- get.state(c(state[1],state[2]+1)) == "L"
    condicion4 <- get.state(state) == "L"
    condicion5 <- get.state(c(state[1],state[2]+1)) == "R"
    if(condicion1 && ( (condicion2 && condicion3) || (condicion4 && condicion5) )) return(T)
  }
  return(result)
}

# Returns the state resulting on applying the action over the state
effect <- function (state, action, problem) {

  result <- state  
  
  if (action == "Up") {
    result <- c(state[1],state[2]+1)
    return(result)
  }
  
  if (action == "Down") {    
    result <- c(state[1],state[2]-1)
    return(result)
  }
  
  if (action == "Left") {
    result <- c(state[1]-1,state[2])
    return(result)
  }
  
  if (action == "Right") {
    result <- c(state[1]+1,state[2])
    return(result)
  }
}

# Analyzes if a state is final or not
is.final.state <- function (state, final_satate, problem) {
  result <- FALSE # Default value is FALSE.
  if(state == final_satate) result <- T
  return(result)
}

# Transforms a state into a string
to.string = function (state, problem) {
  print(state)
}
# Returns the cost of applying an action over a state
get.cost <- function (action, state, problem) {
  return(1) # Default value is 1.
}
# Heuristic function used by Informed Search Algorithms
get.evaluation <- function(state, problem) {
	return(1) # Default value is 1.
}