// ==UserScript==
// @name        Relative to absolute converter for youtube
// @namespace   github.com/RedSQL/personal-scripts-and-misc
// @homepageURL https://github.com/RedSQL/personal-scripts-and-misc/
// @match       https://www.youtube.com/*
// @grant       none
// @version     1.1.0
// @author      RedSQL (RedEclipse)
// @description Replaces relative video timestamp from the video description to absolute.
// @license     https://github.com/RedSQL/personal-scripts-and-misc/blob/master/LICENSE
// @run-at      document-end
// ==/UserScript==
;(() => {
  'use strict'
  var lasturl = location.search;
  function makeAbsolute() {
    if(location.pathname == "/watch") {
      var pageLoadWait = setInterval(function () {
        let desc_inner = document.getElementById("info-container");
        let date_absolute = document.querySelectorAll('tp-yt-paper-tooltip.style-scope.ytd-watch-info-text')[0].textContent.trim();
        if (!date_absolute || date_absolute.length == 0) {
          date_absolute = document.querySelectorAll('tp-yt-paper-tooltip.style-scope.ytd-watch-info-text')[0].outerText.trim();
        }
        if(typeof(desc_inner) != 'undefined' && desc_inner != null && date_absolute != null) {
          desc_inner.textContent = date_absolute;
          desc_inner.style.setProperty("font-weight",500);
          clearInterval(pageLoadWait);
        } else {
          console.log("Page still not processed fully...");
        }
      }, 1000);
    }
  }
  document.addEventListener("mousedown", function() {
    setTimeout(function(){
      if(lasturl != location.search) {
        makeAbsolute();
        lasturl = location.search;
      }
    }, 200);
  });
  document.addEventListener("popstate", function() {
    setTimeout(function(){
      if(lasturl != location.search) {
        makeAbsolute();
        lasturl = location.search;
      }
    }, 2000);
  });
  makeAbsolute();
})();
