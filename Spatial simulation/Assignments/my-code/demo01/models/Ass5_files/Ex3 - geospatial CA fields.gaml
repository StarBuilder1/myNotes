/***
* Name: Ex1_geospatialABM
* Author: WALLENTIN, Gudrun
* Description: Exercise of the UNIGIS Salzburg optional module
* working with geospatial data
***/

model Ex2_geospatialABM

global  {
	//Load geospatial data
	file pasture_file <- file("../includes/vierkaser.geojson");
	file hirschanger_file <- file("../includes/hirschanger.geojson");
	file lower_pasture_file <- file("../includes/lower_pasture.geojson");
	file cutback2020_file <- file("../includes/cutback_2020.geojson");
	file cutback2021_file <- file("../includes/cutback_2021.geojson");	
	grid_file dem_file <- file("../includes/DEM_4Kaser_31258.tif");	
	
	//maximum distance, a cow can go in one time step;
	float range <- 25.0;
	
	//grass regrowth
	float grass_growth_rate <- 0.001;

	//Define the extent of the study area
	geometry shape <- envelope(pasture_file) ;
	//read the geometry of the pasture file into a variable
	geometry pasture_geom <- geometry(pasture_file);
	geometry lower_pasture_geom <- geometry(lower_pasture_file);
	geometry hirschanger_geom <- geometry(hirschanger_file);
	geometry cutback2020_geom <- geometry(cutback2020_file);
	geometry cutback2021_geom <- geometry(cutback2021_file);
	geometry grazeland_geom <- hirschanger_geom + lower_pasture_geom + cutback2020_geom + cutback2021_geom;
			
	//read the biomass.asc into the field variable "biomass"
	//field biomass <- field(biomass_file);
	//construct a field for biomass with 5m cells
	field biomass <- field(ceil(shape.width / 5), ceil(shape.height / 5), 0.0) ;
	field terrain <- field(dem_file) ;
	
	//Create the agents 
	init {
		//create 5 cow agents that are located within the pasture
		create cows number: 5 {
			location <- any_location_in (grazeland_geom);
		} 

		//overwrite the biomass for the specific regions in the pasture
		loop s over: biomass cells_in lower_pasture_geom {
			biomass[centroid(s)] <- 6;
		}
		loop s over: biomass cells_in hirschanger_geom {
			biomass[s.location] <- 4;
		}
		loop s over: biomass cells_in cutback2020_geom {
			biomass[centroid(s)] <- 7;
		}
		loop s over: biomass cells_in cutback2021_geom {
			biomass[centroid(s)] <- 6;
		}		
	}		
	
	reflex grow_grass {	
		loop s over: biomass cells_in lower_pasture_geom {
			if biomass[centroid(s)] < 6 {
				biomass[centroid(s)] <- biomass[centroid(s)] + grass_growth_rate;	
			}
		}
		loop s over: biomass cells_in hirschanger_geom {
			if biomass[centroid(s)] < 4 {
				biomass[centroid(s)] <- biomass[centroid(s)] + grass_growth_rate;	
			}
		}
		loop s over: biomass cells_in cutback2020_geom {
			if biomass[centroid(s)] < 7 {
				biomass[centroid(s)] <- biomass[centroid(s)] + grass_growth_rate;	
			}
		}
		loop s over: biomass cells_in cutback2021_geom {
			if biomass[centroid(s)] < 6 {
				biomass[centroid(s)] <- biomass[centroid(s)] + grass_growth_rate;	
			}
		}	
	}
}

// cow agents
species cows skills: [moving] {
	
	float energy;
	point best_spot;
		
	//cows graze 2 units of biomass per time step, if possible 
	reflex graze  {
		//identify the field cell with the maximum biomass within the range of the cow
		best_spot <- shuffle(((biomass cells_in (self + range)) collect (each.centroid))) with_max_of each.z;
		do move heading: self towards best_spot speed: 2.0 bounds:pasture_geom;	
		if biomass[self.location] > 2 {
			biomass[self.location] <- biomass[self.location] - 2;
		}
	}

	//visualisation
	aspect base {
		draw circle (5) color: #red;
	}
	
	aspect sphere3D{
		pair<float,point> r0 <- -90::{1,0,0};	
		pair<float,point> pitch <-  0 ::{1,0,0};
		pair<float,point> roll <- 0::{0,1,0};
		pair<float,point> yaw <- heading::{0,0,1};
		draw obj_file("../includes/cow.obj", rotation_composition(r0,pitch,roll,yaw)) at:{location.x, location.y, terrain[location] + 2} size: 20 color: #orange;
	}	
}

//Simulation 
experiment virtual_pasture type:gui {
	output {
		//layout with windows
		layout 1;
		//splitted layout in one window;
		//layout #split;
		display population_chart type: opengl {
			chart "mean biomass" {
				data "number of cows" value: mean(biomass);
			}
		}
		display map type: 2d{

			mesh biomass triangulation: false smooth: false above: 0.0 color:#green scale:0.0 ;
			species cows aspect:base;
		}
		
		display Vierkaser_2D type:opengl {
					
			//2d Viz
			camera 'default' location: {-176.0416,-289.5403,1330.5801} target: {334.1204,387.4675,0.0};
			species cows aspect:base refresh:true  ;
			mesh biomass color:#green scale:0;
	
		}
		display Vierkaser_3D type:opengl {
			//3D
			camera 'default' location: {-4.3307,-68.6176,2566.172} target: {979.5735,1237.0675,0.0};
			species cows aspect:sphere3D refresh:true  ;
			//mesh biomass color:#green ;
			mesh terrain color:#grey triangulation: true ;
	
		}			

	}
}
