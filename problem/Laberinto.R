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
  file = "/Users/aidagomezbuenoberezo/Documents/sinteligentes/data/feet-maze-1a.txt"
  # This attributes are compulsory
  problem$name                <- paste0("Laberinto - [", file, "]")
  problem$size                <- c(as.integer(read.csv(file, sep=";", header = FALSE, nrows=1)[1]),as.integer(read.csv(file, sep=";", header = FALSE, nrows=1)[2]))
  problem$table               <- read.csv(file, sep=";", header = FALSE, skip=1, nrows=problem$size[1])
  problem$state_initial       <- c(as.integer(substr(read.csv(file, sep=";", header = FALSE, skip=1+problem$size[1], nrows=1), 3,3))+1,as.integer(substr(read.csv(file, sep=";", header = FALSE, skip=1+problem$size[1], nrows=1), 1,1))+1)
  problem$state_final         <- c(as.integer(substr(read.csv(file, sep=";", header = FALSE, skip=2+problem$size[1], nrows=1), 3,3))+1,as.integer(substr(read.csv(file, sep=";", header = FALSE, skip=2+problem$size[1], nrows=1), 1,1))+1)
  problem$actions_possible    <- data.frame(direction = c("Up", "Down", "Left", "Right"), stringsAsFactors = FALSE)
  
  return(problem)
}

get.state <- function(coordenadas, problem){
  # print(coordenadas[1])
  # print(coordenadas[2])
  #return(problem$table[coordenadas[2],coordenadas[1]])     #columna, fila
  return(problem$table[coordenadas[1],coordenadas[2]])      #fila, columna - se lee la matriz de izquierda a derecha y de arriba a abajo
}

#fila 1
# get.state(c(1, 1), problem)
# get.state(c(1, 2), problem)
# get.state(c(1, 3), problem)
# get.state(c(1, 4), problem)
# get.state(c(1, 5), problem)
# get.state(c(1, 6), problem)
# get.state(c(1, 7), problem)

#fila 2
# get.state(c(2, 1), problem)
# get.state(c(2, 2), problem)
# get.state(c(2, 3), problem)
# get.state(c(2, 4), problem)
# get.state(c(2, 5), problem)
# get.state(c(2, 6), problem)
# get.state(c(2, 7), problem)

# #fila 3
# get.state(c(3, 1), problem)
# get.state(c(3, 2), problem)
# get.state(c(3, 3), problem)
# get.state(c(3, 4), problem)
# get.state(c(3, 5), problem)
# get.state(c(3, 6), problem)
# get.state(c(3, 7), problem)
# 
# #fila 4
# get.state(c(4, 1), problem)
# get.state(c(4, 2), problem)
# get.state(c(4, 3), problem)
# get.state(c(4, 4), problem)
# get.state(c(4, 5), problem)
# get.state(c(4, 6), problem)
# get.state(c(4, 7), problem)
# 
# #fila 5
# get.state(c(5, 1), problem)
# get.state(c(5, 2), problem)
# get.state(c(5, 3), problem)
# get.state(c(5, 4), problem)
# get.state(c(5, 5), problem)
# get.state(c(5, 6), problem)
# get.state(c(5, 7), problem)
# 
# #fila 6
# get.state(c(6, 1), problem)
# get.state(c(6, 2), problem)
# get.state(c(6, 3), problem)
# get.state(c(6, 4), problem)
# get.state(c(6, 5), problem)
# get.state(c(6, 6), problem)
# get.state(c(6, 7), problem)
# 
# #fila 7
# get.state(c(7, 1), problem)
# get.state(c(7, 2), problem)
# get.state(c(7, 3), problem)
# get.state(c(7, 4), problem)
# get.state(c(7, 5), problem)
# get.state(c(7, 6), problem)
# get.state(c(7, 7), problem)



# state = c(1,1)
# get.state(c(state[1],state[2]+1),problem)


# state = c(1,2)
# get.state(state,problem)

# Analyzes if an action can be applied in the received state.
# Estado lo que varia y problema lo que mantiene estatico
is.applicable <- function (state, action, problem) {
  result <- FALSE # Default value is FALSE.
  
  # state = c(7,7)
  # action = "Up"
  
  if (action == "Up") {
    condicion1 <- 0 < state[1]-1 #filas - comprobación de que no esta en el tope de arriba
    #Se compara con el 0 porque, al empezar por la esquina izquierda superior, al ejecutar UP te posicionarías en X=0 y 0 indica out of bounds.
    #state[1] indica posición x actual y -1 el movimiento que se va a realizar con respecto de la coordenada X.
    #Se comprueba si se puede accionar UP (si no estás en la fila 1 y tienes margen de maniobra)
    
    if (!condicion1) return(F)  #Si no hay margen de maniobra
    condicion2 <- get.state(state,problem) != get.state(c(state[1]-1,state[2]),problem)  #Si es posible ejecutar UP, devuelve TRUE si finalmente se lleva a cabo (posición inicial y después de ejecución resultan distintas)
    if (condicion2) return(T)
  }
  
  # state = c(1,1)
  # action = "Down"
  
  if (action == "Down") {
    condicion1 <- problem$size[1] > state[1]+1 #filas - comprobación de que no está en el tope de abajo - tamaño de la matriz vs posición en X + 1 (alcance que se espera obtener después de ejecutar la acción)
    if (!condicion1) return(F)  #Si no hay margen de maniobra
    condicion2 <- get.state(state,problem) != get.state(c(state[1]+1,state[2]),problem)
    if (condicion2) return(T)  
  }
  
  # state = c(1,1)
  # action = "Left"
  
  if (action == "Left") {
    condicion1 <- 0 < state[2]-1 #columnas - comprobación de que no está en el tope de la izquierda - 0 (tope eje Y - 1) vs posición en Y - 1 (alcance que se espera obtener después de ejecutar la acción)
    if (!condicion1) return(F)
    condicion2 <- get.state(state,problem) != get.state(c(state[1],state[2]-1),problem)
    if (condicion2) return(T)
  }
  
  state = c(7,1)
  #action = "Right"
  if (action == "Right") {
    condicion1 <- problem$size[2] > state[2]+1 #columnas - comprobación de que no está en el tope de la derecha - tamaño de la matriz en eje Y vs posición en Y + 1 (alcance que se espera obtener después de ejecutar la acción)
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