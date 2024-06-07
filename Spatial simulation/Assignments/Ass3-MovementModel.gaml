/**
* Name: Ass3SheepModel
* Based on the internal empty template. 
* Author: Chen, Yuzhou
*/

model Ass3MovementModel

global{
	init{
		//create 3 species
		create cows number: 5;
		create sheeps number: 3;
		create goats number: 2;
		
    }
}


species cows skills:[moving]{
	geometry cow_area1;
	geometry cow_area2;
	reflex cow_walk{
		do wander speed:2.0 amplitude:90.0;
		//wander area 90
		cow_area1 <- circle(speed) intersection cone(heading-45,heading+45);
		//graze area 120
		cow_area2 <- circle(4.0) intersection cone(heading-60,heading+60);
	}
	
	aspect cow_show{
		draw circle(0.5) color:#brown border:#cyan; //draw cows
		draw cow_area1 color:#black;	//draw cow movement
		draw cow_area2 color:#green;
}
}

species sheeps skills:[moving]{
	geometry sheep_area;
	geometry wolf_area;
	reflex sheep_walk{
		do move speed:1.0 heading:90.0;
		//move line based on speed
		sheep_area <- line(self.location, self.location+{0,speed});
		//identify the wolves
		wolf_area <- point(self.location+{0,-3});
		//wolf_area <- line(self.location, self.location+{0,-3}) intersection circle(3.0);
	}
	aspect sheep_show{
		draw circle(0.5) color:#black border:#cyan; //draw sheeps
		draw sheep_area color:#green;	//draw sheep movement
		draw wolf_area color:#red;
	}
	}

species goats skills:[moving]{
	geometry goat_area;
	geometry buck_area;
	
	reflex goat_walk{
		do goto speed:0.5 target:{0,0};
		//goto line based on speed
		goat_area <- line(self.location, {0,0}) intersection circle(speed);
		//scent area of bucks
		buck_area <- circle(5.0);
	}
	
	aspect goat_show{
		draw circle(0.5) color:#yellow border:#cyan; //draw goats
		draw goat_area color:#black;	//draw goat movement
		draw buck_area color:#grey;
	}
	}

experiment Ass3MovementModel type:gui{
	output{
		display map{
			//visulize the 3 species
			species cows aspect:cow_show transparency:0.5;
			species sheeps aspect:sheep_show;
			species goats aspect:goat_show transparency:0.3;
		}
	}
}
