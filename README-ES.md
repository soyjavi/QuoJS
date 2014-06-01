QuoJS
=====
Quo es una micro librería JavaScript modular y orientada a objectos que simplifica la gestión del documento HTML,la gestión de eventos y las interacciones con Ajax para el desarrolo agil de nuestras aplicaciones móviles. Te permite escribir código flexible y util para todos los navegadores.

Diseñado para cambiar la manera en la que escribes JavaScript, con la meta de que tan solo ocupe 5-6k gzipped y se capaz de manejar todo ese trabajo duro con una API muy limpia.

Las librerías actuales de JavaScript odian el desarrollo móvil, son enormes y enfocadas unicamente en las necesidades de las aplicaciones de escritorio, por lo tanto el rendimiento movil no es óptimo. Ademas de no soportar la mayor parte de los gestos que habituamos usar en nuestros móviles. Quo ayuda al desarrollador a hacer un buen código JavaScript además de bonito.

*Current version: [3.0.2]()*


Empieza a usarlo
---------------
QuoJS no es solo un gestor de eventos táctiles, es una libería extensible que no necesita de otras liberías (como JQuery,Prototype,Kendo...) para crear complejas aplicaciones basadas en navegador.

### GitHub
QuoJS es opensource por lo que el código esta disponible para nos ayudes a mejorarlo. Está completamente escrito en CoffeeScript.


### Licencia
QuoJS utiliza una licencia MIT. Para mas información [LICENSE](https://github.com/soyjavi/QuoJS/blob/master/LICENSE.txt) for more information.

Eventos táctiles
------------
QuoJS da soporte para los siguientes eventos táctiles:

* **Tap**
* **Single Tap**
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

Así que es perfecto para utilizarlo en aplicaciones móviles.

Como utilizar Quo
-----------------
El namespace reservado para utilizar QuoJS es $$, así que si lo necesitas podrías instanciar otras librerías JavaScript como JQuery o Zepto que utilizan el symbolo $.

```
// Encuentra todos los elementos <span> dentro de los elementos <p>
$$('span', 'p');

//Suscribete al evento tap con un callback
$$('p').tap(function() {
    // affects "span" children/grandchildren
    $$('span', this).style('color', 'red');
});

// Encadenación de métodos
$$('p > span').html('tapquo').style('color', 'blue');
```
#### Métodos de Consulta
QuoJS utiliza un motor de consultas para elementos del DOM muy similar al usado en otras librerías famosas de JavaScript. Muchos de los métodos que utilizas en JQuery tienen su versión en Quo:

```
// Métodos compatibles con JQuery
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
#### Métodos para los elementos
QuoJS también dispone una versión de los métodos para manejar a los elementos del DOM mas utilizados:

```
// Get/Set de los atributos de un elemento
.attr('attribute')
.attr('attribute', 'value')
.removeAttr('attribute')
// Get/Set del valor del atributo "data-name"
.data('name')
.data('name', 'value')
// Get/Set del valor de un elemento form
.val()
.val('value')
// Mostrar o ocultar un elemento
.show()
.hide()
// Obtener las dimensiones de un elemento en pixels
.offset('selector')
.height()
.width()
// Eliminar un elemento
.remove()
```
#### Métodos de estilo
Con QuoJS puedes manejar facilmente los estilso CSS de cualquier elemento de DOM. Los métodos son muy descriptivos por lo que te será fácil recordar todos los beneficios de CSS3.

```
// Set de una propiedas CSS
.style('css property', 'value')
 // Añadir/Quitar una clase CSS
.addClass('classname')
.removeClass('classname')
.toggleClass('classname')
// Devuelve true si el elemento contiene la correspondiente clase
.hasClass('classname')
// Set de un estilo con los prefijos de los vendor mas comunes
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
#### Métodos para manipular el DOM
Los siguientes métodos te permitiran insertar o actualizar el contenido de un elemento.

```
// Obten el .innerHTML del primer elemento
.html()
// Set de los contenidos de un elemento
.html('new html')
// Obten el .textContent del primer elemento
.text()
// Set del contenido text de los elementos
.text('new text')
// Añade HTML o un elemento del DOM
.append(), prepend()
// Remplazar un elemento con otro
.replaceWith()
// Vaciar un elemento
.empty()
```
```
$$('article').html('tapquo');
var content = $$('article').html(); //content is 'tapquo'
```
#### Gestor de eventos
Todo proyecto frontend necesita un gestor de eventos que sea eficiente, con Quo puedes crear tus propios eventos a la vez que suscribirte a los ya existentes.

```
// Añade un event listener a los elementos
.on(type, [selector,] function);
// Elimina un  event listener a los elementos
.off(type, [selector,] function);
// Dispara un evento
.trigger(type);
//Comprueba si se han terminado de cargar los elementos
.ready(function);
```
```
// Suscribirse a un evento en concreto
$$(".tapquo").on("tap", function);
// Disparar un evento personalizado
$$(".quojs").trigger("loaded");
// Cuando la página esté cargada...
$$.ready(function() {
    alert("QuoJS rulz!");
});
```
#### Eventos táctiles
Dispones de los eventos táctiles mas utilizados para ayudarte a proporcionar mayor usabilidad a tu aplicación

```
//Evento Tap
.tap(function);
//Evento Tap prolongado (650 milisegundos)
.hold(function);
//Evento de Single Tap
.singleTap(function);
//Evento de Tap Doble
.doubleTap(function);
```
#### Métodos para Swipe (Desplazar)
Not only have the basic swipe, you have more control over this gesture as used in the common native Apps.
Además del swipe básico, dispone de mas control añadido a este gesto como en las Apps nativas mas comunes.

```
.swipe(function);
//Detectar si se está efectuando un swipe
.swiping(function);
//Direcciones del swipe
.swipeLeft(function);
.swipeRight(function);
.swipeDown(function);
.swipeUp(function);
```
#### Métodos para Pinch (Pellizcar)
Como en el caso del Swipe, QuoJS implementa variaciones sobre este gesto.

```
.pinch(function);
//Detectar el pinch
.pinching(function);
//Pinch zoom
.pinchIn(function);
.pinchOut(function);
```
#### Métodos para Rotación
De la misma manera que en los casos anteriores QuoJS dispone de los gestos de rotación mas habitualuas y algunas variantes.

```
.rotate(function);
//Detectar si se está rotando
.rotating(function);
//Dirección de las rotaciones
.rotateLeft(function);
.rotateRight(function);
```
#### Métodos Ajax
La meta principal de Quo con Ajax es convertir las llamadas en algo sencillo y divertido.

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
#### Configuración de las llamadas Ajax
Puedes establecer la configuración de las peticiones Ajax definiendo los timeouts y los callbacks en caso de éxito o error.

```
//Configuración por defecto
$$.ajaxSettings = {
    async: true,
    success: {},
    error: {},
    timeout: 0
};
//Poner el timeout pro defecto a 1 segundo (1000 milisegundos)
$$.ajaxSettings.timeout = 1000;

//Cambiar el callbac de error por defecto
$.ajaxSettings.error = function(){ ... };
```
```
$$.ajaxSettings.async = false;
var response = $$.json('http://', {id: 1980, user: 'dan'});
```



