"use strict";
// 定义对象属性 //
const Person = function (name, age) {
  this.name = name;
  this.age = age;
};
// 定义对象方法 //
Person.prototype.calcAge = function () {
  console.log(100 - this.age);
};

// 定义对象实例 //
const jonas = new Person("jonas", 56);

// Prototype Chain //
console.log(Object.prototype);
console.log(Person.prototype.__proto__);
console.log(Person.prototype);
console.log(jonas.__proto__);
// Prototype Chain验证 //
console.log(Object.prototype === Person.prototype.__proto__);
console.log(Person.prototype === jonas.__proto__);

// 审查对象实例的属性 //
// 仅限于实例！！因为该方法由Object.prototype直接继承至实例jonas //
console.log(jonas.hasOwnProperty("name"));
console.log(jonas.hasOwnProperty("age"));
