/**
* Name: UrbanGrowthofSalzburg
* Based on the internal empty template. 
* Author: 10041
* Tags: 
*/

model UrbanGrowthofSalzburg
//pr:p_to_road;pc:p_to_nearest_center;
global{ 
// 输入初始化数据
	file road_shapefile <- file("../includes/my_major.shp");
	file base_dem <- file("../includes/base_dem.asc");
	file area <- file("../includes/salzburg_area.shp");
	//file base_dem <- grid_file("../includes/base_dem.asc");
	//file centers_shapefile <- shape_file("../includes/centers.shp");
	//file slope_rasterfile <- grid_file("../includes/slope.asc");

	//定义一个限制范围,永远不要用dem作为范围限制
	geometry shape <- envelope(area);
	graph roads_network;
	
	//筛选出无城市的点
//	list<plot> non_urban_plots <- plot where (each.grid_value = 0.0) update: shuffle(plot where (each.grid_value = 0.0));

	rgb water_C <- rgb(68,97,168);
	rgb non_urban_C <- rgb(240,239,207);
	rgb urban_C <- rgb(255,107,57);
	rgb nodata_C <- rgb(211,211,211);
	list<rgb> plot_colors <- [
		nodata_C,
		non_urban_C,
		urban_C,
		water_C
//		#4461A8,// -1 water region
//		#F0EFCF, // 0 non_urban plots
//		#FF6B39, // 1 built
	];
	
	//模型参数
	int radius <- 4;
	float w_neibor_dens <- 0.05;
	float w_road_level <- 0.2;
	float w_road_dist <- 0.5;
	float w_center_dist <- 0.3;
	float w_slope <- 0.2;
	//Judge if the building works
	float prob_threshold <- 0.75;
	int plots_to_build <- 150;
	
	//init
	init
	{
		create roads from: road_shapefile;
		//create centers from: centers_shapefile;
		
		//roads_network <- as_edge_graph(roads);
		
//		ask roads {
//			do calc_pr_cost;
//		}
//		ask non_urban_plots {
//			do calc_pc_cost;
//		}
//		ask slope{
//			do calc_ps_cost;
//		}
//		do normalize_cost;
	}
	
	//actions
	action normalize_cost{
		
	}
	
	//normalize cost index
//	action normalize_distances {  
//		//Maximum distance from the road of all the plots
//		float max_road_dist <- non_urban_plots max_of each.dist_route;
//		//Maximum distance from the city center for all the plots
//		float max_cc_dist <- non_urban_plots max_of each.dist_cv;
//		//Normalization of  each empty plot according to the maximal value of each attribute
//		ask non_urban_plots {
//			dist_cv <- 1 - dist_cv / max_cc_dist;
//			dist_route <- 1 - dist_route / max_road_dist;
//		}
//	}

}

//Species representing the city center
//species centers {
//	
//}
//Species representing the roads
species roads
{
	//float type;
	rgb color <- #black;
	aspect default {
		draw shape color: #black;
	}
}
//Slope value
//grid slope file: slope_rasterfile use_individual_shapes: false use_regular_agents: false neighbors: 4
//{
//	rgb color <- #black;
//}
//Grid species to represent the different building plots
grid plot file: base_dem use_individual_shapes: false use_regular_agents: false neighbors: 4{
	rgb color <- (grid_value = -1)? plot_colors[0] : plot_colors[int(grid_value+1)];
	//put slope as an attribute,read it directly from tif
//	//Cost of road
//	float dist_route <- 0.0;
//	//Cost of citycenter
//	float dist_cv <- 0.0;
//	//Constructability of the plot
//	float constructability;
}

experiment grow_01 type: gui {
	//Input parameter while model is running.
	parameter "Search radius" var:radius;
	parameter "Weight of road level" var: w_road_level;
 	parameter "Weight of road distance" var: w_road_dist;
 	parameter "Weight of nearest center distance" var: w_center_dist;
 	parameter "Weight of slope" var: w_slope;
 	parameter "Weight of neighbor density" var: w_neibor_dens;
 	parameter "The least probability for construction" var:prob_threshold;
 	output {
 		display map type:2d axes: false antialias: false{
 			grid plot;
 			species roads;
//			grid slope;
//			species centers;
		}
	}
}