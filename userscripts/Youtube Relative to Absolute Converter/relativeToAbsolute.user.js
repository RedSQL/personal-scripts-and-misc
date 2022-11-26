// ==UserScript==
// @name        Relative to absolute converter for youtube
// @namespace   github.com/RedSQL/personal-scripts-and-misc
// @homepageURL https://github.com/RedSQL/personal-scripts-and-misc/
// @match       https://www.youtube.com/*
// @grant       none
// @version     1.0.0
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
        let desc_inner = document.getElementById("description-inner");
        if(typeof(desc_inner) != 'undefined' && desc_inner != null) {
          desc_inner.children[0].textContent = desc_inner.children[1].textContent;
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
  makeAbsolute();
})();