## ---------------------------
## Script name: r_database.R
##
## Purpose of script:如何将内置数据集Doubs的数据上传到PostgreSQL或SQLite中
##
## Author: 张红艳
## 
## Emai: zhanghongyan@mail.ustc.edu.cn
##
## Date Created:20240419

#----------把Doubs数据上传到SQLite中----------
# 加载需要的包
library(ade4)
library(reticulate)
library(DBI)
library(RPostgres)

# 加载doubs数据
data(doubs)

# 定义SQLite数据库文件路径
db_file <- "doubs_data.db"

# 连接到SQLite数据库
con <- DBI::dbConnect(RSQLite::SQLite(), dbname = db_file)

# 上传doubs到SQLite
DBI::dbWriteTable(con, "doubs", doubs, overwrite = TRUE)

# 关闭数据库连接
DBI::dbDisconnect(con)


#----------把Doubs数据上传到PostgreSQL中----------
# 连接到PostgreSQL数据库
con <- dbConnect(RPostgres::Postgres(),
                 dbname = "postgres",
                 host = "localhost",
                 port = "5432",
                 user = "postgres",
                 password = "i753ql")

# 上传doubs到PostgreSQL
dbWriteTable(con, "doubs", doubs, overwrite = TRUE)

# 关闭数据库连接
dbDisconnect(con)