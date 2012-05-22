$$(document).ready(function(event) {
    $$('#events').addClass('success');
});

// EVENTS
$$('section').touch(function(event) { $$(this).removeClass('success'); });
$$('section.touch').touch(function(event) { _touchInfo(event, 'touch', $$(this)); });
$$('section.tap').tap(function(event) { _touchInfo(event, 'tap', $$(this)); });
$$('section.doubletap').doubleTap(function(event) { _touchInfo(event, 'doubleTap', $$(this)); });
$$('section.hold').hold(function(event) { _touchInfo(event, 'hold', $$(this)); });
$$('section.swipe').swipe(function(event) { _touchInfo(event, 'swipe', $$(this)); });
$$('section.swiping').swiping(function(event) { _touchInfo(event, 'swiping', $$(this)); });
$$('section.swipeLeft').swipeLeft(function(event) { _touchInfo(event, 'swipeLeft', $$(this)); });
$$('section.swipeRight').swipeRight(function(event) { _touchInfo(event, 'swipeRight', $$(this));});
$$('section.swipeUp').swipeUp(function(event) { _touchInfo(event, 'swipeUp', $$(this)); });
$$('section.swipeDown').swipeDown(function(event) { _touchInfo(event, 'swipeDown', $$(this)); });
$$('section.drag').drag(function(event) { _touchInfo(event, 'drag', $$(this)); });
var _touchInfo = function(event, type, el) {
    el.addClass('success');
    console.log('Captured', event);
    $$('article').html('\
        Event: ' + type + '\
        Fingers: ' + event.fingers);
}