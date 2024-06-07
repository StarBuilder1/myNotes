/**
* Name: Ass4CowGrazeModel
* Based on the internal empty template. 
* Author: 10041
* Tags: 
*/


model Ass4CowGrazeModel

global{
	// geospatial data input
	file pasture_file <- file("./Ass4_files/vierkaser.geojson");
	file hirschanger_file <- file("./Ass4_files/hirschanger.geojson");
	file lower_pasture_file <- file("./Ass4_files/lower_pasture.geojson");
	file cutback2020_file <- file("./Ass4_files/cutback_2020.geojson");
	file cutback2021_file <- file("./Ass4_files/cutback_2021.geojson");
	
	//Define the extent areas
	geometry shape <- envelope(pasture_file);
	//Store the area into geometry
	geometry pasture_geom <- geometry(pasture_file);
	geometry hirschanger_geom <- geometry(hirschanger_file);
	geometry lower_pasture_geom <- geometry(lower_pasture_file);
	geometry cutback2020_geom <- geometry(cutback2020_file);
	geometry cutback2021_geom <- geometry(cutback2021_file);
	//Define graze_land, a combination of several parts 
	geometry grazeland_geom <- hirschanger_geom+lower_pasture_geom+cutback2020_geom+cutback2021_geom;
	
	//grass regrowth
	float regrowth_height <- 0.0005;
	//create biomass, input n*n and attribute value
	field biomass <- field(ceil(shape.width/5), ceil(shape.height/5),0.0);
	
	//Define the max height of each grass area
	float hir_max <- 4.0;
	float low_max<- 6.0;
	float cut20_max<- 7.0;
	float cut21_max <- 6.0;
	
	init{
		//create cows (in random locations)
		create cows number:5{
			location <- any_location_in(grazeland_geom);
		}
		//assign the biomass
		loop s over: biomass cells_in hirschanger_geom{
			biomass[centroid(s)] <- hir_max;
		}
		loop s over: biomass cells_in lower_pasture_geom{
			biomass[centroid(s)] <- low_max;
		}
		loop s over: biomass cells_in cutback2020_geom{
			biomass[centroid(s)] <- cut20_max;
		}
		loop s over: biomass cells_in cutback2021_geom{
			biomass[centroid(s)] <- cut21_max;
		}
	}
	
	reflex bio_regrowth{
		/// Try to use Logistic Model ///
		// set the const ratio k = 0.3
		float k<-0.3;
		loop s over: biomass cells_in hirschanger_geom{
			if(biomass[centroid(s)] = 0){
				biomass[centroid(s)] <- biomass[centroid(s)]+regrowth_height;
			}else{
				float num_rate <- biomass[centroid(s)]/hir_max;
				float rest_rate <- 1-num_rate;
				if((biomass[centroid(s)]+biomass[centroid(s)]*(k*num_rate*rest_rate))>hir_max){
					biomass[centroid(s)]<-hir_max;
				}else{
					biomass[centroid(s)]<-biomass[centroid(s)]+biomass[centroid(s)]*(k*num_rate*rest_rate);
				}
			}
		}
		loop s over: biomass cells_in lower_pasture_geom{
			if(biomass[centroid(s)] = 0){
				biomass[centroid(s)] <- biomass[centroid(s)]+regrowth_height;
			}else{
				float num_rate <- biomass[centroid(s)]/low_max;
				float rest_rate <- 1-num_rate;
				if((biomass[centroid(s)]+biomass[centroid(s)]*(k*num_rate*rest_rate))>low_max){
					biomass[centroid(s)]<-low_max;
				}else{
					biomass[centroid(s)]<-biomass[centroid(s)]+biomass[centroid(s)]*(k*num_rate*rest_rate);
				}
			}
		}
		loop s over: biomass cells_in cutback2020_geom{
			if(biomass[centroid(s)] = 0){
				biomass[centroid(s)] <- biomass[centroid(s)]+regrowth_height;
			}else{
				float num_rate <- biomass[centroid(s)]/cut20_max;
				float rest_rate <- 1-num_rate;
				if((biomass[centroid(s)]+biomass[centroid(s)]*(k*num_rate*rest_rate))>cut20_max){
					biomass[centroid(s)]<-cut20_max;
				}else{
					biomass[centroid(s)]<-biomass[centroid(s)]+biomass[centroid(s)]*(k*num_rate*rest_rate);
				}
			}
		}
		loop s over: biomass cells_in cutback2021_geom{
			if(biomass[centroid(s)] = 0){
				biomass[centroid(s)] <- biomass[centroid(s)]+regrowth_height;
			}else{
				float num_rate <- biomass[centroid(s)]/cut21_max;
				float rest_rate <- 1-num_rate;
				if((biomass[centroid(s)]+biomass[centroid(s)]*(k*num_rate*rest_rate))>cut21_max){
					biomass[centroid(s)]<-cut21_max;
				}else{
					biomass[centroid(s)]<-biomass[centroid(s)]+biomass[centroid(s)]*(k*num_rate*rest_rate);
				}
			}
		}		
		/// Normal grass growth ///
//		loop s over: biomass cells_in hirschanger_geom{
//			if((biomass[centroid(s)]+regrowth_height)>hir_max){
//				biomass[centroid(s)] <- hir_max;
//			}else{
//				biomass[centroid(s)] <- biomass[centroid(s)]+regrowth_height;
//			}
//		}
//		loop s over: biomass cells_in lower_pasture_geom{
//			if((biomass[centroid(s)]+regrowth_height)>low_max){
//				biomass[centroid(s)] <- low_max;
//			}else{
//				biomass[centroid(s)] <- biomass[centroid(s)]+regrowth_height;
//			}
//		}
//		loop s over: biomass cells_in cutback2020_geom{
//			if((biomass[centroid(s)]+regrowth_height)>cut20_max){
//				biomass[centroid(s)] <- cut20_max;
//			}else{
//				biomass[centroid(s)] <- biomass[centroid(s)]+regrowth_height;
//			}
//		}
//		loop s over: biomass cells_in cutback2021_geom{
//			if((biomass[centroid(s)]+regrowth_height)>cut21_max){
//				biomass[centroid(s)] <- cut21_max;
//			}else{
//				biomass[centroid(s)] <- biomass[centroid(s)]+regrowth_height;
//			}
//		}
	}

}

species cows skills:[moving]{
	//max move range(adjustable,no small )
	float range <- 60.0;
	point best_spot;
	reflex graze{
		//identify the field cell with the maximum biomass within the range of the cow
		//z stands for the attribute value
		//collect can send back a list of centroid point
		best_spot <- shuffle(((biomass cells_in (self + range)) collect (each.centroid))) with_max_of each.z;
		do move heading: self towards best_spot;
		//eat grass
		if(biomass[self.location]>=2){
			biomass[self.location] <- biomass[self.location]-2;
		}else{
			biomass[self.location] <- 0;
		}
	}
	//default gui settings
	aspect default{
		draw circle(5) color:#red;
	}
}

experiment Ass4CowGrazeModel type:gui{
	output{
		display map type:2d{
			mesh biomass color:#green;
			species cows aspect:default;
		}
	}
	
}




