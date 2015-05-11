/**
 * quojs-site - Micro #JavaScript Library for Mobile Devices.
 * @version v3.0.7
 * @link    http://quojs.tapquo.com
 * @author  Javi Jimenez Villar (http://soyjavi.com)
 * @license MIT
 */
(function(){"use strict";$$(function(){var t;return $$("[data-device] > *").on("touchstart",function(t){return $$(t.target).addClass("touch").children("abbr").html("")}),$$("[data-device] > *").swiping(function(t){return $$(t.target).attr("style","left: "+t.touch.delta.x+"px; top: "+t.touch.delta.y+"px;").children("abbr").html("swipping")}),$$("[data-device] > *").rotating(function(t){return console.log(t)}),$$("[data-device] > *").on("touchend",function(e){return t(e)}),t=function(t){return $$(t.target).removeClass("touch").attr("style","left: 0px; top: 0px;").children("abbr").html("")}})}).call(this);