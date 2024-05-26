## ---------------------------
##
## Script name: data_manipul.R
##
## Purpose of script:Try to use tidyverse and ggplot2
##
## Author: zhanghongyan
## 
## Emai: zhanghongyan@mail.ustc.edu.cn
##
## Date Created:20240323
## ---------------------------
################调用tidyverse包
find.package("tidyverse")     #检查是否安装
install.packages("tidyverse") #若未安装则需要安装tidyverse
library(tidyverse)            #加载并查看tidyverse包

################导入和保存数据
download.file("https://ndownloader.figshare.com/files/2292169",
              "data/portal_data_joined.csv")    #下载示例数据

data<-read.csv("data/portal_data_joined.csv")   #读取示例数据
write.csv(data, "new_data.csv")                 #保存示例数据                           

################查看数据结构
str(data)     

################检查某个列或行是否缺少数据
is.na(data)                    #检查数据集中的缺失值
any(is.na(data$column_name))   #检查column_name列是否有缺失值
any(is.na(data[i, ]))          #检查第i行是否有缺失值


################从列中提取值或选择/添加列
selected_column <- data$column_name  #提取column_name所有的值
data$new_column <- 1:nrow(data)      #添加新列如new_column

################将宽表转换为长表
data_long <- gather(data,key=column_name,value=count)
#表示转换后的数据新增了两列，第一列key是列名，第二列是具体值

################数据可视化
#调用ggplot2
find.package("ggplot2")
install.packages("ggplot2")
library(ggplot2)

#采用ggplot2绘图
ggplot(data,aex(x=height,y=weight))+geom_point()
#如对data中的height和weight绘制散点图，横坐标是height，纵坐标是weight

#ggplot中可以设置多种参数，如
#图的类型：geom_point()表示散点图，geom_boxplot()表示绘制箱线图
#图的透明度：如geom_point(alpha = 0.1)alpha表示图的透明度，
#图的颜色：如geom_point(color = "blue")color表示图的颜色
