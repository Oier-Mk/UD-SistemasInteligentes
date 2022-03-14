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
source("../algorithms/blind/breadth-first-search.R")
source("../algorithms/blind/depth-first-search.R")
source("../algorithms/blind/depth-limited-search.R")
source("../algorithms/blind/iterative-deepening-search.R")

# Include functions for data analysis and result plot
source("../algorithms/results-analysis/analyze-results.R")

source("../problem/Laberinto.R")
problem <- initialize.problem("../data/feet-maze-1a.txt")

v <- problem$state_initial 
# v = c(1, 1)
is.applicable(v,"Up",problem)
is.applicable(v,"Down",problem)
is.applicable(v,"Left",problem)
is.applicable(v,"Right",problem)

# bfs_gs <- breadth.first.search(problem, max_iterations = 2500, count_print = 1000, graph_search = TRUE)



bfs_ts <- breadth.first.search(problem, max_iterations = 2500, count_print = 1000)
bfs_gs <- breadth.first.search(problem, max_iterations = 2500, count_print = 1000, graph_search = TRUE)

dfs_ts <- depth.first.search(problem, max_iterations = 2500, count_print = 1000)
dfs_gs <- depth.first.search(problem, max_iterations = 2500, count_print = 1000, graph_search = TRUE)
dls6_ts <- depth.limited.search(problem, depth_limit = 6, max_iterations = 2500, count_print = 1000)
dls6_gs <- depth.limited.search(problem, depth_limit = 6, max_iterations = 2500, count_print = 1000, graph_search = TRUE)
dls10_ts <- depth.limited.search(problem, depth_limit = 49, max_iterations = 2500, count_print = 1000)
dls10_gs <- depth.limited.search(problem, depth_limit = 49, max_iterations = 2500, count_print = 1000, graph_search = TRUE)
ids_ts <- iterative.deepening.search(problem, max_iterations = 2500, count_print = 1000)
ids_gs <- iterative.deepening.search(problem, max_iterations = 2500, count_print = 1000, graph_search = TRUE)
# ucs_ts <- uniform.cost.search(problem, max_iterations = 2500, count_print = 1000)
# ucs_gs <- uniform.cost.search(problem, max_iterations = 2500, count_print = 1000, graph_search = TRUE)
# bfs_ts <- greedy.best.first.search(problem, max_iterations = 2500, count_print = 1000)
# bfs_gs <- greedy.best.first.search(problem, max_iterations = 2500, count_print = 1000, graph_search = TRUE)

# Analyze the result of all the executions
results <- analyze.results(list(bfs_ts, bfs_gs,
                                dfs_ts, dfs_gs,
                                dls6_ts, dls6_gs,
                                dls10_ts, dls10_gs,
                                ids_ts, ids_gs), problem)
# Print results in an HTML Table
kable_material(kbl(results, caption = "Laberinto"), c("striped", "hover"))
