## ---------------------------
## Script name: data_exploration.R
##
## Purpose of script: 1) write a short code to remove the sites with missing data 
## of the Doubs dataset, and detect whether environmental factors are collinearity.
## 2) Analysis on the relationships between fishes and environment factors and 
## visualize such relationships.
##
## Author: 张红艳
## 
## Emai: zhanghongyan@mail.ustc.edu.cn
##
## Date Created:20240416
## ---------------------------


#--------读取并保存doubs数据--------
#分别读取doubs中的spe，env，spa数据
doubs.spe <- read.csv ('https://raw.githubusercontent.com/zdealveindy/anadat-r/master/data/DoubsSpe.csv', row.names = 1)
doubs.env <- read.csv ('https://raw.githubusercontent.com/zdealveindy/anadat-r/master/data/DoubsEnv.csv', row.names = 1)
doubs.spa <- read.csv ('https://raw.githubusercontent.com/zdealveindy/anadat-r/master/data/DoubsSpa.csv', row.names = 1)

#将读取的spe，env，spa数据以csv格式保存到本地方便后续直接读取
write.csv(doubs.spe,"data/spe.csv",row.names = TRUE)
write.csv(doubs.env,"data/env.csv",row.names = TRUE)  
write.csv(doubs.spa,"data/spa.csv",row.names = TRUE)

#加载csv格式的数据
env <- read.csv("data/env.csv",row.names = 1)
spe <- read.csv("data/spe.csv",row.names = 1)
spa <- read.csv("data/spa.csv",row.names = 1)


#--------删除Doubs数据集中缺失数据的站点--------
# 判断env,spe,spa数据中是否有缺失数据，结果均返回TRUE，表明没有缺失数据，无需删除
complete_rows <- complete.cases(env)
complete_rows <- complete.cases(spe)
complete_rows <- complete.cases(spa)


#--------检测环境因素是否共线性--------
#1)加载额外的panelutils.R，其中包含一些用于绘制图形的函数或者其他辅助函数
source("panelutils.R")
#建立新的绘图区域，在其上绘制平滑曲线和直方图，以检测环境因素是否共线性
dev.new(title="Bivariate descriptor plots")
op <- par(mfrow=c(1,1), pty="s") 
pairs(env, panel=panel.smooth, diag.panel=panel.hist,
      main="Bivariate Plots with Histograms and Smooth Curves")
par(op)
#需对所有环境变量标准化
# 所有环境变量标准化
# z-scores（Center and scale）
env.z <- decostand(env, "standardize")
apply(env.z, 2, mean)	
apply(env.z, 2, sd)		
# 使用scale() function函数对所有环境变量标准化
env.z <- as.data.frame(scale(env))

#2)使用 cor() 函数计算环境因子之间的相关系数，并检查它们之间的相关性。通常，
#相关系数绝对值大于 0.7 或0.8 可能表明存在较强的共线性。
# 计算相关系数矩阵
cor_matrix <- cor(env)
# 显示相关系数矩阵
print(cor_matrix)
# 查找高相关性的变量对
highly_correlated <- which(cor_matrix > 0.7 & cor_matrix < 1, arr.ind = TRUE)
print(highly_correlated)

#3)计算环境因子的方差膨胀因子VIF，以检测共线性,通常 VIF 大于 5 表示存在共线性
# 计算方差膨胀因子（VIF）,lm_model 是一个包含环境因子的线性回归模型
vif_values <- car::vif(lm_model)
# 显示 VIF 值
print(vif_values)
# 查找高 VIF 值的变量
high_vif <- which(vif_values > 5)  
print(high_vif)


#--------分析鱼类与环境因素的关系，并可视化--------
# 对环境因素数据进行分析
#加载包
library(vegan)
library(gclus)  
library(ape)
#显示环境因素数据的内容
summary(env)    
#全部环境因素数据的PCA分析
env.pca <- rda(env, scale=TRUE) 
env.pca
summary(env.pca) #默认scaling=2
summary(env.pca, scaling=1)
# 使用biplot（）函数绘制排序图 
par(mfrow=c(1,2))
biplot(env.pca, scaling=1, main="PCA-1型标尺")
biplot(env.pca, main="PCA-2型标尺")  # 默认 scaling = 2
