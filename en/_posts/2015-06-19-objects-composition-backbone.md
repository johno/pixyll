---
layout: post
robots: index,follow
published: true
comments: true

tags: [javascript, backbone.js, oop]

title: Inheritance, composition and Backbone.js
description: Why objects composition is preferable to inheritance in JavaScript? Most of all, how do you apply this technique with Backbone.js?
---

## "Favor objects composition over inheritance"

When you're doing Object Oriented Programmation (OOP), you create a bunch of objects with their data structure and methods that compose their interface. You decide how to split your objects based on the *Single Responsibility Principle* (SRP): **each object should have one and only one reason to change**.

To make interesting stuff happen, you need to combine those objects.

Roughly, there are 2 types of relationships in an object model: inheritance and composition.

You can do the analogy with a family tree:

- **inheritance** is like a birth: when it happens, this is for life.
- **composition** is like a marriage: it happens during the participating objects' lifetimes, and it can change. Objects can discard partners and get new partners to collaborate with. Please note that objects are surely not monogams.

> Source: [Object Design - Roles, Responsibilities and Collaborations](http://www.amazon.com/Object-Design-Roles-Responsibilities-Collaborations/dp/0201379430)

### "Inheritance" all the things!

The very first thing JavaScript developers do is trying to mimic rules of pseudo-classical inheritance.

They usually quickly come up with a lot of `new` everywhere and inheritance chains awfully long. That generally produce something **very hard to maintain**.

That's true you've got everything you need to do inheritance with classes, interfaces, … in Java.

This is not JavaScript.

### Keep It Simple, Seriously

The base rule in JavaScript is **prototypal inheritance**.

Forget about the technical jargon, just remember you have **objects that can link to other objects** (OLOO).

Thus, it's way simpler to encapsulate methods from a same logic into an object, then simply **return this object**. If you need to, you can also create a function that will return an object — which is what we call a *factory*.

Then you'll take this object, eventually compose it with others, to build the prototype which you'll use to instantiate your class. That simple.

To sum it up: instead of creating huge, poorly built, inheritance chains from constructors, simply create your objects and compose them to create a prototype you will instantiate your class with.

### Concatenative inheritance

Someone notified me that what I'm talking about here is called **multiple inheritance**, not actual **object composition**.

When you do object composition, you make attributes point to instances of other classes.

There is no multiple inheritance in JavaScript. Still, composing different prototypes to produce a totally new one is a very close notion, which can be confusing. Here we are talking about "composing prototypes", but not in the terms of objects composition…

There you'll find a more concrete explanation: [Composition, Inheritance, and Aggregation in JavaScript](http://stackoverflow.com/questions/8696695/composition-inheritance-and-aggregation-in-javascript)

So, let's call that **concatenative inheritance**, [as detailed by Eric Eliott](https://medium.com/javascript-scene/3-different-kinds-of-prototypal-inheritance-es6-edition-32d777fa16c9#.d084tr4c8).

## With a concrete example

### Context

For quite some time I've been working full-time on [Vinoga](https://beta.vinoga.com), a social-farming game about wine, developed in HTML5.

Among few libraries, we use *Backbone.js* to decouple our views from our data with ease.

Let's take a concrete use case: elements on the map.

If we take a few time to think about it, there are actually 2 types of elements:

1. `Props` that are decorations elements — trees, rocks, paths…
1. `Buildings` that are buildings of the game — winery, castle…

There is, among others, one difference we can notice from now: `Buildings` can be constructed — from the build menu —, not `Props` since they already are on the map.

Whatever, all these elements share a common behavior: they are on the map. Hence, `Props` and `Buildings` both inherit from `Objects`, which describes the behavior of an "object" on the map.

But there also are different types of `Buildings`, such as:

- `Markets` that are buildings that will reflect the state of the player's store
- `Productions` buildings, that will transform resources — grape, juice — into another product — juice, bottle.

<div class="illustration">
    <img alt="Inheritance, level 1" title="Inheritance, level 1" src="/assets/img/object-composition-backbone/1-inheritance.png">
    Our initial inheritance chain
</div>

### About constructability

After we discussed with the Game Designer, we realized that `Markets` are not constructable: they already are on the map.

Constructability is a behavior that were part of the `Buildings` one until now. But yep, let's handle that with a little modification of the inheritance chain:

<div class="illustration">
    <img alt="Inheritance, level 2" title="Inheritance, level 2" src="/assets/img/object-composition-backbone/2-longuer-inheritance-chain.png">
    Our updated inheritance chain to adapt
</div>

### Here comes the drama

As time goes, specs evolve and features too: brace yourself, `Decorations` are coming!

`Decorations` are decorations elements — actually, `Props` — except that they are constructables too!

Well, now we're a bit stucked since `ConstructableBuildings` inherits from `Buildings`. We'd like not to duplicate `ConstructableBuildings` to recode roughly the same thing into `Props`.

Looks like we'll end up with classes that inherit of useless properties at the very best.

<div class="illustration">
    <img alt="Inheritance, the problem" title="Inheritance, the problem" src="/assets/img/object-composition-backbone/3-inheritance-issue.png">
    We were'nt very smart on this one, now we're stuck!
</div>

### Why so pseudo-classical?

Well, how did we get there? How to get out of here?

Actually, we were a bit in the hurry when the constructability question appears. Without any more reflexion we came with the logic that "`Productions` IS a `ConstructableBuildings` that IS a `Buildings` that IS an `Objects`". Kaboom, inheritance!

In fact, if we look closer, we could infer that constructability is a **behavior**. You can not say that there is no `Constructable` element without `Building`. This is a subtle error that is so frequent in JavaScript because of pseudo-classical inheritance since this is the only thing you remember: this is the very first — bad — instinct.

In our case, the only legitimate inheritance chain may be the one that bounds `Decorations` to `Props`. Anyway, I still think that you can get rid of it too.

What you actually put into `Objects` is a bunch of behaviors that are shared between `Props` and `Buildings`. But technically, `Objects` doesn't represent anything concrete: this would be an *abstract class* if we were coding in Java. Just like `Buildings` by the way.

### Embrace composition

In JavaScript, may I suggest another way: let's describe each behavior into its own object. Let's get rid of constructors and inheritance chains.

Then, combine these objects to make the prototype of objects we want to build. No *class* around, simply objects that **are composed from** other objects. Eventually *factories* to construct the correct object regarding your needs.

<div class="illustration">
    <img alt="Composition, the solution" title="Composition, the solution" src="/assets/img/object-composition-backbone/4-composition-resolution.png">
    It's way simpler to play Legos!
</div>

<p class="islet">
  Here we just augment our prototype with other objects that describe behaviors. That's what <strong>mixin</strong> is about.<br><br>
  If your object inherits from another, then prefer to use <strong>prototypal inheritance</strong>.
</p>

## What about Backbone?

### Backbone.extend

When you use Backbone, you use `.extend()` to override `Backbone.[Model|Collection|View|…]`. Then you instantiate it with `new`.

Thus, it's very frequent to follow the pseudo-classical inheritance reflex and to end up with:

{% highlight javascript %}
var ObjectsModel = Backbone.Model.extend( … );
var BuildingsModel = ObjectsModel.extend( … );
var MarketsModel = BuildingsModel.extend( … );
{% endhighlight %}

Which, by the way, would be the same than:

{% highlight javascript %}
var MarketsModel = Backbone.Model.extend(…).extend(…).extend(…);

// Then you instantiate when needed
var marketsModel = new MarketsModel();
{% endhighlight %}

Backbone is built like that. `.extend()` easily lead us to that slippery slope where Models depend on the others in many not-that-subtle ways.

### Compose your prototype THEN extend

Even though you need to inherit from Backbone, you can at least limit the damages. Even though `.extend()` exists, you don't have to use it for every single object you create. The only object we really need to `.extend()` here is `Backbone.Model`.

The main idea is to compose objects to make to prototype you will **then** use into the `.extend()` of your Model / Collection / View…

{% highlight javascript %}
var objectsModelProto = { /* … */ };
var buildingsModelProto = { /* … */ };
var constructablesModelProto = { /* … */ };

// We compose to make a new prototype.
var marketsModelProto = _.assign(
  { /* … */ }, // -> specific interface for markets
  objectsModelProto,         //
  buildingsModelProto,       // => our mixins
  constructablesModelProto,  //
  { /* … */ } // -> to override mixins, if needed
);

// Once prototype is created, inherit from Backbone.
var MarketsModel = Backbone.Model.extend( marketsModelProto );

// Then you instantiate.
var marketsModel = new MarketsModel();
{% endhighlight %}

You can see how `objectsModelProto`, `buildingsModelProto` and `constructablesModelProto` override the base prototype of `marketsModelProto` to add specific behaviors.

#### Merge or assign

Please note that might be useful to use `_.merge` instead of `_.assign` if you need to merge attributes deeply. This may be handy with Backbone when you need to merge things like `events`:

{% highlight javascript %}
var objectsViewProto = {
  events: {
    "click .store": "store",
    "click .turn": "turn"
  }

  store: function store () { /* … */ },
  turn: function turn () { /* … */ }
};

_.assign(
  {
    displayModal: function displayModal () { /* … */ },
    select: function select () { /* … */ }
  },
  objectsViewProto,
  {
    events: {
      "click": "select",
      "click .turn": "displayModal"
    }
  }
);
// ->
// {
//   events: {
//     "click": "select",
//     "click .turn": "displayModal"
//   },
//  
//   displayModal: function displayModal () { /* … */ },
//   select: function select () { /* … */ },
//   store: function store () { /* … */ },
//   turn: function turn () { /* … */ }
// }

_.merge(
  {
    displayModal: function displayModal () { /* … */ },
    select: function select () { /* … */ }
  },
  objectsViewProto,
  {
    events: {
      "click": "select",
      "click .turn": "displayModal"
    }
  }
);
// ->
// {
//   events: {
//     "click": "select",
//     "click .store": "store",
//     "click .turn": "displayModal"
//   },
//  
//   displayModal: function displayModal () { /* … */ },
//   select: function select () { /* … */ },
//   store: function store () { /* … */ },
//   turn: function turn () { /* … */ }
// }
{% endhighlight %}

## In conclusion

Favor **objects composition** over **inheritance**. Don't use inheritance if it doesn't really make sense, or is required. Beware overlong inheritance chains: that's damn fragile.

What is preferable to avoid:

{% highlight javascript %}
// markets.model.js
var MarketsModel = ConstructablesModel.extend( { /* … */ } );

// main.js
var marketsModel = new MarketsModel();
{% endhighlight %}

Far more flexible, simpler:

{% highlight javascript %}
// markets.model.js
var marketsModelProto = _.assign(
  { /* … */ }, // -> specific interface of markets
  objectsModelProto,
  buildingsModelProto,  
  constructablesModelProto
);

// main.js
var MarketsModel = Backbone.Model.extend( marketsModelProto );
var marketsModel = new MarketsModel();
{% endhighlight %}

Let's end up this post with few post I recommend you to read if you need to know more about composition and inheritance with JavaScript:

- [Understanding Prototypes, Delegation & Composition](http://www.datchley.name/understanding-prototypes-delegation-composition/) > an explanation from A to Z which is simple, clear and illustrated
- [Common Misconceptions about Inheritance in Javascript](https://medium.com/javascript-scene/common-misconceptions-about-inheritance-in-javascript-d5d9bab29b0a) > detailed FAQ that goes deep on this subject
