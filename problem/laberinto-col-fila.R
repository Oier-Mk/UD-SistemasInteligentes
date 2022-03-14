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
  file = "/Users/aidagomezbuenoberezo/Documents/sinteligentes/data/laberinto.txt"
  # This attributes are compulsory
  problem$name                <- paste0("Laberinto - [", file, "]")
  problem$size                <- c(as.integer(read.csv(file, sep=";", header = FALSE, nrows=1)[1]),as.integer(read.csv(file, sep=";", header = FALSE, nrows=1)[2]))
  problem$table               <- read.csv(file, sep=";", header = FALSE, skip=1, nrows=problem$size[1])
  problem$state_initial       <- c(as.integer(substr(read.csv(file, sep=";", header = FALSE, skip=1+problem$size[1], nrows=1), 1,1))+1,as.integer(substr(read.csv(file, sep=";", header = FALSE, skip=1+problem$size[1], nrows=1), 3,3))+1)
  problem$state_final         <- c(as.integer(substr(read.csv(file, sep=";", header = FALSE, skip=2+problem$size[1], nrows=1), 1,1))+1,as.integer(substr(read.csv(file, sep=";", header = FALSE, skip=2+problem$size[1], nrows=1), 3,3))+1)
  problem$actions_possible    <- data.frame(direction = c("Up", "Down", "Left", "Right"), stringsAsFactors = FALSE)
  
  return(problem)
}

get.state <- function(coordenadas, problem){
  return(problem$table[coordenadas[2],coordenadas[1]])     #columna, fila
  #return(problem$table[coordenadas[1],coordenadas[2]])
}

# state = c(1,2)
# get.state(state,problem)

# Analyzes if an action can be applied in the received state.
# Estado lo que varia y problema lo que mantiene estatico
is.applicable <- function (state, action, problem) {
  result <- FALSE # Default value is FALSE.
  
  # state = c(7,7)
  # action = "Up"
  
  if (action == "Up") {
    condicion1 <- 0 < state[1]-1 #columnas - comprobacion de que no esta en el tope de arriba
    if (!condicion1) return(F)
    condicion2 <- get.state(state,problem) != get.state(c(state[1]-1,state[2]),problem)  #leer posición en el table
    if (condicion2) return(T)
  }
  
  # state = c(1,1)
  # action = "Down"
  
  if (action == "Down") {
    condicion1 <- problem$size[1] > state[1]+1 #comprobacion de que no esta en el tope de abajo
    if (!condicion1) return(F)
    condicion2 <- get.state(state,problem) != get.state(c(state[1]+1,state[2]),problem)
    if (condicion2) return(T)  
  }
  
  # state = c(1,1)
  # action = "Left"
  
  if (action == "Left") {
    condicion1 <- 0 < state[2]-1 #comprobacion de que no esta en el tope de la izquierda
    if (!condicion1) return(F)
    condicion2 <- get.state(state,problem) != get.state(c(state[1],state[2]-1),problem)
    if (condicion2) return(T)
  }
  
  # state = c(7,7)
  # action = "Right"
  
  if (action == "Right") {
    condicion1 <- problem$size[2] > state[2]+1 #comprobacion de que no esta en el tope de la derecha
    if (!condicion1) return(F)
    condicion2 <- get.state(state,problem) != get.state(c(state[1],state[2]+1),problem)
    if (condicion2) return(T)
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
is.final.state <- function (state, final_state, problem) {
  result <- FALSE # Default value is FALSE.
  #final_state = c(2,2)
  #state = c(2,2)
  if(state[1] == final_state[1] && state[2] == final_state[2]){
    result <- T
  } 
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