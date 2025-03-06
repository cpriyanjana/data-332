library(tidyverse)
library(lubridate)
library(scales)
library(readxl)
library(stringr)

setwd("C:/Students")

course_df <- read_excel("course.xlsx")
registration_df <- read_excel("registration.xlsx")
student_df <- read_excel("student.xlsx")


registration_df <- registration_df %>%
  rename(Student_ID = `Student ID`, Instance_ID = `Instance ID`)

student_df <- student_df %>%
  rename(Student_ID = `Student ID`)

course_df <- course_df %>%
  rename(Instance_ID = `Instance ID`)

# Left Join merge
merged_df <- left_join(registration_df, student_df, by = "Student_ID") %>%
  left_join(course_df, by = "Instance_ID")

# Debugging to check for missing values
print("Merged dataset preview:")
print(head(merged_df))

# Ensure data validity
merged_df <- merged_df %>%
  mutate(`Birth Year` = year(as.Date(`Birth Date`)))

merged_df <- merged_df %>%
  mutate(Title = ifelse(is.na(Title), "Unknown Major", Title))

merged_df <- merged_df %>%
  mutate(`Payment Plan` = str_trim(as.character(`Payment Plan`)))

merged_df$`Payment Plan` <- factor(merged_df$`Payment Plan`, levels = c("Cash", "Loan", "Scholarship"))

# Pivot tables
# 1. Count of Students per Major
major_count <- merged_df %>%
  group_by(Title) %>%
  summarise(Student_Count = n())

# 2. Total Cost per Major, Segmented by Payment Plan
cost_per_major <- merged_df %>%
  group_by(Title, `Payment Plan`) %>%
  summarise(`Total Cost` = sum(`Total Cost`, na.rm = TRUE))

# 3. Total Balance Due per Major, Segmented by Payment Plan
balance_due_per_major <- merged_df %>%
  group_by(Title, `Payment Plan`) %>%
  summarise(`Balance Due` = sum(`Balance Due`, na.rm = TRUE))

# Checking totals for validation
print("Total Cost per Major Summary:")
print(sum(cost_per_major$`Total Cost`, na.rm = TRUE))

print("Total Balance Due Summary:")
print(sum(balance_due_per_major$`Balance Due`, na.rm = TRUE))

# CHART 1: Number of Students per Major
ggplot(major_count, aes(x = fct_reorder(Title, Student_Count), y = Student_Count, fill = Title)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = c("navy", "royalblue", "purple", "orangered", "forestgreen", "gold")) +
  labs(title = "Number of Students per Major", x = "Major", y = "Student Count") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# CHART 2: Birth Year Distribution
ggplot(merged_df %>% filter(!is.na(`Birth Year`)), aes(x = `Birth Year`)) +
  geom_density(fill = "tomato", alpha = 0.7, color = "black") +
  labs(title = "Distribution of Students by Birth Year", x = "Birth Year", y = "Density") +
  theme_minimal()

# CHART 3: Total Cost per Major by Payment Plan
ggplot(cost_per_major, aes(x = fct_reorder(Title, `Total Cost`), y = `Total Cost`, fill = `Payment Plan`)) +
  geom_bar(stat = "identity", position = "dodge") +
  scale_fill_manual(values = c("Cash" = "dodgerblue", "Loan" = "darkorange", "Scholarship" = "mediumseagreen")) +
  labs(title = "Total Cost per Major by Payment Plan", x = "Major", y = "Total Cost ($)") +
  scale_y_continuous(labels = dollar_format()) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# CHART 4: Line Graph for Balance Due per Major
ggplot(balance_due_per_major, aes(x = fct_reorder(Title, `Balance Due`), y = `Balance Due`, group = `Payment Plan`, color = `Payment Plan`)) +
  geom_line(size = 1) +
  geom_point(size = 3) +
  scale_color_manual(values = c("Cash" = "indianred", "Loan" = "steelblue", "Scholarship" = "forestgreen")) +
  labs(title = "Trend of Balance Due per Major by Payment Plan", x = "Major", y = "Balance Due ($)") +
  scale_y_continuous(labels = dollar_format()) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

#dev.off()

