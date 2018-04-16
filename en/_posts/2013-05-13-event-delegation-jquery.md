---
layout: post
robots: index,follow
published: true
comments: true

tags: [javascript, performance, jquery, events]
icon: jquery

title: Event delegation in jQuery
description: A few reminder about event listeners and the event delegation best practices in jQuery.
---

## TL;DR

Before **jQuery 1.7** we used to distinguish `$.fn.bind` from `$.fn.live` and `$.fn.delegate` to create events listeners.

`$.fn.bind` is the most basic one which attach an event listener to an object, usually a DOM node.

`$.fn.live` is more powerful as it attach the event listener at the document root and makes the behavior *live* in every corresponding element of the DOM, even if they are created later.

`$.fn.delegate` behaves almost the same as `$.fn.live`, but you specify a DOM node where to attach your *live* listener, which is much more faster.

`$.fn.delegate` is more efficient than `$.fn.live` which is more efficient than `$.fn.bind`.

Since **jQuery 1.7**, all of these methods have been replaced by the `$.fn.on` method. Performance principles still the same, but the syntax changes.


## Never gonna `bind` you up

The most basic method to attach an event listener to a jQuery object. It's commonly used on DOM elements to create some interaction with the user:

{% highlight javascript %}
// Basic use of $.fn.bind
$('div#main-content').bind('click', function() { ... });
{% endhighlight %}

Your object is now listening at the event named `'click'` and will do something everytime this event is triggered. With the previous code, for instance, the functon defined will be triggered everytime you click on the `#main-content` element.

`'click'` is one of the usual events name which has a shorthand method which is equivalent:
{% highlight javascript %}
// Equivalent of the previous code
$('div#main-content').click(function() { ... });
{% endhighlight %}

However, you can pass any event name you may have specify within your code. In fact, this is the key start for [event-driven programming](http://en.wikipedia.org/wiki/Event-driven_programming) in JS, which helps to create advanced web-applications.

{% highlight javascript %}
$('#foo').bind('my-event', function() { ... });
$('#foo').trigger('my-event');  // Will trigger the binded event
{% endhighlight %}

<p class="islet">
    The method to stop such an event listener is <code>$.fn.unbind</code>.
</p>

Until **jQuery 1.7**, this was the most basic way to do things.


## Born to be a `live`

Although `$.fn.bind` principle is very nice, the method is very limited. It basically has two downsides:

1. It attaches an event listener for every single element which matches the selector, which is not the most efficient solution when you target more than one element

2. It attaches an event listener only for elements which matches the selector at this time, if you modify the DOM and want to create the same elements, you'll need to bind events again.

{% highlight javascript %}
// This sucks...
$('a.tooltip').bind('click', function() { ... });
// or $('a.tooltip').click(function() { ... });
{% endhighlight %}

The solution found before **jQuery 1.7** was the `$.fn.live` method:

{% highlight javascript %}
// Basic use of $.fn.live
$('li.text-info').live('hover', function() { ... });
{% endhighlight %}

Instead of attaching an event listener to every single element, it attaches just one at the *document root* level. Doing so, any new element which matches the selector will behave the same. Futhermore, it's **much more efficient** if you speak about performance.

<p class="islet">
    The method to stop such an event listener is <code>$.fn.die</code>.
</p>

The method is deprecated since **jQuery 1.7**, but the principle still the same, which is good to keep in mind.


## Learn to `delegate`

The `$.fn.delegate` method is basically the same than the `$.fn.live`, coming with the same advantages over `$.fn.bind`:

{% highlight javascript %}
// Basic use of $.fn.delegate
$('ul#main-navigation').delegate('li.text-info', 'hover', function() { ... });
{% endhighlight %}

The point is that, instead of attaching every event listener to the *document root*, you specify a DOM element where you want to focus. Doing so **increase significantly performance** as it's much more specific!

<p class="islet">
    The method to stop such an event listener is <code>$.fn.undelegate</code>.
</p>


## Turn me `on`

Since **jQuery 1.7**, all of the previous methods have been merged into one single, powerful method: `$.fn.on`.

Now you've understood the previous ones, let see what are the equivalent syntaxes with the single new method:

{% highlight javascript %}
// Basic use of $.fn.on instead of $.fn.bind
$('div#main-content').on('click', function() { ... });

// Basic use of $.fn.on instead of $.fn.live
$(document).on('hover', 'li.text-info', function() { ... });

// Basic use of $.fn.on instead of $.fn.delegate
$('ul#main-nav').on('hover', 'li.text-info', function() { ... });
{% endhighlight %}

The distinction between `$.fn.live` and `$.fn.delegate` is more clear with that single method, and the emphasis on a powerful delegation makes sense (excepted if you explicitly want to attach your listener to the root of the document, which is rare).

You can either pass **event data** through the method:

{% highlight javascript %}
// Give some data to the event
$("a").each(function(i) {
    $(this).on('click', {index:i}, function(e) {
        alert('My index is ' + e.data.index);
    });
});
{% endhighlight %}

The use of `$.fn.on` is pretty straightforward which makes event handling dead easy with jQuery!

<p class="islet">
    The method to stop such an event listener is... <code>$.fn.off</code>.
</p>

## What about performance?

As explained, here are the list of methods from the most efficient to the less one:

1. `.on(events, selector, [data,] handler)` equivalent to `$.fn.delegate`
2. `$(document).on(events, selector, [data,] handler)` equivalent to `$.fn.live`
3. `.on(events, [data,] handler)` equivalent to `$.fn.bind`

In a nutshell:

- If you need to attach an event listener to more than one element, use `.on(events, selector, [data,] handler)`
- If don't have any anchor to focus on, use `$(document).on(events, selector, [data,] handler)`
- Otherwise, use `.on(events, [data,] handler)`, or the shorthand function if exists

## Conclusion

This was a short and friendly reminder about event delegation in jQuery.

No hot news but such a big deal in this article. That was a point worth noting you could also find easily, doing some researches through the Internet.

I realized very few time ago that I always used shorthand functions, dealing with a bunch of DOM elements sometimes, when I could have used more efficient methods. **When you've to deal with more than one element, think about the `$.fn.on` method!**

I hope this have you learn something or refresh your mind on that point. If so, don't hesitate to leave me comment below ;-)

Plop!
