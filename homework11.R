## Script name: homework11_zhy
## Author: 张红艳
## Purpose of script:
## 1、下载control plots，并构建一个network，最后将其保存为边列表。
## 2、分析network属性，包括顶点和边。
## Emai: zhanghongyan@mail.ustc.edu.cn
## Date Created:20240526

# ---------数据下载与保存---------
## 从website (http://129.15.40.240/mena/)下载control plots数据，名为Control.txt

# ---------安装igraph包并加载---------
install.packages("igraph")
library(igraph)

#---------数据读取与network构建---------
data <- read.table("D:\\1_shengtaixue\\Control.txt", header = TRUE, fill = TRUE)  
g <- graph_from_data_frame(data, directed = FALSE) # 创建network
write_graph(g, file = "D:\\1_shengtaixue\\network_edge_list.txt", format = "edgelist") #保存为边列表

#---------属性分析--------
cat("Number of vertices:", vcount(g), "\n")
cat("Number of edges:", ecount(g), "\n")   #顶点与边的数目

degree <- degree(g)   #顶点的度
print(degree)   

edge_attributes <- get.edge.attribute(g)# 边的贡献分析
print(edge_attributes)