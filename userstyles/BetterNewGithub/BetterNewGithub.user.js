// ==UserScript==
// @name        Better New Github (UserScript Edition)
// @namespace   github.com/RedSQL/personal-scripts-and-misc
// @match       https://github.com/*
// @grant       none
// @license     MIT (But see for the latest license here: github.com/RedSQL/personal-scripts-and-misc/blob/master/LICENSE)
// @version     0.0.1
// @author      RedEclipse (RedSQL)
// @description Why, Microsoft? If it ain't broke - don't fix it. 
// ==/UserScript==
;(function () {
  'use strict'
  window.addEventListener('load', function() {
  var elems_array = ['container-xl','container-lg','avatar-user','user-status-circle-badge-container'];
  for (var x in elems_array) {
    var elem = document.getElementsByClassName(elems_array[x]);
    for (var i in elem){
      if (elem.hasOwnProperty(i)) {
        console.log(elem[i]);
        switch(elems_array[x]) {
          case 'container-lg':
            elem[i].style.maxWidth = '1800px';
            break;
          case 'container-xl':
            elem[i].style.maxWidth = '1800px';
            break;
          case 'avatar-user':
            elem[i].style.borderRadius = '5%';
            break;
          case 'user-status-circle-badge-container':
            elem[i].style.marginBottom = '0px';
            break;
          default:
            console.log("Nothing to do.")
        }
      }
    }
  }
  }, false);
})();
