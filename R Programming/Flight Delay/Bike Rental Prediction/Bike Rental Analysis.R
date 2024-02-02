library(tidyverse)
library(openxlsx)
library(VIM)
library(dplyr)
library(caret)
library(ggplot2)

#1.Exploratory data analysis:

# 1.1.Specify the path to your Excel file
excel_path <- "E:\\R_PROGRAMMING\\Project\\Bike Rental Prediction\\Dataset\\1657875746_day.xlsx"
# Read the Excel file into a variable named 'data'
bike_data <- read.xlsx(excel_path)
# Convert 'dteday' to Date format
bike_data$dteday <- as.Date(as.numeric(bike_data$dteday), origin = "1899-12-30")
# Verify the result
print(head(bike_data$dteday))
# Display the first few rows of the dataset
head(bike_data)


# 1.2.Perform data type conversion of the attributes
# Display the structure of the dataset before conversion
str(bike_data)
# Convert 'dteday' to Date format
bike_data <- bike_data %>%
  mutate(dteday = as.Date(dteday, format = "%d-%m-%Y"))
# Convert 'season' to factor (assuming it represents seasons)
bike_data <- bike_data %>%
  mutate(season = as.factor(season))
# Display the structure of the dataset after conversion
str(bike_data)

# 1.3.Carry out the missing value analysis
# Display a summary of missing values
print("Summary of missing values:")
print(aggr(bike_data, col=c('navajowhite1','coral3'), numbers=TRUE, sortVars=TRUE,
           labels=names(bike_data), cex.axis=.7, gap=3, ylab=c("Histogram of missing data","Pattern")))
# Display the number of missing values for each column
missing_values <- colSums(is.na(bike_data))
print("Number of missing values for each column:")
print(missing_values[missing_values > 0])
# Display columns with missing values and their counts
print("Columns with missing values:")
print(names(missing_values[missing_values > 0]))
# Display percentage of missing values for each column
missing_percentage <- (missing_values / nrow(bike_data)) * 100
print("Percentage of missing values for each column:")
print(missing_percentage)


# 2. Attributes distributions and trends

# 2.1.Plot monthly distribution of the total number of bikes rented
# Convert 'dteday' to Date format if not done already
bike_data$dteday <- as.Date(bike_data$dteday, format = "%d-%m-%Y")
# Extract month from the 'dteday' column
bike_data$month <- format(bike_data$dteday, "%m")
# Calculate the total number of bikes rented for each month
monthly_total <- bike_data %>%
  group_by(month) %>%
  summarise(total_bikes = sum(cnt))
# Plot the monthly distribution
ggplot(monthly_total, aes(x = month, y = total_bikes)) +
  geom_bar(stat = "identity", fill = "skyblue", color = "black") +
  labs(title = "Monthly Distribution of Total Bikes Rented",
       x = "Month",
       y = "Total Bikes Rented") +
  theme_minimal()


# 2.2.Plot yearly distribution of the total number of bikes rented
# Extract year from the 'dteday' column
bike_data$year <- format(bike_data$dteday, "%Y")
# Calculate the total number of bikes rented for each year
yearly_total <- bike_data %>%
  group_by(year) %>%
  summarise(total_bikes = sum(cnt))
# Plot the yearly distribution
ggplot(yearly_total, aes(x = year, y = total_bikes)) +
  geom_bar(stat = "identity", fill = "skyblue", color = "black") +
  labs(title = "Yearly Distribution of Total Bikes Rented",
       x = "Year",
       y = "Total Bikes Rented") +
  theme_minimal() 


# 2.3.Plot boxplot for outliers analysis
# Create a boxplot for outliers analysis
ggplot(bike_data, aes(x = "", y = cnt)) +
  geom_boxplot(fill = "skyblue", color = "black", outlier.color = "red") +
  labs(title = "Boxplot for Outliers Analysis",
       y = "Total Bikes Rented") +
  theme_minimal() +
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())


# 3. Split the dataset into train and test dataset

# Set a seed for reproducibility
set.seed(123)
# Use createDataPartition to split the data
index <- createDataPartition(y = bike_data$cnt, p = 0.8, list = FALSE)
# Create the training set
train_data <- bike_data[index, ]
# Create the test set (excluding rows in the training set)
test_data <- bike_data[-index, ]


# 4. Create a model using the random forest algorithm

# Install and load the relevant library
install.packages("randomForest")
library(randomForest)
# Set a seed for reproducibility
set.seed(123)
# Create the random forest model
rf_model <- randomForest(cnt ~ ., data = train_data, ntree = 100)
# Print the summary of the model
print(rf_model)

#5. Predict the performance of the model on the test dataset

# Predict the 'cnt' variable using the random forest model
predictions <- predict(rf_model, newdata = test_data)
# Compare predictions with actual values
comparison <- data.frame(Actual = test_data$cnt, Predicted = predictions)
# Display the comparison
print(head(comparison))








