# The urban model

## 1. 可视化

```java
experiment raster type: gui {
	// 1. 输入模型参数
 	parameter "Weight of the density criteria" var: weight_density;
 	parameter "Weight of the distance to roads criteria" var: weight_road_dist;
 	parameter "Weight of the distance to city center criteria" var: weight_cc_dist;
    // 2. 可视化设置
 	output {
 		display map type: 2d axes:false antialias:false {
			grid plot;
			species roads;
			species city_center;
		}
	}
}
```

## global part

### 1 背景栅格数据

```java
file asc_grid <- grid_file()
geometry shape <- envelope(asc_grid)

file road_shapefile <- shape_file()

file city_center_shapefile <- shape_file()
    
graph roads_network;
```

