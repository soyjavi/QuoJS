/**
 * QuoJS - Micro #JavaScript Library for Mobile Devices.
 * @version v3.0.7
 * @link    http://quojs.tapquo.com
 * @author  Javi Jimenez Villar (@soyjavi) (https://twitter.com/soyjavi)
 * @license MIT
 */
(function(){"use strict";!function(i){var n,e,r,o,t,a;return r=null,n=/WebKit\/([\d.]+)/,e={Android:/(Android)\s+([\d.]+)/,ipad:/(iPad).*OS\s([\d_]+)/,iphone:/(iPhone\sOS)\s([\d_]+)/,Blackberry:/(BlackBerry|BB10|Playbook).*Version\/([\d.]+)/,FirefoxOS:/(Mozilla).*Mobile[^\/]*\/([\d\.]*)/,webOS:/(webOS|hpwOS)[\s\/]([\d.]+)/},i.isMobile=function(){return this.environment(),r.isMobile},i.environment=function(){var i,n;return r||(n=navigator.userAgent,i=t(n),r={browser:o(n),isMobile:!!i,screen:a(),os:i}),r},o=function(i){var e;return e=i.match(n),e?e[0]:i},t=function(i){var n,r,o;for(r in e)if(o=i.match(e[r])){n={name:"iphone"===r||"ipad"===r||"ipod"===r?"ios":r,version:o[2].replace("_",".")};break}return n},a=function(){return{width:window.innerWidth,height:window.innerHeight}}}(Quo)}).call(this);