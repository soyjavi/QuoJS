/**
 * QuoJS - Micro #JavaScript Library for Mobile Devices.
 * @version v3.0.7
 * @link    http://quojs.tapquo.com
 * @author  Javi Jimenez Villar (@soyjavi) (https://twitter.com/soyjavi)
 * @license MIT
 */
(function(){"use strict";!function(t){var n,s,r;return n=["-webkit-","-moz-","-ms-","-o-",""],t.fn.addClass=function(t){return this.each(function(){var n,r,e,i,u;for(e=s(t),i=[],n=0,r=e.length;r>n;n++)u=e[n],i.push(this.classList.add(u));return i})},t.fn.removeClass=function(t){return this.each(function(){var n,r,e,i,u;for(e=s(t),i=[],n=0,r=e.length;r>n;n++)u=e[n],i.push(this.classList.remove(u));return i})},t.fn.toggleClass=function(t){return this.each(function(){var n,r,e,i,u;for(e=s(t),i=[],n=0,r=e.length;r>n;n++)u=e[n],i.push(this.classList.toggle(u));return i})},t.fn.hasClass=function(t){return this.length>0&&this[0].classList.contains(t)},t.fn.listClass=function(){return this.length>0?this[0].classList:void 0},t.fn.style=t.fn.css=function(t,n){var s;return null!=n?this.each(function(){return this.style[t]=n}):(s=this[0],s.style[t]||r(s,t))},t.fn.vendor=function(t,s){var r,e,i,u;for(u=[],r=0,e=n.length;e>r;r++)i=n[r],u.push(this.style(""+i+t,s));return u},r=function(t,n){return document.defaultView.getComputedStyle(t,"")[n]},s=function(t){return Array.isArray(t)||(t=[t]),t}}(Quo)}).call(this);