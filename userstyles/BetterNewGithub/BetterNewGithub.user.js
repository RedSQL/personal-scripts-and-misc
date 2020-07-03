// ==UserScript==
// @name        Better New Github (UserScript Edition2)
// @namespace   github.com/RedSQL/personal-scripts-and-misc
// @match       https://github.com/*
// @grant       GM_addStyle
// @license     MIT (But see for the latest license here: github.com/RedSQL/personal-scripts-and-misc/blob/master/LICENSE)
// @version     0.0.2
// @author      RedEclipse (RedSQL)
// @description Why, Microsoft? If it ain't broke - don't fix it. 
// ==/UserScript==
;(function () {
  'use strict'
  window.addEventListener('load', function() {
    GM_addStyle(".container-xl{max-width:1800px!important}.container-lg{max-width:1800px!important}.avatar-user{border-radius:5%!important}.user-status-circle-badge-container{margin-bottom:0!important}");
  }, false);
})();
