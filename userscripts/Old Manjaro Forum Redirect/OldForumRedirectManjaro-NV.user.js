// ==UserScript==
// @name        Manjaro's Old Forum Redirector - No Verification
// @namespace   github.com/RedSQL/personal-scripts-and-misc
// @match       https://forum.manjaro.org/*
// @grant       none
// @version     1.0.0
// @author      RedEclipse (RedSQL)
// @description Since old Manjaro forum is dead - this is a redirector to old posts from an old forum. No Verification edition! Does not ask you if you want to be redirected - redirects right away.
// @license     MIT (But see for the latest license here: github.com/RedSQL/personal-scripts-and-misc/blob/master/LICENSE)
// ==/UserScript==
;(() => {
  'use strict'
   window.addEventListener('load', function() {
     if (document.getElementById("main-outlet").getElementsByClassName("page-not-found")[0] && location.hostname == "forum.manjaro.org") {
        location.replace(`https://archived.forum.manjaro.org${location.href.substring(25)}`);
     }
    }, false);
})();
