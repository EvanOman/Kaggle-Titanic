setwd("~/Dev/Kaggle/Titanic/R")
# 
# # Load in the packages to create a fancified version of your tree
# library(rattle)
# library(rpart.plot)
# library(RColorBrewer)
# 
# train <- read.csv("../Data/train.csv")
# test <- read.csv("../Data/test.csv")
# 
# # Build the decision tree
# my_tree_two <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, data = train, method = "class")
# 
# 
# # Time to plot your fancified tree
# pdf("decisionPlot.pdf")
# fancyRpartPlot(my_tree_two)
# dev.off()
# 
# # Make your prediction using the test set
# my_prediction <- predict(my_tree_two, test, type = "class")
# 
# # Create a data frame with two columns: PassengerId & Survived. Survived contains your predictions
# my_solution <- data.frame(PassengerId = test$PassengerId, Survived = my_prediction)
# 
# # Check that your data frame has 418 entries
# nrow(my_solution)
# 
# # Write your solution to a csv file with the name my_solution.csv
# write.csv(my_solution, file = "my_solution.csv", row.names = FALSE)

library(caret)
library(ggplot2)
library(randomForest)

train <- read.csv("../Data/train.csv")

rf_model<-train(Survived~.,data=train,method="rf",
				trControl=trainControl(method="cv",number=5),
				prox=TRUE,allowParallel=TRUE)
print(rf_model)

print(rf_model$finalModel)

my_prediction <- predict(rf_model, test, type="class")

my_sol2 <- data.frame(PassengerId = test$PassengerId, Survived = my_prediction)
