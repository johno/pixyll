---
layout: post
robots: index,follow
published: true
comments: true

tags: [javascript, functional programming]

title: Pure functions in JavaScript
description: What is a pure function and why should you consider it in JavaScript?
---

## What's that a "pure" function?

A pure function **doesn't depend on** and **doesn't modify the states of variables out of its scope**.

Concretely, that means **a pure function always returns the same result given same parameters**. Its execution doesn't depend on the state of the system.

Pure functions are a pillar of [functional programming](http://en.wikipedia.org/wiki/Functional_programming).

### Give me examples

{% highlight javascript %}
var values = { a: 1 };

function impureFunction ( items ) {
  var b = 1;

  items.a = items.a * b + 2;

  return items.a;
}

var c = impureFunction( values );
// Now `values.a` is 3, the impure function modifies it.
{% endhighlight %}

Here we modify the attributes of the given object. Hence we modify the object which lies outside of the scope of our function: the function is impure.

{% highlight javascript %}
var values = { a: 1 };

function pureFunction ( a ) {
  var b = 1;

  a = a * b + 2;

  return a;
}

var c = pureFunction( values.a );
// `values.a` has not been modified, it's still 1
{% endhighlight %}

Now we simply modify the parameter which is in the scope of the function, nothing is modified outside!

{% highlight javascript %}
var values = { a: 1 };
var b = 1;

function impureFunction ( a ) {
  a = a * b + 2;

  return a;
}

var c = impureFunction( values.a );
// Actually, the value of `c` will depend on the value of `b`.
// In a bigger codebase, you may forget about that, which may
// surprise you because the result can vary implicitly.
{% endhighlight %}

Here, `b` is not in the scope of the function. The result will depend on the context: surprises expected!

{% highlight javascript %}
var values = { a: 1 };
var b = 1;

function pureFunction ( a, c ) {
  a = a * c + 2;

  return a;
}

var c = pureFunction( values.a, b );
// Here it's made clear that the value of `c` will depend on
// the value of `b`. No sneaky surprise behind your back.
{% endhighlight %}

## What does it look like, concretely?

Considering this code exists:

{% highlight javascript %}
var getMinQuantity = function getMinQuantity ( name ) {
  // A pure fonction which returns a number, regarding
  // the given name.
};
{% endhighlight %}

Let's take the following code example that may exist in a lambda project:

{% highlight javascript %}
var popover = {

  // A bunch of code…

  addQuantityText: function ( quantity ) {
    var quantityTextOptions = {
      namespace: "quantity",
      initialChildIndex: 2,
      quantity: quantity
    };

    try {
      this.formatQuantityText( quantityTextOptions );
    } catch ( err ) {
      console.log( "Couldn't add quantity text!" );
    }
  },

  formatQuantityText: function ( options ) {
    if ( !this.$$boxContainer ) {
      throw new Error( "$$boxContainer is not configured" );
    }

    var namespace = options.namespace || "quantity";
    var quantity = options.quantity || 0;
    var initialChildIndex = options.initialChildIndex || 0;

    var $$quantity = new Canvas(); // implementation details hidden
    $$quantity.name = namespace;
    $$quantity.value = quantity;
    this.setQuantityTextColor( $$quantity );

    this.$$boxContainer.addChild( $$quantity, initialChildIndex );

    return $$quantity;
  },

  setQuantityTextColor: function ( $$quantity ) {
    if ( !$$quantity ) return;

    var minQuantity = getMinQuantity( $$quantity.name );
    var quantity = $$quantity.value || minQuantity;
    var hasEnoughQuantity = (quantity >= minQuantity);

    $$quantity.color = (hasEnoughQuantity) ? "green" : "red";
  },

  // A bunch of code…

};
{% endhighlight %}

We've got `addQuantityText()`, `formatQuantityText()` and `setQuantityTextColor()` which are all impure.

In our context, `addQuantityText()` is the method actually used when you want to "display the quantity" in our `$$boxContainer`. This is the entry point, dealing with implementation details. You'll look at this method when something goes wrong with `$$quantity`. Which is likely to be the start of a treasure hunt — but not a funny one.

The way it was written could be error-prone on the long term.

### When it gets complicated

In this example, the execution order of functions is critical.

**Just swap 2 lines and you'll break everything**. It may sound obvious, but it's much more difficult to debug:

{% highlight javascript %}
var popover = {

  // A bunch of code…

  addQuantityText: function ( quantity ) {
    var quantityTextOptions = {
      namespace: "quantity",
      initialChildIndex: 2,
      quantity: quantity
    };

    try {
      this.formatQuantityText( quantityTextOptions );
    } catch ( err ) {
      console.log( "Couldn't add quantity text!" );
    }
  },

  formatQuantityText: function ( options ) {
    if ( !this.$$boxContainer ) {
      throw new Error( "$$boxContainer is not configured" );
    }

    var namespace = options.namespace || "quantity";
    var quantity = options.quantity || 0;
    var initialChildIndex = options.initialChildIndex || 0;

    var $$quantity = new Canvas(); // implementation details hidden
    this.setQuantityTextColor( $$quantity );
    $$quantity.name = namespace;
    $$quantity.value = quantity;

    return $$quantity;
  },

  setQuantityTextColor: function ( $$quantity ) {
    if ( !$$quantity ) return;

    var minQuantity = getMinQuantity( $$quantity.name );
    var quantity = $$quantity.value || minQuantity;
    var hasEnoughQuantity = (quantity >= minQuantity);

    $$quantity.color = (hasEnoughQuantity) ? "green" : "red";
  },

  // A bunch of code…

};
{% endhighlight %}

Now there is an error in the code. Problem is: that's hard stuff to detect!

Here, `setQuantityTextColor()` is responsible of the color of `$$quantity`. And so you need to navigate through methods to catch the one which is the last which modifies the object, then reconstitute the whole flow to understand what's going wrong.

At this point you could even regret having decomposed `formatQuantityText()` into smaller methods to simplify implementation details.

Generally speaking, that's a lot of code that needs to be considered when you are debugging. And if you get thinking that splitting a big method into smaller ones just make the debug difficult, then the concept of **pure function** is gaining interest.

### Let's do that with pure functions

We'll use a maximum of pure functions to rewrite our code:

{% highlight javascript %}
var popover = {

  // A bunch of code…

  // All the modifications of system state are grouped here.
  // This only method is responsible for the insertion of
  // an element, which makes debug simpler and limit
  // side effects.
  addQuantityText: function ( quantity ) {
    if ( !this.$$boxContainer ) {
      throw new Error( "$$boxContainer is not configured" );
    }

    var quantityTextOptions = {
      namespace: "quantity",
      quantity: quantity
    };
    var $$quantity = this.formatQuantityText( quantityTextOptions );

    this.$$boxContainer.addChild( $$quantity, 2 );
  },

  // This method doesn't have side effects.
  // It just call other pure functions. It creates and return the
  // canvas object desired, correctly configured!
  formatQuantityText: function ( options ) {
    var namespace = options.namespace || "quantity";
    var quantity = options.quantity || 0;

    var $$quantity = new Canvas(); // implementation details hidden
    $$quantity.name = namespace;
    $$quantity.value = quantity;
    $$quantity.color = this.getQuantityTextColor( quantity, namespace );

    return $$quantity;
  },

  // This method doesn't have side effects neither.
  // It returns the correct color, regarding the given quantity.
  getQuantityTextColor: function ( quantity, namespace ) {
    var minQuantity = getMinQuantity( namespace );
    var hasEnoughQuantity = (quantity && quantity >= minQuantity);

    return (hasEnoughQuantity) ? "green" : "red";
  },

  // A bunch of code…

};
{% endhighlight %}

There is no fundamental change in this new version. However, there are non-negligible benefits.

What we did here:

- `getQuantityTextColor()` instead of `setQuantityTextColor()`
- the method returns a color regarding the quantity we give to it instead of modifying the object directly, as we did before
- methods don't consider variables out of their scope
- methods only call pure methods
- we isolated the creation / modification of the `$$quantity` object in `formatQuantityText()`
- we isolated modifications of the system state in `addQuantityText()`

Doing so, we removed methods with side effects. We just **simplified the code maintenance**. If there is an issue with `$$quantity` to occur, there is only one method to look for.

### Simplify the interface

We used here public methods. It'd be perfectly acceptable — completely relevant — to make them private.

Indeed, there don't have much to do with our API since **their role is to simplify the interface**. Have a look to my post on [private methods with Backbone.js]({% post_url 2014-12-07-private-methods-backbonejs %}) if you get scratching your head with that.

As they are pures, to extract them is dead easy since they don't rely on a specific context, just parameters!

{% highlight javascript %}
function getQuantityTextColor ( quantity, namespace ) {
  var minQuantity = getMinQuantity( namespace );
  var hasEnoughQuantity = (quantity && quantity >= minQuantity);

  return (hasEnoughQuantity) ? "green" : "red";
};

function formatQuantityText ( options ) {
  var namespace = options.namespace || "quantity";
  var quantity = options.quantity || 0;

  var $$quantity = new Canvas(); // implementation details hidden
  $$quantity.name = namespace;
  $$quantity.value = quantity;
  $$quantity.color = getQuantityTextColor( quantity, namespace );

  return $$quantity;
};
{% endhighlight %}

And then, later in the code:

{% highlight javascript %}
var popover = {

  // A bunch of code…

  addQuantityText: function ( quantity ) {
    if ( !this.$$boxContainer ) {
      throw new Error( "$$boxContainer is not configured" );
    }

    var quantityTextOptions = {
      namespace: "quantity",
      quantity: quantity
    };
    var $$quantity = formatQuantityText( quantityTextOptions );

    this.$$boxContainer.addChild( $$quantity, 2 );
  },

  // A bunch of code…

};
{% endhighlight %}

## Advantages of pure functions

The main advantage of a pure function is that **it doesn't have any side effect**. It doesn't modify the state of the system outside of their scope. Then, they just simplify and clarify the code: when you call a pure function, you just need to focus on the return value as you know you didn't broke anything elsewhere doing so.

A pure function is also robust. **Its order of execution doesn't have any impact on the system**. Operations with pure functions could be parallelized.

Also, **it's very easy to unit test a pure function** since there is no context to consider. Just focus on inputs / outputs.

Finally, maximizing the use of pure functions **makes your code simpler, more flexible**.

## A matter of design

In practice, when you are doing object-oriented code you may think that functional programming concepts couldn't fit in. This is simply wrong as [OOP and FP are absolutely compatibles](http://blog.cleancoder.com/uncle-bob/2014/11/24/FPvsOO.html)!

Indeed, the idea here is simple: **simplify your code by limiting the number of functions that has an impact on the system**.

If you force yourself to think twice to maximize the number of pure functions in your code, you'll probably make your maintenance / life / debug easier!

Well, you've got the idea. Which is often, in practice, a matter of design, the choice between a `get` and a `set` for instance.

## Further Reading

- [Introduction To Functions](https://www.kompulsa.com/javascript-basics-introduction-to-functions/)
