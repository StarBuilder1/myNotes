"use strict";

/// An example on 2 ways of copying ///
/*1. shallow copy can do*/
const jessica = {
  firstname: "Jessica",
  lastname: "William",
  age: 25,
  familyMember: ["Alice", "Bob"],
};

const married_jessica = Object.assign({}, jessica);
married_jessica.lastname = "David";
console.log("Before married", jessica);
//{firstname: 'Jessica', lastname: 'William', age: 25, familyMember: Array(2)}

console.log("After married", married_jessica);
//{firstname: 'Jessica', lastname: 'David', age: 25, familyMember: Array(2)}

/*2. shallow copy can't do on Deeply-Nested Obj*/
const jessica2 = {
  firstname: "Jessica",
  lastname: "William",
  age: 25,
  familyMember: ["Alice", "Bob"],
};

const married_jessica2 = Object.assign({}, jessica2);
married_jessica2.familyMember.push("John");
married_jessica2.familyMember.push("Steven");

console.log("Before married", jessica2.familyMember);
// Before married Array(4)
console.log("After married", married_jessica2.familyMember);
// After married Array(4)
// Sum: This 2 array are the same.
