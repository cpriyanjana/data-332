chapter 4 assignment 

# Selecting Values
deck[ , ]  # Selecting all rows and columns

# Positive Integers
head(deck)  # Display first few rows
deck[1, 1]  # First row, first column
deck[1, c(1, 2, 3)]  # First row, first three columns

new <- deck[1, c(1, 2, 3)]
new  # Print selected row subset

# Repetition
deck[c(1, 1), c(1, 2, 3)]  # Select first row twice

# Vectors in R
vec <- c(6, 1, 3, 6, 10, 5)
vec[1:3]  # Select first three elements

# Learning to use drop = FALSE
deck[1:2, 1:2]  # Select submatrix
deck[1:2, 1]  # Select first column (drops to vector)
deck[1:2, 1, drop = FALSE]  # Keep column as a data frame

# Negative Integers
deck[-(2:52), (1:3)]  # Select first row only
deck[0, 0]  # Returns an empty data frame

# Blank Spaces
deck[1, ]  # First row, all columns

# Logical Values
deck[1, c(TRUE, TRUE, FALSE)]  # Select first two columns

rows <- c(TRUE, rep(FALSE, 51))
deck[rows, ]  # Select first row using logical indexing

# Names
deck[1, c("face", "suit", "value")]  # Select by column names
deck[ , "value"]  # Select entire 'value' column

# Exercise-1: Complete the deal function
deal <- function(cards) {
  cards[1, ]  # Select the first row
}

deal(deck)

# Shuffle the deck
deck2 <- deck[1:52, ]
head(deck2)

# Rearranging rows in different order
deck3 <- deck[c(2, 1, 3:52), ]
head(deck3)

# Generating random order for shuffling
random <- sample(1:52, size = 52)
deck4 <- deck[random, ]
head(deck4)

# Exercise-2: Shuffle function
shuffle <- function(cards) {
  random <- sample(1:nrow(cards), size = nrow(cards))  # Ensure it works for any number of rows
  cards[random, ]
}

# Shuffling and dealing
deck2 <- shuffle(deck)
deal(deck2)

# Dollar Sign and Double Brackets
deck$value  # Access column using $

mean(deck$value)  # Calculate mean of 'value' column
median(deck$value)  # Calculate median

# Lists in R
lst <- list(numbers = c(1,2), logical = TRUE, strings = c("a", "b", "c"))
lst

# Subsetting lists
lst[1]  # Returns a list
sum(lst[1])  # Error: trying to sum a list

lst$numbers  # Extracts numeric vector
sum(lst$numbers)  # Sums the numbers

lst[[1]]  # Extracts first element as a vector

# Single brackets vs double brackets
lst["numbers"]  # Returns a list with 'numbers'
lst[["numbers"]]  # Returns numeric vector
