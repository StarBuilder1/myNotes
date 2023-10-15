/*
Given an array of forecasted maximum temperatures,the thermometer displays a string with these
temperatures.
Example:[17,21,23 ] will print "... 17C in 1 days ... 21C in 2 days ... 23C in 3 days ..."
Create a function 'printForecast' which takes in an array 'arr' and logs a string like the above to the console.
Use the problem-solving framework: Understand the problem and break it up into sub-problems!
TEST DATA 1:[17,21,23]
TEST DATA2:[12,5,-5,0,4]
*/
"use strict";

const printForecast = function (arr) {
  let str = "";
  for (let i = 0; i < arr.length; i++) {
    let value = arr[i];
    str = str + `... ${value}C in ${i} days `;
  }
  console.log(str);
};

printForecast([17, 21, 23]);
