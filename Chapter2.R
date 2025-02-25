x <- c(-1.2, -0.9, -0.7, -0.5, -0.3, 0, 0.3, 0.5, 0.7, 0.9, 1.2)
x

y <- x^3
y
qplot(x, y)

x <- c(2, 3, 3, 3, 4, 4)
qplot(x, binwidth = 1)

x2 <- c(1, 1, 1, 2, 2, 2, 3, 3, 3, 3, 4, 5)
qplot(x2, binwidth = 1)

x3 <- c(0, 1, 2, 2, 2, 3, 3, 4, 5)

replicate(3, 2 + 2)

roll <- function() {
  die <- 1:6
  dice <- sample(die, size = 2, replace = TRUE)
  sum(dice)
}

replicate(10, roll())

roll <- function() {
  die <- 1:6
  dice <- sample(die, size = 2, replace = TRUE, 
                 prob = c(1/10, 1/10, 1/10, 1/10, 1/10, 1/2))
  sum(dice)
}

rolls <- replicate(10000, roll())
qplot(rolls, binwidth = 1)
