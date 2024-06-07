"use strict";
// const getName = (namee) => {
//   console.log(namee + "45");
// };
// ["Jonas", "Cindy", "Mark"].forEach(getName); //不用传参，参数自动传入回调函数

/// closures 能够访问到的范围测试 ///
let page = 15;

const securebooking = function () {
  //let page = 0;

  return function () {
    page++;
    console.log(`The number is ${page}`);
  };
};

const booking = securebooking();
booking(); //>>> 16
booking(); //>>> 17
/// 表明闭包会将变量范围限制在诞生的函数中 ///
