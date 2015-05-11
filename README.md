QuoJS
=====

[![Join the chat at https://gitter.im/soyjavi/QuoJS](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/soyjavi/QuoJS?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
[![Build Status](https://travis-ci.org/soyjavi/QuoJS.svg?branch=master)](https://travis-ci.org/soyjavi/QuoJS)

Is a micro, modular, Object-Oriented and concise JavaScript Library that simplifies HTML document traversing, event handling, and Ajax interactions for rapid mobile web development. It allows you to write powerful, flexible and cross-browser code with its elegant, well documented and micro coherent API.

Designed to change the way that you write JavaScript with the small size goal: a 5-6k gzipped library that handles most basic drudge work with a nice API so you can concentrate on getting stuff done. Released under the Open Source MIT license, which gives you the possibility to use it and modify it in every circumstance.

Current JavaScript libraries hate mobile, they are very big libraries that were built based on requirements of desktop devices, so mobile performance isn't optimal. Doesn't have a good support to touch events or a semantic API that would help the developer to create a good & cool JavaScript

*Current version: [3.0.7]()*


Getting Started
---------------
QuoJS only is not only a touch event manager, is an extensive library that requires no third-party JavaScript libraries (such as jQuery, Prototype, Kendo ...) to create complex projects and browser-based applications.

### Browser compatibility
- Mobile Browsers: Android Navigator 4+, Chrome for Android, Safari, FirefoxOS & Blackberry
- Desktop Browsers (no gestures available): Chrome 30+, Safari 4+, Firefox 24+ & Opera.

### GitHub
This is opensource, so feel free to fork this project to help us improve Quo. All source code is developed with CoffeeScript.

### Licensing
QuoJS is licensed under MIT licensed. See [LICENSE](https://github.com/soyjavi/QuoJS/blob/master/LICENSE.txt) for more information.

Touch events
------------
QuoJS supports the following gestures:

* **Touch**
* **Double-Tap**
* **Hold**
* **2xFingers Tap**
* **2xFingers Double-Tap**
* **Swipe Up**
* **Swipe Right**
* **Swipe Down**
* **Swipe Left**
* **Swipe**
* **Drag**
* **Rotate Left**
* **Rotate Right**
* **Rotate**
* **Pinch Out**
* **Pinch**
* **Fingers**

So you can also use QuoJS for mobile applicatios.

How to use
----------
The namespace to use QuoJS is the symbol $$, so (if you needed) you can instantiate other JavaScript libraries (such jQuery, Zepto...) that use the common symbol $.

```
// Find all <span> elements in <p> elements
$$('span', 'p');

//Subscribe to a tap event with a callback
$$('p').tap(function() {
    // affects "span" children/grandchildren
    $$('span', this).style('color', 'red');
});

// Chaining methods
$$('p > span').html('tapquo').style('color', 'blue');
```
#### Query Methods
QuoJS has a query engine for DOM Elements very similar to that already use in other famous libraries. Many of the methods already you use in jQuery have their version here:

```
// jQuery Compatible Query methods
.get(index)
.find('selector')
.parent()
.siblings('selector')
.children('selector')
.first()
.last()
.closest('selector')
.each(callback)
```
#### Element Methods
QuoJS has DOM Elements query engine very similar to that already use in other famous libraries. Many of the methods already you use in jQuery have their version here:

```
// Get/Set element attribute
.attr('attribute')
.attr('attribute', 'value')
.removeAttr('attribute')
// Get/Set the value of the "data-name" attribute
.data('name')
.data('name', 'value')
// Get/Set the value of the form element
.val()
.val('value')
// Show/Hide a element
.show()
.hide()
// get object dimensions in px
.offset('selector')
.height()
.width()
// remove element
.remove()
```
#### Style Methods
With QuoJS you can easily manage CSS styles of any DOM element of your project. The methods are fully verbose so it will be very easy to remember to apply the full power of CSS3

```
// set a CSS property
.style('css property', 'value')
 // add/remove a CSS class name
.addClass('classname')
.removeClass('classname')
.toggleClass('classname')
// returns true of first element has a classname set
.hasClass('classname')
// Set a style with common vendor prefixes
.vendor('transform', 'translate3d(50%, 0, 0)');
```
```
$$('article').style('height', '128px');
$$('article input').addClass('hide');

var houses = $$('.house');
if (houses.hasClass('ghost')) {
    houses.addClass('buuhh');
}
```
#### DOM Manipulation methods
These methods allow us to insert/update content inside an existing element.

```
// get first element's .innerHTML
.html()
// set the contents of the element(s)
.html('new html')
// get first element's .textContent
.text()
// set the text contents of the element(s)
.text('new text')
// add html (or a DOM Element) to element contents
.append(), prepend()
// If you like set a new Dom Element in a existing element
.replaceWith()
// Empty element
.empty()
```
```
$$('article').html('tapquo');
var content = $$('article').html(); //content is 'tapquo'
```
#### Events handler
Every frontend project needs a event management efficient, you can create your own events as well as subscribe to existing ones.

```
// add event listener to elements
.on(type, [selector,] function);
// remove event listener from elements
.off(type, [selector,] function);
// triggers an event
.trigger(type);
//If loaded correctly all resources
.ready(function);
```
```
// Subscribe for a determinate event
$$(".tapquo").on("tap", function);
// Trigger custom event
$$(".quojs").trigger("loaded");
// Loaded page
$$.ready(function() {
    alert("QuoJS rulz!");
});
```
#### Gestures Events
Although browsers only support touch events with QuoJS you have numerous events and gestures to help you make a usable project.

```
//Touch event, common event
.touch(function);
//Long tap event (650 miliseconds)
.hold(function);
//If you send two singleTap
.doubleTap(function);
```
#### Swipe methods
Not only have the basic swipe, you have more control over this gesture as used in the common native Apps.

```
.swipe(function);
//Detect if is swipping
.swiping(function);
//Swipe directions
.swipeLeft(function);
.swipeRight(function);
.swipeDown(function);
.swipeUp(function);
```
#### Pinch methods
As with the previous gesture, QuoJS have easy control over this gesture and its variations.

```
.pinch(function);
//Detect if is pinching
.pinching(function);
//Pinch zoom
.pinchIn(function);
.pinchOut(function);
```
#### Rotate methods
As with the previous gesture, QuoJS have easy control over this gesture and its variations.

```
.rotate(function);
//Detect if is rotating
.rotating(function);
//Rotate directions
.rotateLeft(function);
.rotateRight(function);
```
#### Ajax Methods
The main premise is to create ajax calls simple and fun.

```
$$.get(url, [parameters], [callback], [mime-type]);
$$.post(url, [parameters], [callback], [mime-type]);
$$.put(url, [parameters], [callback], [mime-type]);
$$.delete(url, [parameters], [callback], [mime-type]);
$$.json(url, [parameters], [callback]);
```
```
$$.json(url, {id: 1980, user: 'dan'}, function(data){ ... });
```
```
$$.ajax({
    type: 'POST', // defaults to 'GET'
    url: 'http://rest',
    data: {user: 'soyjavi', pass: 'twitter'},
    dataType: 'json', //'json', 'xml', 'html', or 'text'
    async: true,
    success: function(response) { ... },
    error: function(xhr, type) { ... }
});
```
#### Settings in Ajax Requests
You can establishing a common configuration for all ajax requests, defining timeouts, callbacks for success or error response.

```
//Default Settings
$$.ajaxSettings = {
    async: true,
    success: {},
    error: {},
    timeout: 0
};
//Set de default timeout to 1 second (1000 miliseconds)
$$.ajaxSettings.timeout = 1000;

//Set de default callback when ajax request failed
$.ajaxSettings.error = function(){ ... };
```
```
$$.ajaxSettings.async = false;
var response = $$.json('http://', {id: 1980, user: 'dan'});
```
