"use strict";
// const str = "My name is Chenyu Zzhou.";
// console.log(str.length);
// const list = str;
// console.log(list.slice(0, 8));
// console.log(list.length);
// const date = new Date(2023, 11, 24, 0, 25, 15);
// console.log(typeof Date.now());
// console.log(date);
// const docRoot = document.documentElement;
// console.log(docRoot);
// const obj = {
//   key1: "value1",
//   key2: "value2",
//   key3: "value3",
// };
// console.log(Object.values(obj));
// const map = new Map(Object.entries(obj));
// map.delete("key1");
// console.log(map);
// console.log(map.size);
// const strg = "   My name is Chenyu Zzhou chen.   ";
// console.log(strg.indexOf("eny"));
// console.log(strg.trim());
// const strgi = "name";
// console.log(strgi.padStart(6, 0));
// const emotions = ["angry", "laughing"];
// const data = ["happy", "sad", "excited", emotions];
// console.log(data.splice(2));
// console.log(data);
// const arr1 = [1, 2, 3, 4];
// const arr2 = [5, 6, 7, 8, [10, 11, 12]];
// const arr = [...arr1, arr2];
// console.log(arr);
// console.log(arr.flat(2));
// const acc1 = { name: "cyz", age: 18 };
// const acc2 = { name: "cyz", age: 19 };
// const acc3 = { name: "cyz", age: 20 };
// const accounts = [acc1, acc2, acc3];
// accounts.find((acc) => acc.age === 20);
// console.log(accounts.every((acc) => acc.age > 18));
// const arr = [1, 0, 6, 8, 7, 9];
// console.log(arr.sort((a, b) => a - b));
// const arr2 = [5, 6, 7, 8, [10, 11, 12]];
// console.log(
//   arr2.flat(1).map((v) => {
//     const temp = (v += 1);
//     return temp * 3;
//   })
// );
// const move = arr2.map((v, i) => {
//   const temp = v + 1;
//   return `Movement ${i + 1}: You ${
//     temp > 0 ? "deposited" : "withdrew"
//   } ${Math.abs(v)}`;
// });
// const move = arr2.flatMap((v, i) => {
//   const temp = v + 3;
//   return `Movement ${i + 1}: You ${
//     temp > 0 ? "deposited" : "withdrew"
//   } ${Math.abs(temp)}`;
// });
// console.log(move);
// for (const key of arr2.keys()) {
//   console.log(key);
// }
// for (const char of str) {
//   console.log(char);
// }
// (function () {
//   console.log("My father is i.");
// })();
// const acc4 = { name: "cyz", age: 20, id: "html julay are two" };
// for (const [key, value] of Object.entries(acc4)) {
//   console.log([key, value]);
// }
// const emoji = ["🧐", "😊", "🙁"];
// setTimeout(
//   (emj01, emj02, emj03) => {
//     console.log(`I'm ${emj01} ${emj02} ${emj03}`);
//   },
//   2000,
//   ...emoji
// );
// const myintval = setInterval(
//   (emj01, emj02, emj03) => {
//     console.log(`I'm ${emj01} ${emj02} ${emj03}`);
//   },
//   2000,
//   ...emoji
// );
// clearInterval(myintval);
// const buyer = document.querySelector(".buy");
// buyer.addEventListener("click", (e) => {
//   e.preventDefault(); //prevent the default actions, like the 'href' attribute
//   //   if (e.target.classList.contains("myPlane"))
//   if (
//     e.target instanceof HTMLButtonElement ||
//     e.target instanceof HTMLAnchorElement
//   ) {
//     console.log(e.target);
//     //console.log(e.key);
//   }
// });
// console.log(buyer.attributes[1].name);
// getComputedStyle(buyer);
// const arr = [1, 0, 6, 8, 7, 9];
// console.log(
//   arr.sort((a, b) => {
//     if (a < b) {
//       b - a;
//     } else {
//       a - b;
//     }
//   })
// );
