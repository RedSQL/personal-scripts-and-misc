// ==UserScript==
// @name        Shorts to standard video converter for YouTube
// @namespace   github.com/RedSQL/personal-scripts-and-misc
// @homepageURL https://github.com/RedSQL/personal-scripts-and-misc/
// @match       https://www.youtube.com/*
// @grant       none
// @version     1.0.0
// @author      RedSQL (RedEclipse)
// @description Replaces '/shorts' part of URL to '/watch?v=' in order to get original player for shorts videos.
// @license     MIT (But see for the latest license here: github.com/RedSQL/personal-scripts-and-misc/blob/master/LICENSE)
// @run-at      document-start
// ==/UserScript==
;(() => {
  'use strict'
  var lastURL = location.href;
  function clearUrlFunc() {  
    if(location.href.includes("/shorts")) {
      let vidID = location.href.substr(31); // video id starts here
      let cleanURL = 'https://www.youtube.com/watch?v=' + vidID;
      location.replace(cleanURL);
      lastURL = location.href;
    }
  }
  document.addEventListener("mousedown", function() {
    setTimeout(function(){
      if(lastURL != location.href) {
        clearUrlFunc();
      } 
    }, 200);
  });
  clearUrlFunc();
})();
