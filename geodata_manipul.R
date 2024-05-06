## ---------------------------
## Script name: geodata_,manipul.R
##
## Purpose of script:
##       1、沿着Doubs河设置2公里的缓冲区，并从地图上截取，使用qgisprocess软件包提取每个点的集水区和坡度的栅格值。
##       2、将提取的数据与Doubs数据集中的其他环境因素合并形成一个数据框，最后将该数据框传递给一个包含geometry列的sf对象。
## 
## Author: 张红艳
## 
## Emai: zhanghongyan@mail.ustc.edu.cn
##
## Date Created:20240425
## ---------------------------
#----加载需要的R包----
library(ggplot2)
library(sf)
library(terra)
library(elevatr)
library(qgisprocess) #该包正常使用需要配置系统环境变量

#----读取数据----
doubs_river <- st_read("D:/1_shengtaixue/QGIS/doubs_river.shp") #读取数据
doubs_river <- st_as_sf(doubs_river)  #转换为sf对象

#----创建2km缓冲区并进行可视化----
doubs_buffered <- st_buffer(doubs_river, dist = 2000)
plot(st_geometry(doubs_buffered),axes=TRUE)

#----用qgisprocess包沿Doubs River提取集水区和坡度光栅值----
doubs_dem <- qgis_runalg(qgis, "grass8:r.watershed", "D:/1_shengtaixue/QGIS/doubs_dem.tif", doubs_buffered$cat)
doubs_slope <- qgis_runalg(qgis, "grass8:r.slope.aspect", "D:/1_shengtaixue/QGIS/doubs_dem.tif", doubs_buffered$cat)

#----用terra包提取DEM和坡度----
dem_values <- terra::extract(doubs_dem, doubs)
slope_values <- terra::extract(doubs_slope, doubs)

#----用merge函数将提取的光栅值与Doubs数据集中的其他环境因素合并为数据框----
data_frame <- merge(doubs,data.frame(DEMValue = dem_values, SlopeValue = slope_values), 
                    by = "cat",all.y = TRUE)

#----将数据框转换为sf对象----
sf_object <- st_as_sf(data_frame, coords = c("经度", "纬度"),crs = 4326)

#----用ggplot进行可视化----
ggplot() +
  geom_sf(data = sf_object, aes(fill = DEMValue)) + 
  theme_minimal()