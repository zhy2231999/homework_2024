## ---------------------------
##
## Script name: “pak_info.R
##
## Purpose of script:access information about the tidyverse package
##
## Author: zhanghongyan
## 
## Emai: zhanghongyan@mail.ustc.edu.cn
##
## Date Created:20240316
## ---------------------------
install.packages("packagefinder", dependencies = TRUE)
library(packagefinder)
findPackage("tidyverse")       #寻找tidyverse包


install.packages("tidyverse")  #插入tidyverse包


#了解tidyverse包功能的几种方式
browseVignettes(package="tidyverse")  #直接会跳转到tidyverse网页
demo(package="tidyverse")             
apropos("^tidyverse")         #展现tidyverse包含的各组分

library(tidyverse)
ls("package:tidyverse")       #展现tidyverse包含的各组分    
??tidyverse.function          #查询tidyverse包的功能 


#获得帮助文件
help(package='tidyverse')    #在help页面出现功能说明
vignette("tidyverse")        #寻找tidyverse教程库
help.search('^tidyverse')    #获得帮助文件
