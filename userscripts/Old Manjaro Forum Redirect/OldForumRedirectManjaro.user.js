// ==UserScript==
// @name        Manjaro's Old Forum Redirector
// @namespace   github.com/RedSQL/personal-scripts-and-misc
// @match       https://forum.manjaro.org/*
// @grant       none
// @version     1.0.0
// @author      RedEclipse (RedSQL)
// @description Since old Manjaro forum is dead - this is a redirector to old posts from an old forum.
// @license     MIT (But see for the latest license here: github.com/RedSQL/personal-scripts-and-misc/blob/master/LICENSE)
// ==/UserScript==
;(() => {
  'use strict'
   window.addEventListener('load', function() {
     if (document.getElementById("main-outlet").getElementsByClassName("page-not-found")[0] && location.hostname == "forum.manjaro.org") {
       if (window.confirm("Oops! It appears that you have stumbled upon a 404 page on Manjaro forum. There is a chance that you could be looking for a post from the old forum. Want to be redirected to archived version of the old forum?")) {
         location.replace(`https://archived.forum.manjaro.org${location.href.substring(25)}`);
       }
     }
    }, false);
})();
