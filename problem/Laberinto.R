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
initialize.problem <- function() {
  problem <- list() # Default value is an empty list.
  file = "~/Documents/Universidad De Deusto/2021-22/2do Semestre/Sistemas Inteligentes/data/laberinto.txt"
  # This attributes are compulsory
  problem$name                <- paste0("Laberinto - [", file, "]")
  problem$state_initial       <- read.csv(file, sep="\n", header = FALSE)
  problem$state_final         <- #array de L R consecutivos y posicion arriba a la dcha
  problem$actions_possible  <- data.frame(direction = c("Up", "Down", "Left", "Right"), stringsAsFactors = FALSE)


  return(problem)
}

# Analyzes if an action can be applied in the received state.
# Estado lo que varia y problema lo que mantiene estatico
is.applicable <- function (state, action, problem) {
  result <- FALSE # Default value is FALSE.
  
  #CONDICIONES PARA QUE SE HAGA O NO LA ACCI'ON
  
  if (action == "Up") {
    return(row != 1)
  }
  
  if (action == "Down") {
    return(row != problem$rows)
  }
  
  if (action == "Left") {
    return(col != 1)
  }
  
  if (action == "Right") {
    return(col != problem$columns)
  }
  return(result)
}

# Returns the state resulting on applying the action over the state
effect <- function (state, action, problem) {

  result <- state  
  
  if (action == "Up") {
    # TODO se modifica result
    return(result)
  }
  
  if (action == "Down") {    
    # TODO se modifica result
    return(result)
  }
  
  if (action == "Left") {
    # TODO se modifica resultreturn(result)
  }
  
  if (action == "Right") {
    # TODO se modifica resultreturn(result)
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