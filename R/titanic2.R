training <- read.csv("../Data/train.csv")
testing <- read.csv("../Data/test.csv")

# Pull out Survived column for later use
trainingSurvived <- training[,2]

# All data, both training and test set
all_data <- rbind(training[,-2], testing)

# Passenger on row 62 and 830 do not have a value for embarkment. 
# Since many passengers embarked at Southampton, we give them the value S.
all_data$Embarked[c(62, 830)] <- "S"

# Factorize embarkment codes.
all_data$Embarked <- factor(all_data$Embarked)

# Passenger on row 1044 has an NA Fare value. Let's replace it with the median fare value.
all_data$Fare[1044] <- median(all_data$Fare, na.rm = TRUE)

# How to fill in missing Age values?
# We make a prediction of a passengers Age using the other variables and a decision tree model. 
# This time you give method = "anova" since you are predicting a continuous variable.
library(rpart)
predicted_age <- rpart(Age ~ Pclass + Sex + SibSp + Parch + Fare + Embarked,
                       data = all_data[!is.na(all_data$Age),], method = "anova")
all_data$Age[is.na(all_data$Age)] <- predict(predicted_age, all_data[is.na(all_data$Age),])

# Split the data back into a train set and a test set
training <- all_data[1:891,]
testing <- all_data[892:1309,]

# Add Survived column back into training
training$Survived = trainingSurvived

# Load in the package
library(randomForest)

# Set seed for reproducibility
set.seed(111)

# Apply the Random Forest Algorithm
my_forest <- randomForest(as.factor(Survived) ~ Pclass + Sex + Age, data=training)

# Make your prediction using the test set
my_prediction <- predict(my_forest, testing)

# Create a data frame with two columns: PassengerId & Survived. 
my_solution <- data.frame(PassengerId = testing$PassengerId, Survived = my_prediction)

# Write csv for submission
write.csv(my_solution, "my_solution2.csv", row.names = FALSE)
