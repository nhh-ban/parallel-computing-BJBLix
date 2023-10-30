
# This script is used to measure the run time of three scripts,
# comparing which method is most efficient

#loading packages
library(tictoc)
library(tidyverse)


# Reusing the TicToc function
printTicTocLog <-
  function() {
    tic.log() %>%
      unlist %>%
      tibble(logvals = .) %>%
      separate(logvals,
               sep = ":",
               into = c("Function type", "log")) %>%
      mutate(log = str_trim(log)) %>%
      separate(log,
               sep = " ",
               into = c("Seconds"),
               extra = "drop")
  }

tic.clearlog()

# Checking if the function is working as intended
tic("Test")
Sys.sleep(1)
toc(log = TRUE)

#saving to a table
printTicTocLog() %>%
  knitr::kable()

# now timing the base script, before making any changes 
tic("Base_script")
source("scripts/hw4_solution.r")
toc(log = TRUE)
printTicTocLog() %>%
  knitr::kable()


# we will then check the revised script using parallel computing
tic("Method 1")
source("Scripts/Method1_parallel_computing.r")
toc(log = TRUE)
printTicTocLog() %>%
  knitr::kable()

# now doing this for the mMTweedieTests
tic("Method 2")
source("Scripts/Method2_parallel_computing.r")
toc(log = TRUE)
printTicTocLog() %>% 
  knitr::kable()
