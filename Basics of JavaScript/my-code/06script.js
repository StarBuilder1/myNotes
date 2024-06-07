"use strict";
//window
console.log(this);

//inside function
const ageCalc_norm = function (birthday) {
  console.log(2037 - birthday);
  console.log(this); //In 'strict' mode, the output is undefined.
};
ageCalc_norm(1998);

//inside arrow function
const ageCalc_callback = (birthday) => {
  console.log(2037 - birthday);
  console.log(this); //In arrow func, the output is the parent scope;
  //if no parent, then will be the Window obj.
};
ageCalc_callback(1981);

//inside object
const jonas = {
  year: 2556,
  ageCalc_objfunc: function () {
    console.log(this); //In an obj, the output is the obj
  },
};
jonas.ageCalc_objfunc();

//Multiple calling, this永远指向调用他的对象
const matilda = {
  year: 2017,
};
matilda.ageCalc_objfunc = jonas.ageCalc_objfunc;
matilda.ageCalc_objfunc(); //输出为matilda对象
