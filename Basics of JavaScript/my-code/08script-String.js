"use strict";
//const sentence = "Welcome to NewYork!";
// for (const i of sentence) console.log(i);
//console.log(sentence.padEnd(27, "Your are a good boy!"));

//利用遍历提取航班信息，并逐一处理
const flightInfo =
  "_Delayed_Departure;fao93766109;txl2133758440;11:25+_Arrival;bru0943384722;fao93766109;11:45+_Delayed_Arrival;hel7439299980;fao93766109;12:05+_Departure;fao93766109;lis2323639855;12:30";

const getCode = (str) => {
  return str.slice(0, 3).toUpperCase();
};

for (const item of flightInfo.split("+")) {
  const [type, from, to, time] = item.split(";");
  console.log(
    `${type.startsWith("_Delayed") ? "!!" : "O"} ${getCode(from)} ${getCode(
      to
    )} ${time.replace(":", "h")}`
  );
}
