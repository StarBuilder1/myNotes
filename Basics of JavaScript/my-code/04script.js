"use strict";
//const actual_num = Math.trunc(Math.random() * 20) + 1;
let actual_num = 15;
let score = 20; //A big question: How to act with the html?
let highscore = 0;
//input guess
//click button 'check', use guess value to check
document.querySelector(".check").addEventListener("click", (value) => {
  let myguess = Number(document.querySelector(".guess").value);
  //if too big, change back-ground color to red, change start guessing
  //if too small, change back-ground color to green, change start guessing
  if (!myguess) {
    //判断是否为空
    document.querySelector(".message").textContent = "No number.";
  } else if (myguess === actual_num) {
    //如果正确，...
    document.querySelector(".message").textContent = "You are right!!";
    document.querySelector(".number").textContent = actual_num;
    document.querySelector("body").style.backgroundColor = "#60b347";
    document.querySelector(".number").style.width = "30rem";

    if (score > highscore) {
      highscore = score;
      document.querySelector(".highscore").textContent = highscore;
    }
  } else {
    //如果错误，...
    if (score > 1) {
      //如果还不会失败，...
      score--; //减少score的值
      document.querySelector(".score").textContent = score;
      if (myguess > actual_num) {
        document.querySelector(".message").textContent = "Too Big!!";
      } else {
        document.querySelector(".message").textContent = "Too small :(";
      }
    } else {
      //如果失败了，...
      document.querySelector(".message").textContent = "You lost the game :((";
      document.querySelector(".number").textContent = actual_num;
      document.querySelector(".score").textContent = score - 1;
    }
  }
});

//click button 'again',reset guess input, change back color to black
document.querySelector(".again").addEventListener("click", (value) => {
  score = 20;
  actual_num = Math.trunc(Math.random() * 20) + 1;
  document.querySelector(".guess").value = "";
  document.querySelector(".message").textContent = "Start guessing...";
  document.querySelector("body").style.backgroundColor = "#222";
  document.querySelector(".score").textContent = score;
  document.querySelector(".number").textContent = "?";
  document.querySelector(".number").style.width = "15rem";
});
