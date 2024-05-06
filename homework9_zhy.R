## Script name: homework9_zhy
## Author: 张红艳
## Emai: zhanghongyan@mail.ustc.edu.cn
## Date Created:20240430
## ---------------------------
#作业1：Moran 's I和Geary 's C的局部估计通常用于识别attribute values 的spatial 
        #clustering/hotspot 和outliers。请指出哪些情况表示hotspots，哪些情况表示outliers？
#答：
#（1）Moran's I和 Geary's C通过计算空间中邻近位置之间的相关，来进行空间自相关的全局和局部估计。
#（2）局部估计常用于识别spatial clustering/hotspot（空间聚类/热点）和outliers（离群）
#（3）一般来说，Moran 's I和Geary 's C均为正值表示该特征被相似值的特征包围，即空间聚类；而Moran 's I和Geary 's C均负值表示该特征被不同值的特征包围，即空间离群。


## ---------------------------
#作业2:当处理点阵数据时，通常有两种形式的过滤器用于权重矩阵。请指出下列过滤器，
       #并分别给出它们的空间权重矩阵。另外，请编写一行代码，根据任何一个权重过滤器创建权重矩阵。
#答：
#（1）左图空间权重矩阵过滤器为Rook filter
# 0 1 0
# 1 0 1
# 0 1 0

#创建左图空间权重矩阵
rook_matrix_r <- matrix(c(0, 1, 0, 1, 0, 1, 0, 1, 0), nrow=3, ncol=3)
rook_matrix_r

#（2）右图空间权重矩阵过滤器为Queen filter
# 1 1 1
# 1 0 1
# 1 1 1

#创建右图空间权重矩阵
rook_matrix_r <- matrix(c(1, 1, 1, 1, 0, 1, 1, 1, 1), nrow=3, ncol=3)
rook_matrix_r