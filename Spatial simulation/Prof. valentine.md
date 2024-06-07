# Major in Ecology

## 1. Grading and Assignments

- using GAMA

## 2. Paper Structure

## introduction

## methods

## results

## discussion

## 3. 期中报告：就是把每节课的作业revise，最后汇总交一下。

# Class 02 Basic grammar

## **Commenting of code**

- Comment to explain what you do
- If you want to exclude a code part, take comment on it

## **Functions**

- init{}
- reflex func{}: 
  - automatic execution at every time step;
- action func{}
  - automatic execution at any time you call it;
  - To call the function: `do name_of_action`;

## **Values**

- 1) Declaration `int age `
- 2) Assignment `age<-3`
- 3) Combing `int age<-3`

## **Variable**

| Species        | Grid          |
| -------------- | ------------- |
| agent variable | cell variable |

## **Facet**

- Update facet (When declaration or calculating)

- ….

## Conditional statements

```gama
reflex fall_love when: is_mature=true{}
```

## New Data type

| Declaration in GAMA | Type                                              | Example                   |
| ------------------- | ------------------------------------------------- | ------------------------- |
| rgb                 | a color in the RGB                                | rgb(3,5,76),#red          |
| file                | an image or data file                             | .txt.csv.tif.gif.asc.shp  |
| geometry            | point, line, or poly                              | circle(2), point([2,5])   |
| graph               | graph with nodes/edges(like network, pedestrians) | [node(0),node(1),node(2)] |

---

**List:**

```javascript
//declaration
list<int> age_list <-[];
//add
add data to:age_list; 
//operators
mean(age_list)
max(age_list)
```

**rgb**

```
//declaration
rgb my_colour;
//assignment
my_colour <- rgb(60,50,40); //or #cyan or (60,mydata,40)
//How to use the color?
//Using color facet
aspect default{
	draw circle(2) color: my_colour;
}

```

## Self

```javascript
//Refers to the current agent.
>> write self;
>> lion(3)

//self vs. myself
species lions{
    reflex reporting{
        ask lions(3){
            write self;	//lion(3)
            write myself;	//lion(0)
        }
    }
}
```

## Loop

### Loop

```
loop times:5{
	write "hi";
}
```

### Ask(called from the global section)

```javascript
ask lions{
	write age;
}
```

### Reflex

```
reflex report_age{
	write age;
}
```

## Movement(some built-in [do] action)

### wander

```
do wander speed:2;
```

### goto(goto the calling agent)

```javascript
do goto target:{x,y};
```

### move

```
do move;
```

### How to visualize?

- **Random walk**

```javascript
action_area<-circle(speed)
```

- **Correlated random walk**

```javascript
action_area<-circle(speed) intersection cone(deg,deg)
```

- **Moving straight ahead**(move)

```javascript
action_area<-line( self.location , self.location+vector )
//vector 
{2,5}
```

- **goto**

## Geometry data

```javascript
geometry action_area;
reflex area{
	action_area <- circle(speed) intersection cone(heading-45,heading+45)
}
aspect myarea{
	//定义绘制的地理要素
	draw action_area color:#red transparency:0.5;
}
```

# Class04 Create agents from Geospatial file

## Geojson文件

```java
global{
	// 1) load geospatial file
	file pasture_file <- file(".../pasture.geojson")
    // 2) Difine the extent of the study area
    geometry shape <- envelope(pasture_file);
    geometry pasture_polygon <-geometry(pasture_file);
    
    // 3) Create the agents
    init{
        create cows skills:[moving]{
            xxxxx
        }
    }
}
```

## Bounds(facet)

```javascript
//To restrict the cows in an area.
do wander amplitude:60 bounds:fenced_area;
```

## 怎么进行agent之间的交互？Agent-agent interaction

`已拍照`

## 怎么进行agent和环境之间的交互？Agent-environment interaction

`比如牛吃草的问题：`the cow‘s perceived area overlaps grass cell locations.

## grids/fields

### 1）定义方法



### 2）遍历其中的元素

```javascript
ask grass{}	//loop through all grids
```

```javascript
loop s over grass{
	grass[centroid(s)] <- 6
}	////loop through cells of a field
```





























































# Final project

cattle movement on a pasture(base on GPS)