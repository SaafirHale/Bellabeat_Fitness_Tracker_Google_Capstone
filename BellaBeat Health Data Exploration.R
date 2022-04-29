install.packages('tidyverse')
install.packages('ggplot2')
install.packages("dplyr")

#Loading required packages
library(dplyr)
library(tidyverse)
library(ggplot2)

#Reading in both data sets
DailyActivity <- read.csv("dailyActivity_merged.csv")
SleepDaily <- read.csv("sleepDay_merged.csv")

#Peek at DailyActivity table
head(DailyActivity)

#List of columns in the table
colnames(DailyActivity)

#Peek at SleepDaily table
head(SleepDaily)

#List of columns in the table
colnames(SleepDaily)

#A look at how many unique IDs there are in both tables
n_distinct(DailyActivity$Id)
n_distinct(SleepDaily$Id)

#Number rows in the tables
nrow(DailyActivity)
nrow(SleepDaily)

DailyActivity %>% 
  select(TotalSteps,
         VeryActiveMinutes,
         FairlyActiveMinutes,
         LightlyActiveMinutes,
         SedentaryMinutes,
         TotalDistance,
         Calories) %>% 
  summary()

SleepDaily %>% 
  select(TotalSleepRecords,
         TotalMinutesAsleep,
         TotalTimeInBed) %>% 
  summary()

CombinedData <- merge(DailyActivity, SleepDaily, by = 'Id')
n_distinct(CombinedData)

# Exploring relationships between TotalSteps, TotalDistance, Calories,
# SedentaryMinutes, and TotalMinutesAsleep.
ggplot(data = DailyActivity, aes(x = TotalSteps, y = TotalDistance)) + geom_point() +
  geom_smooth(method = 'lm', col = 'black')

#Calories(Calories) to sleep(TotalMinutesAsleep) 
ggplot(data = CombinedData, aes(x = TotalSteps, y = Calories)) + geom_point() +
  geom_smooth(method = 'lm', col = 'black')

ggplot(data = CombinedData, aes(x = TotalDistance, y = Calories)) + geom_point() +
  geom_smooth(method = 'lm', col = 'black')

ggplot(data = CombinedData, aes(x = TotalSteps, y = SedentaryMinutes)) + geom_point() +
  geom_smooth(method = 'lm', col = 'black')

ggplot(data = CombinedData, aes(x = TotalDistance, y = SedentaryMinutes)) + geom_point() +
  geom_smooth(method = 'lm', col = 'black')

ggplot(data = CombinedData, aes(x = Calories, y = SedentaryMinutes)) + geom_point() +
  geom_smooth(method = 'lm', col = 'black')

#sleep(TotalMinutesAsleep) to Activity(Very/Fairly/Lightly/Sedentary Active Minutes)
ggplot(data = CombinedData, aes(x = TotalSteps, y = TotalMinutesAsleep)) + geom_point() +
  geom_smooth(method = 'lm', col = 'black')

ggplot(data = CombinedData, aes(x = TotalDistance, y = TotalMinutesAsleep)) + geom_point() +
  geom_smooth(method = 'lm', col = 'black')

ggplot(data = CombinedData, aes(x = Calories, y = TotalMinutesAsleep)) + geom_point() +
  geom_smooth(method = 'lm', col = 'black')

ggplot(data = CombinedData, aes(x = SedentaryMinutes, y = TotalMinutesAsleep)) + geom_point() +
  geom_smooth(method = 'lm', col = 'black')
