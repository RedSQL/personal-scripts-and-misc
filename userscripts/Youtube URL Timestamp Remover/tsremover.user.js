// ==UserScript==
// @name        Hardcoded URL Timestamp Remover
// @namespace   github.com/RedSQL/personal-scripts-and-misc
// @homepageURL https://github.com/RedSQL/personal-scripts-and-misc/
// @match       https://www.youtube.com/watch*
// @grant       none
// @version     1.0.0
// @author      RedSQL (RedEclipse)
// @description Removes &t=num from the URL on youtube videos so youtube has to pull latest timestamp elsewhere.
// @license     MIT (But see for the latest license here: github.com/RedSQL/personal-scripts-and-misc/blob/master/LICENSE)
// ==/UserScript==
;(() => {
  'use strict'
    if(location.search.includes("&t=")) {
      let cleanurl = location.href.split("&");
      cleanurl.splice(cleanurl.indexOf('t='), 1);
      location.replace(cleanurl.join("&"));
    }
})();
