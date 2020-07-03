// ==UserScript==
// @name        Better New Github (UserScript Edition)
// @namespace   github.com/RedSQL/personal-scripts-and-misc
// @match       https://github.com/*
// @grant       none
// @license     MIT (But see for the latest license here: github.com/RedSQL/personal-scripts-and-misc/blob/master/LICENSE)
// @version     1.0.0
// @author      RedEclipse (RedSQL)
// @description Why, Microsoft? If it ain't broke - don't fix it. 
// ==/UserScript==
@-moz-document domain("github.com") {
	    .container-xl, .container-lg {
	        max-width: 1800px !important;
	    }
	    .avatar-user {
	        border-radius: 5% !important;
	    }
	    /* Unrounding status button fix */
	    .user-status-circle-badge-container {
	        margin-bottom: 0px !important;
	    }
	}
