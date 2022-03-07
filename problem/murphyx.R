# =======================================================================
# Group Name:
# Students:
# =======================================================================
# You must implement the different functions according to your problem.
# You cannot modify the function headers because they are used by the 
# search algorithms. If you modify any headers the algorithms may not work.
# =======================================================================

# This function must return a list with the information needed to solve the problem.
# (Depending on the problem, it should receive or not parameters)
initialize.problem <- function(vec = c(7, 8, 7, 6, 8, 4, 4, 5, 5)) {
  
  #vec = c(7, 8, 7, 6, 8, 4, 4, 5, 5)
  
  # This attributes are compulsory
  # problem$name              <- <INSERT CODE HERE>
  problem$name                <- paste0("Murphys problem")
  # problem$state_initial     <- <INSERT CODE HERE>
  nix = vec[length(vec)]
  vec = head( vec, -1)
  # problem$state_final       <- <INSERT CODE HERE>
  problem$state_final         <- NULL
  
  # problem$actions_possible  <- <INSERT CODE HERE>
  problem$actions_possible  <- data.frame(direction = c("C1", "C2", "C3", "C4", "C5", "C6", "C7", "C8"), stringsAsFactors = FALSE)
  
  # You can add additional attributes
  # problem$<aditional_attribute>  <- <INSERT CODE HERE>
  
  return(problem)
}

# Analyzes if an action can be applied in the received state.
is.applicable <- function (state, action, problem) {
  result <- FALSE # Default value is FALSE.
  result <- TRUE #NO HAY RAZON PARA NO CAMBIAR DE POSTURA
  return(result)
}

# Returns the state resulting on applying the action over the state
effect <- function (state, action, problem) {
  result <- state # Default value is the current state.
  if (action == "C1") {
    result[1] <- abs( result[1] - 9 )
    return(result)
  }
  if (action == "C2") {
    result[2] <- abs( result[2] - 9 )
    return(result)
  }
  if (action == "C3") {
    result[3] <- abs( result[3] - 9 )
    return(result)
  }
  if (action == "C4") {
    result[4] <- abs( result[4] - 9 )
    return(result)
  }
  if (action == "C5") {
    result[5] <- abs( result[5] - 9 )
    return(result)
  }
  if (action == "C6") {
    result[6] <- abs( result[6] - 9 )
    return(result)
  }
  if (action == "C7") {
    result[7] <- abs( result[7] - 9 )
    return(result)
  }
  if (action == "C8") {
    result[8] <- abs( result[8] - 9 )
    return(result)
  }
  
  return(result)
}

# Analyzes if a state is final or not
is.final.state <- function (state, final_satate, problem) {
  
  result <- FALSE # Default value is FALSE.
  sum = sum(state)
  dec = as.integer(sum/10)
  num = sum%%10
  sum = num+dec
  if (sum == nix) result = TRUE
  
  return(result)
}

# Transforms a state into a string
to.string = function (state, problem) {
  
  # <INSERT YOUR CODE HERE TO GENERATE A STRING THAT REPRESENTS THE STATE> 
}

# Returns the cost of applying an action over a state
get.cost <- function (action, state, problem) {
  
  # <INSERT YOUR CODE HERE TO RETURN THE COST OF APPLYING THE ACTION ON THE STATE> 
  
  return(1) # Default value is 1.
}

# Heuristic function used by Informed Search Algorithms
get.evaluation <- function(state, problem) {
  
  # <INSERT YOUR CODE HERE TO RETURN THE RESULT OF THE EVALUATION FUNCTION>
  
	return(1) # Default value is 1.
}