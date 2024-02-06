#1. Exploratory data analysis:
# Specify the path to your Excel file
excel_path <- "E:\\R_PROGRAMMING\\Project\\1657873325_flightdelays.xlsx"

# Read the Excel file into a variable named 'data'
library(openxlsx)
Flight_data <- read.xlsx(excel_path)

# Understand the data
head(Flight_data) #View the first few rows of the dataset.
dim(Flight_data) #Show the dimensions (rows, columns) of the dataset.

# Find out the null values
is.na(Flight_data) # Returns a logical matrix indicating NA (missing) values.
colSums(is.na(Flight_data)) # Sum of NA values for each column.
any(is.na(Flight_data)) # Check if there are any missing values in the entire dataset.


#2. Install the required packages
# Install and load the 'tidyverse' package (includes ggplot2, dplyr, tidyr, etc.)
install.packages("tidyverse")
library(tidyverse)
# Install and load the 'openxlsx' package for reading Excel files
install.packages("openxlsx")
library(openxlsx)
# Install and load the 'skimr' package for summary statistics
install.packages("skimr")
library(skimr)


#3. Understand the summary of descriptive statistics
summary(Flight_data) #Get summary statistics for each variable.
skim(Flight_data) # Display detailed summary statistics


#4. Plot the histograms to understand the relationships between scheduled time, 
#carrier, destination, origin, weather, and day of the wee
library(ggplot2)

# histogram for scheduled time
ggplot(Flight_data, aes(x = schedtime)) +
  geom_histogram(binwidth = 30, fill = "skyblue", color = "black") +
  labs(title = "Histogram of Scheduled Time", x = "Scheduled Time (minutes)", y = "Frequency")

# histogram for day of the week
ggplot(Flight_data, aes(x = dayweek)) +
  geom_bar(fill = "skyblue", color = "black") +
  labs(title = "Histogram of Day of the Week", x = "Day of the Week", y = "Frequency")

# histograms for carrier
ggplot(Flight_data, aes(x = carrier)) +
  geom_bar(fill = "skyblue", color = "black") +
  labs(title = "Histogram of Carrier", x = "Carrier", y = "Frequency") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Rotate x-axis labels for better readability

# histogram for Destination
ggplot(Flight_data, aes(x = dest)) +
  geom_bar(fill = "skyblue", color = "black") +
  labs(title = "Histogram of Destination", x = "Destination", y = "Frequency") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Rotate x-axis labels for better readability

# histogram for origin
ggplot(Flight_data, aes(x = origin)) +
  geom_bar(fill = "skyblue", color = "black") +
  labs(title = "Histogram of Origin", x = "Origin", y = "Frequency") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Rotate x-axis labels for better readability

# histogram for weathers 
ggplot(Flight_data, aes(x = weather)) +
  geom_bar(fill = "skyblue", color = "black") +
  labs(title = "Histogram of Weather", x = "Weather", y = "Frequency") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Rotate x-axis labels for better readability



#5. Plot the scatter plot for flights on time and delayed

# scatter plot for flights on time and delayed
ggplot(Flight_data, aes(x = schedtime, y = distance, color = as.factor(delay))) +
  geom_point() +
  labs(title = "Scatter Plot of Flights on Time and Delayed",
       x = "Scheduled Time",
       y = "Delay",
       color = "Delayed") +
  scale_color_manual(values = c("blue", "red"))  # Set colors for on time and delayed points


#6. Plot the box plot to understand how many days in a month flights are delayed by what time
# Create a box plot for delayed flights by day of the month
ggplot(Flight_data, aes(x = as.factor(daymonth), y = deptime, fill = delay)) +
  geom_boxplot() +
  labs(title = "Box Plot of Delayed Flights by Day of the Month")

#7. Define the hours of departure

Flight_data$departure_hour <- as.integer(Flight_data$deptime / 100)
head(Flight_data)

#8. Create a categorical representation of data using a table

Flight_data$time_of_day <- ifelse(Flight_data$departure_hour >= 5 & Flight_data$departure_hour < 10 , "Morning",
                                  ifelse(Flight_data$departure_hour >= 10 & Flight_data$departure_hour < 16 , "Afternoon",
                                         ifelse(Flight_data$departure_hour >= 16 & Flight_data$departure_hour < 21 , "Evening","Night"))) 


#9. Redefine the delay variables
frequency_of_flight <- table(Flight_data$time_of_day)
# Create a new binary variable 'delayed' indicating whether the flight is delayed
Flight_data$delayed_numeric <- ifelse(Flight_data$deptime > Flight_data$schedtime, 1, 0)

#10. Understand the summary of major variables
summary(Flight_data[c("schedtime",	"deptime",	"distance",	"weather",	"dayweek",	"daymonth",	"delayed_numeric")])

# Display the structure of the data frame
str(Flight_data)


#11. Plot histograms of major variables
install.packages("plotrix")
library(plotrix)
install.packages("rgl")
library(rgl)
install.packages("plotly")
library(plotly)

#count of ontime and delayed of flights
delay_proportions <- table(Flight_data$delay)

# Create a 3D pie chart
pie3D(delay_proportions,main = "Propotion of delayed and ontime flights",labels = names(delay_proportions))

fig = plot_ly(labels = c("Ontime", "Delayed"), values = delay_proportions, type = "pie", text = c("Ontime", "Delayed")) %>%
  layout(title = "Proportion of Delayed and On-time Flights")
# Show the plot
fig

# Create a 3D histogram for 'schedtime'
fig1 <- plot_ly(data = Flight_data, x = ~schedtime, type = "histogram", 
                colors = c("skyblue", "black"), opacity = 0.7) %>%
  layout(title = "Distribution of Schedtime",
         scene = list(xaxis = list(title = "Scheduled Time (minutes)"),
                      yaxis = list(title = "Frequency"),
                      zaxis = list(title = "Count")))
# Show the plot
fig1

# Create a 3D histogram for 'carrier'
fig2 <- plot_ly(data = Flight_data, x = ~carrier, type = "histogram", 
                colors = c("skyblue", "black"), opacity = 0.7) %>%
  layout(title = "Distribution of Carrier",
         scene = list(xaxis = list(title = "Carrier"),
                      yaxis = list(title = "Frequency"),
                      zaxis = list(title = "Count")))
# Show the plot
fig2

# Create a 3D histogram for 'origin'
fig3 <- plot_ly(data = Flight_data, x = ~origin, type = "histogram", 
                colors = c("skyblue", "black"), opacity = 0.7) %>%
  layout(title = "Distribution of Origin",
         scene = list(xaxis = list(title = "Origin"),
                      yaxis = list(title = "Frequency"),
                      zaxis = list(title = "Count")))
# Show the plot
fig3

#12. Plot a pie chart to see how many flights were delayed
# Create a box plot for flight delays across days of the month
fig4 <- plot_ly(Flight_data, x = ~as.factor(daymonth), y = ~deptime, color = ~delay, type = "box") %>%
  layout(title = "Box plot of flight delays across days of the month")
# Show the plot
fig4



