---
layout: post
robots: index,follow
published: true
comments: true

tags: [javascript, oop, switch]

title: OOP - switch revisited in JavaScript
description: With JavaScript you get a more object-oriented, less procedural and error-prone alternative to the good 'ol <code>switch … case</code>.
---

Suppose following methods for the rest of the post:

{% highlight javascript %}
function sayHello () {
  console.log( "Hello, how are you?" );
}

function giveSomeNews () {
  console.log( "Roses are red. Did you know that?" );
}

function sayBye () {
  console.log( "Ok bye!" );
}
{% endhighlight %}

## Few reminders about `switch`

`if / else` allow us to add some branching logic in our code: regarding a condition we'll do this or that operation. But there are sometimes more than 2 possibles branches.

As a beginner developer, you might be starting using `else if`:

{% highlight javascript %}
if( name === "patrick" ) {
  sayHello();
} else if( name === "jane" ) {
  giveSomeNews();
} else {
  sayBye(); // don't talk to strangers!
}
{% endhighlight %}

Well, that's a bit verbose, difficult to read and not that pretty. Here comes `switch`:

{% highlight javascript %}
switch( name ) {
case "patrick":
  sayHello();
  break;

case "jane":
  giveSomeNews();
  break;

default:
  sayBye(); // don't talk to strangers!
  break;
}
{% endhighlight %}

`switch` is the classical alternative to a long chain of `else if`.

<p class="islet">
  Excepted for very short operations — few lines with clear intent — I prefer to encapsulate them in <strong>explicitly named</strong> functions to decompose the logic from the implementation details. The logic lies in the <code>switch</code>. I use the same technique for <code>if / else</code>.
</p>

Syntax is clearer, but you're introducing few subtleties.

Most of all, you should be aware of the `break` concept here: it allows you to get out of the `switch` and prevent falling through the next `case`.

### Remember errors to avoid!

When you deal with a `switch`, you're not likely to expect falling through 2 different cases.

Just like `else if`, you probably expect to execute one and only one case. That's why you must take care **not to forget the `break`**!

Have a look at this code, is it intentional? Is it a mistake? Whatever, that's a source of bugs and confusion!

{% highlight javascript %}
switch( name ) {
case "patrick":
  sayHello();
  break;

case "jane":
  giveSomeNews();

default:
  sayBye(); // don't talk to strangers!
  break;
}
{% endhighlight %}

There might exists a use case however, where the intent is clear and which is acceptable — and used.

That's when you want to regroup multiple inputs into the same `case`:

{% highlight javascript %}
switch( name ) {
case "patrick":
  sayHello();
  break;

case "jane":
case "john":
  giveSomeNews();
  break;

default:
  sayBye(); // don't talk to strangers!
  break;
}
{% endhighlight %}

To keep it short: to omit a `break` for each `case` is error-prone because you're introducing obscure subtleties in your code. And your code is likely to get future developers into troubles.

That's why the wise advice is: avoid doing that, do remember the `break`.

## An object-oriented alternative: method lookup

Let's go back to our example with a less procedural spirit. Let's get object-oriented:

{% highlight javascript %}
var greetings = {
  "patrick": sayHello,
  "john": giveSomeNews,
  "jane": giveSomeNews
};

(typeof greetings[ name ] === "function")
  ? greetings[ name ]()
  : sayBye();
{% endhighlight %}

You can call that the **method lookup**, which reflect the idea behind the [Command Pattern](http://addyosmani.com/resources/essentialjsdesignpatterns/book/#commandpatternjavascript).

We use the natural object syntax of JavaScript and the power of its first-class functions. No `break` to deal with. We already get all the advantages of the object, as the capability to extend it with ease, allowing context-relative options.

The method lookup is much more relevant than the switch if you're in one of the following cases:

- will you need to add more cases later? *Dealing with plugins for instance.*
- is it useful to change cases during run-time? *Like changing options regarding the context.*
- is it useful to log executed cases? *To set up an undo / redo stack, a log system, etc.*
- are you using incremental numbers to list your cases iteratively? *If you use `case 1:`, `case 2:`, etc.*
- are you trying to fall through different cases by intentionally omitting some `break`? *Fall through = danger, method lookup is a much better alternative.*

## Few remarks on an "advanced" version of `switch`

Using `switch`, you can directly test a condition in your `case`.

Doing so, and considering this code exist:

{% highlight javascript %}
function isPatrick ( name ) {
  return (name === "patrick");
}

function isJane ( name ) {
  return /^jane-/.test( name );
}
{% endhighlight %}

Then, the following code will perfectly work:

{% highlight javascript %}
switch( true ) {
case isPatrick( name ):
  sayHello();
  break;

case isJane( name ):
  giveSomeNews();
  break;

default:
  sayBye(); // don't talk to strangers!
  break;
}
{% endhighlight %}

<p class="islet">
  Again, for more readability I exported conditions into functions that make the intent clear and produce a better code.<br><br>
  You'll agree that the logic is now a bit more complex. In such a context, it might be relevant to polish your work <strong>to make your code clear</strong>.
</p>

This works and could be very useful. Plus, it doesn't have any equivalent with the method lookup as far as I know.

However, **beware overlogic abuse in your code**. The fact you can do it doesn't imply that you should. Keep a critical mind over what you're doing: is it really necessary or is there another simpler way? Can I work on a clearer design to express the logic intent?

Sometimes you might go crazy into "sexy" stuff, but nothing values most than **KISS**!

## Release the (object-oriented) Kraken!

The *method lookup / command pattern* is a `switch` equivalent, with an object-oriented spirit. **It tends to encourage you to write a flexible, well-organized, object-oriented code** — which is good.

`switch … case` is not a bad thing in itself. But it can be lead to *spaghetti code* and be error-prone. Because its procedural, you may end up with a complex branching logic which finally traduce a bad code design which is difficult to maintain.

Finally, there is no reason to actually use `switch` instead of its alternative if you want to benefit what JavaScript has to offer. But must of all, the most important is you to write a code the future-you and others won't hate!
