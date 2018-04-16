---
layout: post
robots: index,follow
published: true
comments: true

tags: [javascript, backbone.js, privacy]

title: Private methods with Backbone.js
description: Why and how to create private methods. How to concretely implement that while using Backbone.js.
---

## Private method, what is that?

To keep it short: a private method is a method which is not exposed and can't be called "from the outside".

It's just a matter of **scope** after all.

{% highlight javascript %}
function yolo() {
  var privateMethod = function() {
    console.log( "can't be accessed outside of `yolo()`" );
  };
  var privateVar = true;

  // here, you can call `privateMethod` if you wish to.
  // here, `privateVar` returns `true`.

  return "that's all you've got from me!";
}

// here, `privateMethod` doesn't even exist.
// here, `privateVar` is undefined.

yolo(); // returns "that's all you've got from me!"
{% endhighlight %}

This notion makes sense with the *module pattern*.

To learn more on that subject, I'd strongly recommend this post among others: [Mastering the module pattern](http://toddmotto.com/mastering-the-module-pattern), simple and efficient.

Well, concretely, here's what you've got:

{% highlight javascript %}
var MyModule = (function () {
  // a bunch of encapsulated stuff -> private if not exposed
  var _cantTouchThis = function() {
    console.log( "I just met you!" );
  };

  var _nbOfCats = 3;

  // what you return when the method is executed
  // -> what you expose (= public).
  return {
    nbOfRainbows: 10,
    sayHi: function() {
      console.log( "Hi!" );
    },
    logNumberOfRainbows: function() {
      console.log( this.nbOfRainbows );
    },
    logNumberOfCats: function() {
     console.log( _nbOfCats );
    },
    touchThis: function() {
      console.log( "Hey!" );
      _cantTouchThis();
    }
  };
})();
{% endhighlight %}

This allow you to manipulate the public part — **the interface** — without having access to the private part:

{% highlight javascript %}
MyModule.nbOfRainbows = 42;
MyModule.logNumberOfRainbows(); // returns "42"
MyModule.logNumberOfCats(); // returns "3"
MyModule.touchThis(); // returns "Hey!" "I just met you!"
{% endhighlight %}

## Private methods… for what?

That's a legitimate question. I personally found 2 advantages of a private method:

- it **simplifies the public interface** hiding technical details of the implementation
- it **doesn't have to be unit tested**

The first point is generally obvious. The second one arises from the first point, but may turn you suspicious. Let me explain…

## Unit tests and private methods

To test our module, we instantiate it, then take every single method and check the output for a given input (variable + context). We *unitly* test the exposed method, taking care to make the input vary to test every use case and get a good test coverage.

We can remind the **Test Driven Development** (TDD) process:

- first write the test with required use cases for our functionality
- then code the method, pass tests
- refactor code to clean the whole thing. As long as tests pass, you didn't break anything.

The *refactor* step is the last one because we first want to produce something that works, then focus on optimizations.

Let's get back to private methods: since they are not exposed, they are not *technically* unit tested. In fact, not directly.

## Some considerations about private methods

The TDD point can leave you suspicious depending on the manner you consider and use the privacy notion. I think there is two ways of doing things:

1. first code everything as private, then expose what needs to be
1. private methods came from public methods refactor step

### How to choose between private and public?

Considering you're doing TDD… you develop the public interface **first** — that's what you're testing after all —.

Personally, I code my (failing) tests, then my public interface: public methods or *event handlers* — we'll talk about that few lines below —. Nothing private with my code at this point.

Private methods appears during refactor step, at last. And if I don't have time for that the code is working, at least.

Finally, **unit tests test the public interface**.

Private methods are tested through public ones. You may think that testing the detail of technical implementation would be a great idea to ease the debug part, but this would be also a cost to implement and maintain. On the contrary, I can update / refactor private methods as long as my module is still working as expected.

If I have to choose, I'd prefer to invest in testing more use case. The coverage will tell me if I actually test private methods, passing by.

### About events handlers

Public interface matters.

What about events that make our module react? Should event handlers (e.g. `onClick()` & cie.) be public to be tested?

Well, no.

We're talking about events. Our module is listening and reacting upon events. Tests should triggers these events and observe the expected behavior. The binded method could either be public or private, it doesn't really matter here as we're testing the event.

### Prefix with "_"

That's a largely adopted convention: prefix private methods / variables names with `_`.

This is also what I do for 2 reasons:

1. this is a convention which makes things clear. There is no such a thing than `private` in JS, but most of developers will understand the prefixed method is "supposed" private…
1. this can ease automated documentation plugins work. If you're lucky, the doc autocompletion will understand the method is private and won't forget about the `@private`.

Finally, it's about **readability**. The *private* nature of the `_joke()` method is explicit.

However, it's a common practice that this convention is used to try to **define** the private nature of a method, instead of just make it explicit. That means the public interface is composed with methods prefixed with `_` to tell those should be *considered as private*.

<p class="islet">
  This is a hot point, with a lot of debates. On my own experience, this is generally something which appears when you don't really know how to really set up privacy. Everything is public then, but you tell some methods are <em>private by intention</em>.
