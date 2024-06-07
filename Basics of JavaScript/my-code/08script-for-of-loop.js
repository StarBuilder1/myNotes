"use strict";

const numlist = [1, 2, 4, 8, 16, 32];
//普通loop
for (const item of numlist) {
  console.log(item);
}
//序号+内容loop
for (const item of numlist.entries()) {
  console.log(item);
}
