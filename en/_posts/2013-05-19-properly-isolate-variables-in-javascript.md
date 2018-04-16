---
layout: post
robots: index,follow
published: true
comments: true

tags: [javascript, jquery]

title: Properly isolate your variables in JavaScript
description: A story of immediately-invoked function expression (IIFE)... Know them, it could save your life!
---

## TL;DR

If you don't care about variable scoping in JavaScript, you may face some unpleasant troubles. **Properly isolate your script environment** is a best practice to have so you don't override global variables when it executes.

**Immediately-invoked function expressions** (IIFE) allow you do to that:

{% highlight javascript %}
(function() {
    // your JS code
})();
{% endhighlight %}

Moreover, it makes your code flexible and robust so you can create global variables aliases as parameters for your script:

{% highlight javascript %}
(function(window, $) {
    // your JS code
})(window, jQuery);
{% endhighlight %}


## It's all about scope

I bet you wouldn't like your new script not to behave as you want because the `gobgob` variable you use is already declared somewhere else and you didn't pay attention for that.

I would even be worse if your splendid slideshow plugin starts going wrong when your new script is executing. Why? Because you didn't notice that this plugin use the same variable you do and that you just change its value - if so, it wouldn't be such a splendid plugin by the way.

To avoid that kind of scenario, you have to **isolate your script** from the rest of the environment, so it's still safe. It's dead easy to do and, if your slideshow plugin were a good one, that's what it should have done!

#### Few reminder about scope in JS

If you declare properly a variable, it would be accessible from the whole script which is *inside* it's container.

{% highlight javascript %}
var gobgob = "Hey!";
function myFonction() {
    console.log(gobgob);
}

// Outputs "Hey!"
myFonction();
{% endhighlight %}

On the contrary, a variable properly declared into a function is not accesible from the outside of this function: the scope is limited to the function.

However, if you forget to use the `var` keyword when you declare your variable, you'll make it **global** which means it would be accessible from anywhere - which is generally not a best practice.

{% highlight javascript %}
function myFonction() {
    var gobgob = "Hey!";
    gubgub = "Ho!";
}

myFonction();

// Outputs "ReferenceError: gobgob is not defined"
console.log(gobgob);

// Outputs "Ho!"
console.log(gubgub);
{% endhighlight %}

We don't want our script variables override any other variables which would eventually exists!

{% highlight javascript %}
var gobgob = "Hey!";

// (...)
// Somewhere else far far away in your JavaScript...
// ... a wild override of an existing (and forgetted) variable appears!
var gobgob = "Ho!";
{% endhighlight %}


## Don't forget the love glove!

To resolve our problem, we just need to **isolate variables** so we limit their scope to the code we decided to.

To do so, we wrap our JavaScript code into what we called an IIFE - or a **self-executing anonymous function** apparently - :

{% highlight javascript %}
(function() {
    // your JS code
})();
{% endhighlight %}

This code encapsulation is:

- **anonymous** because you don't name the function
- **self-executing** or immediately-invoked thanks to the final little `();`

Going back to our previous example:

{% highlight javascript %}
var gobgob = "Hey!";

// We wrap our script properly
(function() {
    var gobgob = "Ho!";

    // Outputs "Ho!"
    console.log(gobgob);
})();

// Outputs "Hey!" -> bingo !
console.log(gobgob);
{% endhighlight %}

Nothing is changed for script execution.

But **we don't have to worry about other variables** which could exist because we now work into a safe environment: we won't modify a global variable inadvertently!

However, we can still use global variables inside our code:

{% highlight javascript %}
var gobgob = "Hey!";

(function() {
    // Outputs "Hey!"
    console.log(gobgob);
})();
{% endhighlight %}

#### Rename global variables in our script

It's even possible to **pass variables as parameters** for your script. You can generally redefine them for your script usage, which is good if you're working with some library such as *jQuery*.

Imagine you'd like to create a tiny nice script using *jQuery*. You'd probably use `$` everywhere.

What if I told you we're now using another library which also uses `$` as an alias? You'd probably pass *jQuery* [in `noConflict()` mode](http://api.jquery.com/jQuery.noConflict/)... and you'll have to change your script to replace `$` with `jQuery`.

Or you'd have listen to me and these two lines of code would have properly isolate your script which would execute, regardless of your environment:

{% highlight javascript %}
(function($) {
    // your JS script with a bunch of $
})(jQuery);
{% endhighlight %}

The good part of this technique is that you could quickly switch library without changing anything in your script, which is more flexible and stable:

{% highlight javascript %}
(function($) {
    // your JS script with a bunch of $
})(Zepto);
{% endhighlight %}

<p class="islet">
    <strong>Performance note</strong> - When you minify your script, it'd minify your variables' name without ruining your code, so it would make it even smaller as a result.
</p>

{% highlight javascript %}
// Example with minification for `window`
(function(a) {
    console.log(a === window); // Outputs `true`
})(window);
{% endhighlight %}

#### Tip 1: Create an alias for `undefined`

One of JS best practice that [*jQuery* uses in its source code](http://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.js) is to declare a last parameter which is not defined and would be equal to `undefined` in your script:

{% highlight javascript %}
(function(window, $, undefined) {
    // Create a gobgob variable which value is `undefined`
    var gobgob;
    console.log(gobgob === undefined);  // Outputs `true`

    // Our last variable is an alias for `undefined`
})(window, jQuery);
{% endhighlight %}

#### Tip 2: Still access to variables, from the outside

*Thanks [@fabien0102](https://twitter.com/fabien0102) for pointing this was missing.*

Isolate your code is good. But you'd sometimes need to develop a plugin/a library and you'd like to access the main object from the outside, so you can use it.

There are a bunch of possibilities but here is, IMHO, the simplest one: you just need to attach your variable to `window` so it becomes global for the other scripts.

{% highlight javascript %}
(function(window, undefined) {
    // Create a gobgob variable and attach it to window
    var gobgob = "Hey!";
    window.gobgob = gobgob;
})(window);

// Outputs "Hey!"
console.log(gobgob);
{% endhighlight %}


## Final words

This post is not a really new one and you can find a bunch of that kind all over the web. But it's still a few reminder to start thinking about modular scripts which are components for bigger projects.

Finally, the most we speak about that, the most developers are likely to use this best practice.

As usual don't hesitate to leave me comments, suggestions or even questions if you need to.

Plop!
