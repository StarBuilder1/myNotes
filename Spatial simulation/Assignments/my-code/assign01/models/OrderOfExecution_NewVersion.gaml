/**
* Name: OrderOfExecution_NewVersion
* Based on the internal empty template. 
* Revisor: Chen, Yuzhou
* Description:  This model demonstrates the order of execution of different parts of a GAMA model.
*/

/// Code Execution Sequence ///
//0. Grid: no need to create explicitly
//1. Global init: set state & create instances
//2. Simulation time steps:
//	2-1 global reflex
//	2-2 agent reflex
//	2-3 ask operations(if not in init{})

model OrderOfExecutionNewVersion

global
{
	//Update attribute appears in initiation expression
    int glob_var <- 1 update:glob_var+2;
    //Add-on item for agent_A initiation
    int plus_num <-1;
    
    init {
    	write "time step:" + cycle;
        write "global variable: " + glob_var;
        //Create species
        create agent_B number: 3;
        create agent_A number: 5{
        	//Initiate specific value sequence with plus_num
        	agent_A_var<-plus_num;
    		plus_num<-plus_num+1;
    		write "Agent_A variable: " + agent_A_var;
        }
        create agent_C number: 2;      
    }
    //Global reflex runs every time step in global level
    reflex cyclePrinter {
    	write "time step:" + cycle;
    }

    reflex globvarPrinter {
        write "global variable: " + glob_var;
    }  
    reflex CA_AgentChanger {
        ask CA[0] {
        	grid_var <- int(rnd(100));
        } 
    } 
}

//Define species A & reflex methods
species agent_A {
	int agent_A_var<-1 update: agent_A_var + 2;
	//No need for init{} which runs with create statement before 
    reflex agentPrinter_A {
        write "Agent_A variable: " + agent_A_var;
    }     
}
//Define species B & reflex methods
species agent_B {
    int agent_B_var update:agent_B_var+2;
    init {
        	agent_B_var <- rnd(2,6); //I can change the seed
        	write "Agent_B variable: " + agent_B_var; 
    }
    reflex agentPrinter_B {
        write "Agent_B variable: " + agent_B_var;     	
    }   
}
//Define species C & reflex methods
species agent_C {
    float agent_C_var <- 0.0 update:agent_C_var+2.0;
    init {
        write "Agent_C variable: " + agent_C_var; 
    }
    reflex agentPrinter_C {
        write "Agent_C variable: " + agent_C_var;
}
}
//Define grid CA & Take the top priority in initiation
grid CA width: 2 height: 2{
    int grid_var <- grid_x update:grid_var+2;
    init{
        write "CA variable: " + grid_var;
    }
    reflex gridPrinter_CA{
        write "CA variable: " + grid_var;
    }
}
//Start model-testing
experiment OrderOfExecutionNewVersion type: gui {
//Visualization
//	output {
//    	display map {
//        	grid CA border: #black ;
//    	}
//    }
}

