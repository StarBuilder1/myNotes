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

