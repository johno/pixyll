---
layout: post
robots: index,follow
published: true
comments: true

tags: [javascript, jquery, performance, html5]
icon: jquery

title: jQuery, data and performance
description: Best practice and data manipulation with jQuery, no added colourings or preservatives.
---

## TL;DR

jQuery makes elements-related data manipulation easy.

The HTML5 `data-*` attribute is linked in some way to the jQuery **data** object for DOM elements.

`$.data(element, key[, value])` deals with DOM elements related data.

`$.fn.data(key[, value])` deals with jQuery elements related data.

`$.data` is low-level and executes faster while `$.fn.data` is much more convenient and flexible. Futhermore, the second one can access to the `data-*` attributes.

{% highlight html %}
<!-- HTML -->
<div id="main-content"></div>
{% endhighlight %}

{% highlight javascript %}
// Javascript
var $el = $('#main-content');

$el.data('key', 'plop');    // fast
$.data($el, 'key', 'plop'); // 10 times faster
{% endhighlight %}

Finally, unlike `$.fn.attr`, both of these methods don't modify the DOM.

{% highlight javascript %}
$el.data('key', 'plop');
    // <div id="main-content"></div>
$.data($el, 'key', 'plop');
    // <div id="main-content"></div>
$el.attr('data-key', 'plop');
    // <div id="main-content" data-key="plop"></div>
{% endhighlight %}

## Data manipulation with jQuery

To attach an information to an element and manipulate it over script execution is dead easy with jQuery. Indeed, the library has methods to store, modify and delete data which are related to an element.

Futhermore, it's good to know that the `data-*` attributes introduced with HTML5 are automatically pulled as a jQuery **data** object. Doing so, they are accessible through some of its methods.

#### $.fn.data

The most popular method is `$.fn.data` which is used as below:

{% highlight javascript %}
// Affects the "plop" string to the "key" key
elem.data('key', 'plop');

// Reads the data with the "key" key
elem.data('key');
{% endhighlight %}

{% highlight html %}
<!-- Valid HTML5 code -->
<div id="elem" data-my-key="hey"></div>
{% endhighlight %}
{% highlight javascript %}
$('#elem').data('myKey'); // Outputs "hey"
{% endhighlight %}

<p class="islet">
    You'll notice that we remove <code>data-</code> and the HTML hyphens to specify the key the CamelCase way, accordingly to the <a href="http://www.w3.org/TR/html5/dom.html#embedding-custom-non-visible-data-with-the-data-*-attributes">W3C specification</a>.
</p>

[The documentation](http://api.jquery.com/data/) is very simple to get in and gives a good overview of the concept.

But wait there's more... use the `$.fn.removeData` method to clean all that mess:

{% highlight javascript %}
elem.removeData('key'); // Bye!
{% endhighlight %}

#### $.data

The library also comes with a more low-level and less known method, `$.data`. It plays the same role excepted the syntax and the fact that you need to provide a DOM element associated to the data as a parameter.

{% highlight javascript %}
// Affects the "plop" string to the "key" key
$.data(elem, 'key', 'plop');

// Reads the data with the "key" key
$.data(elem, 'key');
{% endhighlight %}

Here again, please have a look to the [official documentation](http://api.jquery.com/jQuery.data/).

We also get the `$.removeData` method to remove data and the `$.hasData` one to check if an element does or doesn't have data attached:

{% highlight javascript %}
$.hasData(elem);           // Outputs "true"
$.removeData(elem, 'key'); // Bye!
$.hasData(elem);           // Outputs "false"
{% endhighlight %}

## Performance vs. Power

Why should I use `$.data` when `$.fn.data` is much more sexy to write?

Well, as the method is low-level, **it goes way faster**!

{% highlight javascript %}
el.data('key', 'plop');    // fast
$.data(el, 'key', 'plop'); // up to 10 times faster
{% endhighlight %}

I invite you to [test performances by yourself](jsperf.com/jquery-fn-data-vs-data).

The other side of the coin is that it should attach data to a DOM element while `$.fn.data` can handle any sort of jQuery object, events included:

{% highlight javascript %}
// Affects each link index as a data for the "click" event
// When you click on a link, it shows its index
$("a").each(function(i) {
    $(this).on('click', {index:i}, function(e) {
        alert('My index is ' + e.data.index);
    });
});
{% endhighlight %}

Finally, `$.data` doesn't manage HTML5 `data-*` attributes while `$.fn.data` does.

Concretely:
- if you deal with an event, use `$.fn.data`
- if you deal with an HTML5 `data-*` attribute, use `$.fn.data`
- otherwise, use `$.data` because of performance

## A word about the DOM

It's also good to know that both of the `$.data` and `$.fn.data` methods **do not modify the DOM**.

More precisely, although the `$.fn.data` methods can access to `data-*` attributes, it wouldn't modify them in the DOM. You shouldn't get tricked because of the function abstraction: it's not the attribute you are manipulating but an automatically created **jQuery object**.

In return, the `$.fn.attr` method is an alternative to reach DOM attributes and to modify them.

{% highlight html %}
<div id="main-content" data-my-key="hey"></div>
{% endhighlight %}

{% highlight javascript %}
$('#main-content').data('myKey', 'plop');
    // Change the jQuery object, not the DOM
    // <div id="main-content" data-my-key="hey"></div>
    // Note: $('#main-content').data('myKey') outputs "plop"

$('#main-content').attr('data-my-key', 'plop');
    // Change effectively the DOM
    // <div id="main-content" data-key="plop"></div>
{% endhighlight %}

In the first code, we modified the jQuery object but nothing happen on the HTML.

In the second code however, we concretely modified the HTML.

Concerning performance, you might note that [the second is way faster than the first one](http://jsperf.com/jquery-fn-data-vs-fn-attr). A reason for that would probably be that `$.fn.data` does more than just "reach" the element: it performs some casting regarding to the type of the element.

Thus, it could be very helpful for plugins or widgets initialization:

{% highlight html %}
<div class="widget" data-row="2" data-responsive="true"></div>
{% endhighlight %}

{% highlight javascript %}
$('.widget').each(function () {
    $(this).myWidget(
        $(this).data('rows'),
        $(this).data('responsive')
    );
});
{% endhighlight %}

On the other hand, `$.fn.attr` will always output a string, which could be necessary sometimes.

## Last words

That's it for my short (but intense!) presentation of existing jQuery methods to manipulate data.

I thought that notes about performance would have been interesting, but it shouldn't be a concern: this is not what would make you script significantly faster. Still, it's good to know about it!

If I'm lucky enough, that may have been one of your *"Aha moment"* with JS ([as some people would call that](http://hugogiraudel.com/2013/04/30/css-aha-moment/)) =)

Plop!
