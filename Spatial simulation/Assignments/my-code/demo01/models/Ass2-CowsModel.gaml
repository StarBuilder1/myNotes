/**
* Name: Ass2CowsModel
* Based on the internal empty template. 
* Author: Chen, Yuzhou
* Tags: 
*/


model Ass2CowsModel

global{
	int cows_num <- 5;
//	int new_num<-0;
	init{
		//Initiate
        write "-----All cows have come to birth.-----";
		create cows number: cows_num{
        	age<-rnd(0,7);
        	write "Age is:"+age;
        	write "Are you ready? "+graze;
        }
    }
    ask 
    reflex changing{
//    	list<int> cowAges <- broadcast;
//    	if age=15{
//			new_num<-new_num+1;
//		}
//		create cows number: new_num{
//			age<-0;
//		}
//		write "Add number:"+new_num;
	}

}

species cows skills:[moving]{
	int age;
	bool graze <- true;
	
	reflex shout{
		write "mooooooo";
	}
	reflex move{
		do wander amplitude:90.0;
	}
	reflex age_report{
		age<-age+1;
		write "I'm "+age+" years old";
	}
	reflex die_catch{
		if age>15{
			create cows(self) number:1{
				age<-0;
			}
			do die;
		}
		
	}
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

/* Insert your model definition here */