</p>

It's relatively easy to introduce privacy with the *module pattern* in fact. Then, my advice would be to consider everything that is exposed as public. If you actually want a method to be private, let's make it actually private and use the `_` prefix for code readability.

That said, projects should define and follow convention that fit their need.

### It's not part of the prototype… what about inheritance and performance?

That's true. As long as it is not reachable, **a private method can't be inherited**. This is basically why I consider private method as a way to simplify the exposed interface of my module. If I need the implementation detail, if I need to access it by inheritance, then I need this detail to be public.

Here again, scepticism is not really caused because of the nature of private methods, but because of a clumsy interpretation / implementation of these.

A note on performance: there will be as much private methods as instances of the module, which is technically *less performant*. But, [having look the actual impact](http://jsperf.com/public-vs-private-methods), I think this remark belongs to premature optimization for my current use of privacy.

### How do I access public methods from private ones?

That could be blocking.

In fact, if my private method came from a public method refactor, this is not blocking at all. Just because my private method is meant to simplify the public interface, to make the public method **more readable**.

From my point of view, the private method is kind of a own helper for the module, which helps him to perform its job. Every variable the method needs should be passed as parameters.

Doing so, you can even pass the public interface context to the private method:

{% highlight javascript %}
var MyModule = (function () {
  var _addSomeCats = function( context ) {
    context.cats++;
    context.logNumberOfCats();
  };

  return {
    cats: 1,
    addSomeCats: function() {
      // This is not really useful to wrap the whole thing in
      // a private method, but that's a way to illustrate how
      // you can pass it the context.
      _addSomeCats( this );
    },
    logNumberOfCats: function() {
      console.log( this.cats );
    }
  };
})();
{% endhighlight %}

Will give you:

{% highlight javascript %}
MyModule.addSomeCats(); // returns "2"
{% endhighlight %}

<p class="islet">
  In this example, I'm passing the context as a parameter.<br>
  Actually, it's possible to use <code>this</code> in the <code>_addSomeCats</code> method and then call it with the context bound, thanks to <code>.call()</code> this way: <code>_addSomeCats.call( this );</code>.
</p>

Previous example is not a such a big deal, but here's what it could looks like in an actual project:

{% highlight javascript %}
var MyModule = (function () {
  // alt. syntax for `var _createViewInstance = function() { … }`.
  // we refactor here some repetitive tasks of the module.
  function _createViewInstance ( View, $parent ) {
    if ( !View ) throw new Error( "No View constructor provided" );
    if ( !$parent ) throw new Error( "No $parent provided" );

    var view = new View();
    view.$el.appendTo( $parent );
    view.render();

    return view;
  }

  // …

  return {

    onRender: function() {
      try {
        this.ordersView = _createViewInstance( this.OrdersView, $( "#orders" ) );
      } catch ( err ) {
        app.err( err ); // -> our way to log errors that would occur
        this.ordersView = {};
      }

      // a bunch of other stuff…
    }

    // …
  };
})();
{% endhighlight %}

Which leads you directly to **Backbone.js**.

## Implementation with Backbone.js

This is the main reason for this post. After you understood the concept and mastered the way you set up actual privacy with a module, you could end up puzzled on how to implement that when you usually deal with this:

{% highlight javascript %}
var MyModule = (function() {

  var Books = {};

  Books.Model = Backbone.Model.extend({

    // a bit of configuration…

    isPrivate: function() {
      console.log( "certainly not…" );
      return false;
    },

    _intendedToBePrivate: function() {
      // kind of method that would pop with this implementation.
    }

  });

  // …

  return Books;

})();
{% endhighlight %}


Finally, it's that simple: `.extend()` will accept an object. Alright, let's give him an [IIFE](http://nicoespeon.com/en/2013/05/properly-isolate-variables-in-javascript/) that will return this object — its API —.

{% highlight javascript %}
var MyModule = (function() {

  var Books = {};

  var ModelConfiguration = (function() {
    var _actuallyPrivate = function() {
      console.log( "look 'ma, I'm private!" );
    };

    // expose the configuration.
    return {

      defaults: {
        isCompleted: false
      },

      urlRoot: "/order",

      isCompleted: function() {
        _actuallyPrivate();
        return this.get( "isCompleted" );
      }

    };
  })();

  Books.Model = Backbone.Model.extend( ModelConfiguration );

  // …

  return Books;

})();
{% endhighlight %}

## Last words

Private methods in JavaScript is a subject that can feeds a lot of debates and one can remain skeptical about that. Sometimes — often? — it makes the whole thing more complex. That's why I think every project should adopt the position that correspond the best to their needs.

For my part, **I create private methods during refactor step**. If the method is public by nature, I'll treat it as such: no `_` prefix, unit tests. The most important thing for me is not fooling myself with a convention.

However, I struggled for some time to imagine how it could work using *Backbone.js*. As it takes me some time to work the whole thing out, here is my contribution post to help those who may enter the same reflexion I've had.

That said, this is a subject full of debates and interesting reflexions. Don't hesitate to share suggestions and remarks if you're passing by!
