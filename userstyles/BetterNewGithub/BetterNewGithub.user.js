// ==UserScript==
// @name        Better New Github (UserScript Edition)
// @namespace   github.com/RedSQL/personal-scripts-and-misc
// @match       https://github.com/*
// @grant       GM_addStyle
// @grant       GM_getResourceText
// @resource    userScriptingSucksCSS https://raw.githubusercontent.com/RedSQL/personal-scripts-and-misc/master/userstyles/BetterNewGithub/BetterNewGithub.user.css
// @license     MIT (But see for the latest license here: github.com/RedSQL/personal-scripts-and-misc/blob/master/LICENSE)
// @version     0.0.3
// @author      RedEclipse (RedSQL)
// @author      pavlukivan
// @description Why, Microsoft? If it ain't broke - don't fix it. 
// ==/UserScript==
;(() => {
  'use strict'
  var cssData;
  window.addEventListener('load', function() {
    try {
      cssData = GM_getResourceText("userScriptingSucksCSS");
    } catch(x) {
      alert("Could not fetch CSS. Errored out with: " + x + ". Falling back to hardcoded version.");
      GM_addStyle(".container-xl{max-width:1800px!important}.container-lg{max-width:1800px!important}.avatar-user{border-radius:5%!important}.user-status-circle-badge-container{margin-bottom:0!important}");
    }
    if(cssData) {
      // thanks @pavlukivan
      cssData = cssData.substr(0, cssData.length - 2).replace('@-moz-document domain("github.com") {', '');
      GM_addStyle(cssData.replace('@-moz-document domain("github.com") ', ''));
    }
  }, false);
})();
