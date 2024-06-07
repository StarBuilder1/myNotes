"use strict";

//Read DOM Obj
const labelTimer = document.querySelector(".timer");
const labelWelcome = document.querySelector(".welcome");
const containerApp = document.querySelector(".app");

/// Set a logout interval Timer///
const startLogoutTimer = function () {
  let time = 5;

  const tick = function () {
    const min = String(Math.trunc(time / 60)).padStart(2, "0");
    const second = String(time % 60).padStart(2, "0");

    //set label content
    labelTimer.textContent = `${min}:${second}`;

    //Clear interval
    if (time === 0) {
      clearInterval(timer);
      containerApp.style.opacity = 0;
      labelWelcome.textContent = "Pls Log in to get access!";
    }
    //next time
    time--;
  };

  //Operate when starting
  tick();
  //Continue to work
  const timer = setInterval(tick, 1000);
};

/// Call that function ///
//可以写在登录逻辑中，一旦登录就触发//
startLogoutTimer();
