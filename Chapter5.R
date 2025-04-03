#Extract the face column of deck2
face_column <- deck2$face

#Test whether each value is equal to "ace"
is_ace <- face_column == "ace"

#Count how many are true
num_aces <- sum(is_ace)

print(is_ace)
print(num_aces)


#Find the hearts
hearts_filter <- deck4$suit == "hearts"

#Assign a value of 1 to those rows in the value column
deck4$value[hearts_filter] <- 1

print(deck4[hearts_filter, ])


w <- c(-1, 0, 1)
x <- c(5, 15)
y <- "February"
z <- c("Monday", "Tuesday", "Friday")
w > 0
x > 10 & x < 20
y == "February"
weekdays <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")
all(z %in% weekdays)


