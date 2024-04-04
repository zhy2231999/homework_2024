## ---------------------------
##
## Script name: machine learning
##
## Purpose of script:creating a regression model of mpg as target 
## and others as features (from a built-in dataset of mtcars) using 
## random forest algorithm with caret package, and writing the code.
##
## Author: 张红艳
## 
## Emai: zhanghongyan@mail.ustc.edu.cn
##
## Date Created:20240403

#---------加载安装包和需要处理的数据---------
#加载安装包
install.packages(c("caret", "skimr", "randomForest"))
library(caret)
library(skimr)
library(randomForest)

#加载数据并定义包含mtcars数据集的数据框,查看数据结构特征
data(mtcars)   
df <- mtcars   
str(df)
head(df)


#---------数据分类及预处理---------
#使用createDataPartition()函数划分trainData和testData
set.seed(100)
trainRowNumbers <- createDataPartition(df$mpg, p =0.7, list = FALSE)
trainData<- df[trainRowNumbers,]
testData <- df[-trainRowNumbers,]

#使用skimr函数查找trainData缺失值，结果没有缺失值，不需要额外赋值
skimmed <- skim(trainData)
skimmed  


#---------可视化feature重要性---------
#使用randomForest() 函数构建随机森林模型
set.seed(100)
rf_model <- randomForest(mpg ~., data = trainData, importance = TRUE)

#使用importance() 函数计算每个feature的重要性
importance_df <- importance(rf_model)

#使用varImpPlot()函数可视化feature重要性
varImpPlot(rf_model)

# 使用trainControl进行交叉验证
trControl <- trainControl(method = "cv", number = 10)

# 使用train()函数进行特征选择和训练模型
set.seed(100)
model <- train(mpg ~., data = trainData, method = "rf", trControl = trControl, importance = TRUE)

# 再次查看feature重要性
importance_final <- varImp(model, scale = FALSE)

# 可视化最终的feature重要性
plot(importance_final)


#---------测试模型---------
# 使用训练好的模型对testData进行预测
testData$rf_tree.pred <- predict(rf_model, newdata = testData)


#---------模型评估---------
Metrics::rmse(testData$mpg, testData$rf_tree.pred)


