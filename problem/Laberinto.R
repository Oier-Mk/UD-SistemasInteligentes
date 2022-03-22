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
  # file = "/Users/mentxaka/Documents/Universidad De Deusto/2021-22/2do Semestre/Sistemas Inteligentes/data/feet-maze-1b.txt"
  # This attributes are compulsory
  problem$name                <- paste0("Laberinto - [", file, "]")
  problem$size                <- c(as.integer(read.csv(file, sep=";", header = FALSE, nrows=1)[1]),as.integer(read.csv(file, sep=";", header = FALSE, nrows=1)[2]))
  problem$table               <- read.csv(file, sep=";", header = FALSE, skip=1, nrows=problem$size[1])
  problem$state_initial       <- c(as.integer(substr(read.csv(file, sep=";", header = FALSE, skip=1+problem$size[1], nrows=1), 3,3))+1,as.integer(substr(read.csv(file, sep=";", header = FALSE, skip=1+problem$size[1], nrows=1), 1,1))+1)
  problem$state_final         <- c(as.integer(substr(read.csv(file, sep=";", header = FALSE, skip=2+problem$size[1], nrows=1), 3,3))+1,as.integer(substr(read.csv(file, sep=";", header = FALSE, skip=2+problem$size[1], nrows=1), 1,1))+1)
  problem$actions_possible    <- data.frame(direction = c("Up", "Down", "Left", "Right"), stringsAsFactors = FALSE)
  problem$left                <- read.csv(file, sep=";", header = FALSE, skip=3+problem$size[1], nrows=1)
  problem$right               <- read.csv(file, sep=";", header = FALSE, skip=4+problem$size[1], nrows=1)
  problem$up                  <- read.csv(file, sep=";", header = FALSE, skip=5+problem$size[1], nrows=1)
  problem$down                <- read.csv(file, sep=";", header = FALSE, skip=6+problem$size[1], nrows=1)

  return(problem)
    
}

get.state <- function(coordenadas, problem){
  return(problem$table[coordenadas[1],coordenadas[2]])      #fila, columna - se lee la matriz de izquierda a derecha y de arriba a abajo
}

transform.state <- function(state){
  #De c(x,y) -> "x,y"
  value <- c(state[2]-1,state[1]-1)
  result <- toString(value)
  result <- gsub(" ", "", result) 
  return(result)
}


# Analyzes if an action can be applied in the received state.
# Estado lo que varia y problema lo que mantiene estatico
is.applicable <- function (state, action, problem) {
  result <- FALSE # Default value is FALSE.

    if (action == "Up") {
    condicion1 <- 1 < state[1] #filas - comprobación de que no esta en el tope de arriba
    #Se compara con el 0 porque, al empezar por la esquina izquierda superior, al ejecutar UP te posicionarías en X=0 y 0 indica out of bounds.
    #state[1] indica posición x actual y -1 el movimiento que se va a realizar con respecto de la coordenada X.
    #Se comprueba si se puede accionar UP (si no estás en la fila 1 y tienes margen de maniobra)
    if (!condicion1) return(F)  #Si no hay margen de maniobra
    
    #"x,y" %in% dataframe
    condicion2 <- transform.state(state) %in% problem$up
    # print(condicion2)
    if (condicion2) return(F)
    
    condicion3 <- get.state(state,problem) != get.state(c(state[1]-1,state[2]),problem)  #Si es posible ejecutar UP, devuelve TRUE si finalmente se lleva a cabo (posición inicial y después de ejecución resultan distintas)
    if (condicion3) return(T)
  }
 
  if (action == "Down") {
    condicion1 <- problem$size[1] > state[1] #filas - comprobación de que no está en el tope de abajo - tamaño de la matriz vs posición en X + 1 (alcance que se espera obtener después de ejecutar la acción)
    if (!condicion1) return(F)  #Si no hay margen de maniobra
    
    #"x,y" %in% dataframe
    condicion2 <- transform.state(state) %in% problem$down
    # print(condicion2)
    if (condicion2) return(F)
    
    condicion3 <- get.state(state,problem) != get.state(c(state[1]+1,state[2]),problem)
    if (condicion3) return(T)  
  }
  
 
  if (action == "Left") {
    condicion1 <- 1 < state[2] #columnas - comprobación de que no está en el tope de la izquierda - 0 (tope eje Y - 1) vs posición en Y - 1 (alcance que se espera obtener después de ejecutar la acción)
    if (!condicion1) return(F)
    
    #"x,y" %in% dataframe
    condicion2 <- transform.state(state) %in% problem$left
    # print(condicion2)
    if (condicion2) return(F)
    
    condicion3 <- get.state(state,problem) != get.state(c(state[1],state[2]-1),problem)
    if (condicion3) return(T)
  }
  
   if (action == "Right") {
    condicion1 <- problem$size[2] > state[2] #columnas - comprobación de que no está en el tope de la derecha - tamaño de la matriz en eje Y vs posición en Y + 1 (alcance que se espera obtener después de ejecutar la acción)
    if (!condicion1) return(F)
    
    #"x,y" %in% dataframe
    condicion2 <- transform.state(state) %in% problem$right
    # print(condicion2)
    if (condicion2) return(F)
    
    condicion3 <- get.state(state,problem) != get.state(c(state[1],state[2]+1),problem)
    if (condicion3) return(T)
  }
  return(result)
}

# Returns the state resulting on applying the action over the state
effect <- function (state, action, problem) {

  result <- state  
  
  if (action == "Up") {
    result <- c(state[1]-1,state[2])
    return(result)
  }
  
  if (action == "Down") {    
    result <- c(state[1]+1,state[2])
    return(result)
  }
  
  if (action == "Left") {
    result <- c(state[1],state[2]-1)
    return(result)
  }
  
  if (action == "Right") {
    result <- c(state[1],state[2]+1)
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
  # print(state)
}
# Returns the cost of applying an action over a state
get.cost <- function (action, state, problem) {
  return(1) # Default value is 1.
}
# Heuristic function used by Informed Search Algorithms
get.evaluation <- function(state, problem) {
	return(1) # Default value is 1.
}