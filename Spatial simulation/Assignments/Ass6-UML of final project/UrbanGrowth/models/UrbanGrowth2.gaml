/**
* Name: UrbanGrowth2
* Based on the internal empty template. 
* Author: yuzhou
* Tags: 
*/


model UrbanGrowth2
//pr:p_to_road;pc:p_to_nearest_center;
global{ 
	//Input the dataset.
	file road_shapefile <- file("../includes/my_major.shp");
	file slope_rasterfile <- file("../includes/slope.asc");
	file base_dem <- file("../includes/base_dem.asc");
	file area <- file("../includes/salzburg_area.shp");
	file centers_shapefile <- file("../includes/City_Centre.shp");

	//set a range, don't use dem as the range
	geometry shape <- envelope(area);
	graph roads_network;
	point center_pts <- point(centers_shapefile);
	
	//select all the non-urban plots
	list<plot> non_urban_plots <- plot where (each.grid_value = 0.0) update: shuffle(plot where (each.grid_value = 0.0));
	
	rgb water_C <- rgb(68,97,168);
	rgb non_urban_C <- rgb(240,239,207);
	rgb urban_C <- rgb(255,107,57);
	rgb nodata_C <- rgb(211,211,211);
	//-1 nodata
	//0 non_urban plots
	//1 built
	//2 water
	list<rgb> plot_colors <- [
		nodata_C,
		non_urban_C,
		urban_C,
		water_C

	];
	
	//Parameters of the model
	int radius <- 4;
	float w_neibor_dens <- 0.15;
	float w_road_level <- 0.05;
	float w_road_dist <- 0.1;
	float w_center_dist <- 0.4;
	float w_slope <- 0.3;
	//Judge if the building works
	float prob_threshold <- 0.68;
	int plots_to_build <- 150;
	
	int b <- 0;
	
	init
	{
		//create roads from: road_shapefile;
        create roads from: road_shapefile with:[level::float(read("level"))];	//use level as attribute
		create centers from: centers_shapefile;
		
		roads_network <- as_edge_graph(roads);

		ask roads {
			do compute_dist;
		}
		ask non_urban_plots {
			do compute_distances;
		}
		do normalize_distances;
		
	}
	
	//	normalize cost index
	action normalize_distances {  
		//Maximum distance from the road of all the plots
		float max_road_dist <- non_urban_plots max_of each.dist_route;
		//Maximum distance from the city center for all the plots
		float max_cc_dist <- non_urban_plots max_of each.dist_cv;
		write max_cc_dist;
		float max_slope <- slope max_of each.grid_value;
		write "slope: " + max_slope;
		float max_level <- non_urban_plots max_of each.dist_level;
		write "road: "+max_level;
		//Normalization of  each empty plot according to the maximal value of each attribute
		ask non_urban_plots {
			m_slope <- 1- n_slope / max_slope;
			dist_cv <- 1 - dist_cv / max_cc_dist;
			dist_route <- 1 - dist_route / max_road_dist;
			//Extend with the road level
			dist_level <- 1 - dist_level / max_level;
		}
	}
	
	reflex dynamique_globale when: w_neibor_dens != 0 or w_road_dist != 0 or w_center_dist != 0 {
		//Ask each empty plot to compute its constructability
		ask non_urban_plots {
			constructability <- compute_constructability();
		}
		//use the threshold to constraint
		list<plot> eligible_plots <- non_urban_plots where (each.constructability > prob_threshold);
		//use the max building number to constraint
		list<plot> ordered_plots <- eligible_plots sort_by (each.constructability);
		ordered_plots <- plots_to_build last ordered_plots;
		//Build on each empty plot having the highest constructability
		ask ordered_plots
		{
			do build;
		}
	}	
	
	//saving result
	reflex save_result_grid when: every(50#cycles)
	{
		b <- b+50;
		save plot to:"../results/grid/"+ b +".asc" format:asc;
	}
}

//Species representing the city center
species centers {
	rgb color <- #red;
	aspect default {
		draw shape color: #red;
	}
}
//Species representing the roads
species roads
{
	float level;
	float dist_cv;
	float temp_dist;
	rgb color <- #black;
	aspect default {
		draw shape color: #black;
	}
	
	action compute_dist
	{
		using topology(roads_network) {
			centers c <- centers closest_to self ;
			dist_cv <- (self distance_to c); 	//distance from road to city center
		}
	}
}
//Slope value
grid slope file: slope_rasterfile use_individual_shapes: false use_regular_agents: false neighbors: 4
{
	//rgb color <- #black;
}
//Grid species to represent the different building plots
grid plot file: base_dem use_individual_shapes: false use_regular_agents: false neighbors: 4{
	rgb color <- (grid_value = -1)? plot_colors[0] : plot_colors[int(grid_value+1)];
	//slope
	float n_slope <- slope[grid_x,grid_y].grid_value;
	float m_slope<-0.0;
	//put slope as an attribute,read it directly from tif
	//Cost of road
	float dist_route <- 0.0;
	//Dist direct to the center(FOR debugging)
	float dist_center<-0.0;
	//Cost of citycenter
	float dist_cv <- 0.0;
	//Cost of the level
	float dist_level<-0.0;
	//Constructability of the plot
	float constructability;
	
	
	action compute_distances
	{
		roads route_pp <- roads closest_to self;      //find the closest road
		dist_route <- (self distance_to route_pp) using topology(world); //distance to the closest road
		//revise logic error
		centers c <- centers closest_to self;
		dist_center <- (self distance_to c)using topology(world);
		if route_pp.dist_cv > dist_center
		{
			dist_cv<-dist_center;
		}
		else
		{
			dist_cv <- dist_route+route_pp.dist_cv;
		}   //dis_to_center = dis_to_road+road_to_center
		
		dist_level <- route_pp.level;	//level of the closest road
	}
	action build
	{
		grid_value <- 1.0;
		color <- plot_colors[2];
	}
	float compute_constructability
	{ 
		//Get all the neighbours plots
		list<plot> voisins <- (self neighbors_at radius);  //inside the circle
		//Compute the density of all the neighbours plots
		float densite <- (voisins count (each.grid_value = 1.0)) / length(voisins);
		return (densite * w_neibor_dens + dist_route * w_road_dist + dist_cv * w_center_dist + w_slope*m_slope+w_road_level*dist_level) / (w_road_level+w_slope+w_neibor_dens + w_road_dist + w_center_dist);
	}
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
 		layout #split;
 		display map type:2d axes: false antialias: false refresh: every(10#cycles){
 			grid plot;
 			species roads;
			species centers;
		}
		display buildingnum_chart background:#white refresh: every(5#cycles){
			chart "Increase of Building Number" type:series{
				data "Building Number" value:plot count (each.grid_value = 1.0) color:#red;
			}
		}
		//display the constructability. Link:https://gama-platform.github.io/wiki/DefiningCharts
		display construct_chart background:#white refresh: every(5#cycles){
			chart "Statistic of constructability" type:series{
				data "Max Constructability" value:non_urban_plots max_of each.constructability color:#blue;
				data "Mean Constructability" value:non_urban_plots mean_of each.constructability color:#orange;
			}
		}
		//display max value of some kinds of distances
//		display maxcost_chart background:#white{
//			chart "Mean Cost in Various Type" type:series{
//				data "Max Road Dis" value:non_urban_plots mean_of each.dist_route color:#blue;
//				data "Max Center Dis" value:non_urban_plots mean_of each.dist_cv color:#orange;
//				data "Max Slope Cost" value:non_urban_plots mean_of each.n_slope color:#yellow;
//			}
//		}
		
	}
}



