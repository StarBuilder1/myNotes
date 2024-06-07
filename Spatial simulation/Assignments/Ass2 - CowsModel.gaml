/**
* Name: Ass2CowsModel
* Based on the internal empty template. 
* Author: Chen, Yuzhou
*/

/* Insert your model definition here */
model Ass2CowsModel

global{
	int cows_num <- 5;
	init{
		//Initiate
        write "-All cows have been created.-";
		create cows number: cows_num{
			//give random ages
        	age<-rnd(0,7);
        	write "I'm "+age+" years old";
        	write "I'm ready to graze.";
        }
    }
}

//define cows with actions
species cows skills:[moving]{
	int age update:age+1;
	//deal with cows up 15 years old
	reflex die_catch{
		if age>15{
			create cows number:1 returns:childcow;
			ask childcow{
				age<-1;
				do wander speed:20.0 amplitude:90.0;
				write "mooooooo";
				write "I'm "+age+" years old";
			}			
			do die;
		}
	}
	//make voice
	reflex shout{
		write "mooooooo";
	}
	//move action
	reflex move{
		do wander speed:20.0 amplitude:90.0;
	}
	//To report the ages(at the end of step)
	reflex age_report{
		write "I'm "+age+" years old";
	}

	//default gui settings
	aspect default{
		if age<= 5{draw circle(3) color:#orange;}
		else{draw circle(3) color:#red;}
	}
}

experiment Ass2CowsModel type:gui{
	output{
		display map{
			species cows aspect:default;
		}
	}
	
}



