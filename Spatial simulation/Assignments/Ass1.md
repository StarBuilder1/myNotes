# Questions 01

1)      Initialise the model 

- Why has the „CA variable“ a value of 2 in time step 0? 

  1

- Why is the exact same information displayed several times for the agents and the CA? 

  1

- Why is the “Agent_A variable from global” different from the Agent_A variables reported before? 

  1

- What is the order of Agent variables reported? Can this order be explained? 

  1

- What is the order of execution for the initialization? 

  1

2)      Let the simulation step ahead 1 cycle 

- What is the order of execution at the first step? Does it differ from the initialization? 

  1（并且A\B\C的呈现顺序也产生了不同）

- Why is the order of agents different, now? 

  1

- Why does one of the Agent_A variables have a value of 3, instead of value 2? 

  1（ask操作符）

- Why does one of the CA variables now differ from the others? 

  1（ask操作符）

- Have a look at how reflexes represent the behaviour of Agents in agent_B and agent_C: According to good coding practice, Agent C handles functionalities separately: one reflex **manipulates** the variable, another reflex does the reporting. Agent B combines these functions. Is there any difference in the output? Can you explain why / why not? 

  1（不知道的原因）

3)      Rewrite the model  

- - Separate functionalities and give more meaningful names to the reflexes.

    **分解函数+赋予reflex的名称**

  - To have a different **initial** value for each individual agent:  

  - 1. Agent_A should have the values 1, 2, 3, 4 and 5.  

       **使用ask初始化！！**（实际上在create时就可以，但我不会for？？）

    2. Agent_B should have random integer values between 2 and 6 

       **使用species中的init初始化！！**

    3. Agent_C should have a float value of 0.0. 

       **直接在species中初始化！！**

  - To have cell values that equal their x coordinate value. To find out, how to access the information about the x coord, go to the <https://gama-platform.org/> website and search for the “grid” species, and there check out the grid’s built-in variables.  

  - To increment the values of all variables with 2 units per time step,  Increment values using update facets only. 


4)      Make sure to keep your code tidy: 

- - Fix eventual errors and warnings. 

    1

  - Delete unused parts of the model.  

    1

  - Comment your code. 

    1

  - Double-check that all indents are correct. 

    1