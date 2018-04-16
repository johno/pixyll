---
layout: post
robots: index,follow
published: true
comments: true

tags: [javascript, backbone, marionette, behaviors, tests]

title: Testing Marionette.js Behaviors
description: How to unit test your Marionette.js Behaviors with ease.
---

## Context

This is a talk I gave on November 10th, 2015 at [meetup Backbone.js Paris S02E01](http://www.meetup.com/fr/backbone-paris/events/226050848/).

## Video (FR)

<iframe width="560" height="315" src="https://www.youtube.com/embed/0VHW_7PyjBw?rel=0&t=28m20s" frameborder="0" allowfullscreen></iframe>

## Slides

<iframe src="https://slides.com/nicoespeon/testing-marionette-behaviors/embed" width="576" height="420" scrolling="no" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>

## Concretly

### Problems

When you want to test your Behavior, the first problem that generally comes up is:

> Damn, how to I instantiate my Behavior so I can test its API?

In fact, *the Behavior API* are not that much public methods you declared inside. These never are directly called:

{% highlight javascript %}
const Alert = Marionette.Behavior.extend( {

  defaults: {
    title: "Alert!",
    message: "Not really urgent"
  },

  events: {
    "click": "emitAlert"
  },

  emitAlert() {
    alert( this.options.message );
  }

} );
{% endhighlight %}

{% highlight javascript %}
it( "should emit an alert", () => {

  // => This won't work
  expect( Behavior.emitAlert() ).toEmitAnAlert();

} );
{% endhighlight %}

A Behavior [reacts to events](http://slides.com/stephanebachelier/marionettebehaviors#/10) — DOM interactions, trigger from the view, etc. 

If you want to test a Behavior you then have to **trigger these events** then **observe the Behavior's impacts on the system** to check if it reacted appropriately. Behaviors work with side effects, this is what you need to test.

A Behavior is declared and instantiated within the context of a view:

{% highlight javascript %}
const ShareView = Marionette.ItemView.extend( {

  template: "#card",
  
  behaviors: {
    AlertOnShare: {
      behaviorClass: AlertBehavior,
      title: "Shared",
      message: "Your message has been shared!"
    }
  }

} );
{% endhighlight %}

To test a Behavior, you then need to **instantiate a view** in which the Behavior is declared.

> OK! Then I'll mock a view with my Behavior declared so I can test it.
 
{% highlight javascript %}
describe( "Alert Behavior", () => {

  let view;
  
  beforeEach( () => {
  
    view = Marionette.ItemView.extend( {
      template: _.template( "" ),
      
      behaviors: {
        Alert: {
          behaviorClass: AlertBehavior,
          title: "Title",
          message: "My message."
        }
      }
    } );
  
  } );
  
  // …

} );
{% endhighlight %}

This is an option.

However, you won't have the Behavior actually behave within the **context** of your application's views. This is not necessarily wrong since we're talking about unit tests here. But that requires a lot of ceremony to mock whatever should be:
 
- mock a view with default parameters
- mock a view with configured parameters
- mock whatever should be tested — template, events, triggers…

Another solution would be to **test the instantiated Behavior within each view of our applicaation**, directly in these views tests actually.

> OK! So I'll test the Behavior within each of my views… But well… what about duplication?!

Yep, if you go testing how your Behaviors behave for every view's context, you will duplicate tests. That would be a pitty for something which is supposed to isolate views behaviors so you don't duplicate code.

### What can we do then?

<i class="icon-github"></i> <a href="https://github.com/nicoespeon/testing-marionette-behaviors">GitHub repo to illustrate the proposed solution</a>

The idea is to refactor Behavior's tests into a function that will take `context` as a param.

{% highlight javascript %}
function addOnClickTests ( context ) {

  let model, view;

  beforeEach( () => {
    model = new context.ModelClass();
    view = new context.ViewClass( { model: model } );
  } );

  it( "should increase the model size by 1 when we click on the view", () => {
    model.set( "size", 1 );

    view.$el.trigger( "click" );

    expect( model.get( "size" ) ).toBe( 2 );
  } );

}
{% endhighlight %}

This *factory* embeds tests of your Behavior and run them within a specific context.

This allows you to instantiate tests with the context of your view, providing correct parameters:

{% highlight javascript %}
describe( "Like View", () => {

  const View = LikeView.extend( { template: _.template( "" ) } );

  describe( "AddOnClick Behavior", () => {

    addOnClickTests( { ViewClass: View, ModelClass: LikeModel } );

  } );

} );
{% endhighlight %}

> Sure, but what you're doing here is testing default parameters of the Behavior: « increase the model size by 1 ». How to test specific parameters? Should we pass them through the context? If so, that's just duplication again. We'd better completely mock the view at the end.

That's exactly why Marionette is publicly exposing the array of instantiated Behaviors of a view in its `_behaviors` attribute [since v2.2.0](https://github.com/marionettejs/backbone.marionette/blob/2f3fcebc26aa6f0b1310ed077278c17f3b22aac0/src/marionette.view.js#L17).

The trick is to be able to retrieve your Behavior instance in the view context so you can adapt tests regarding parameters that it actually uses.

I specify an `id` to my Behaviors for that, so I can retrieve them easily:

{% highlight javascript %}
const OnClick = Marionette.Behavior.extend( {

  id: "addOnClick",

  defaults: {
    propertyToIncrease: "size",
    increaseStep: 1
  },

  events: {
    "click": "add"
  },

  add() {
    // increase `propertyToIncrease` by `increaseStep`
  }

} );
{% endhighlight %}

{% highlight javascript %}
function addOnClickTests ( context ) {

  let model, view, behavior, options;

  beforeEach( () => {
    model = new context.ModelClass();
    view = new context.ViewClass( { model: model } );

    // Retrieve instantiated behavior and its actual options under this context.
    behavior = _.findWhere( view._behaviors, { id: "addOnClick" } );
    options = behavior.options;

    model.set( options.propertyToIncrease, 1 );
  } );

  it( "should be instantiated", () => {
    expect( behavior ).not.toBeUndefined(  );
  } );

  it( "should increase the model value when we click on the view", () => {
    var expectedValue = model.get( options.propertyToIncrease ) + options.increaseStep;

    view.$el.trigger( "click" );

    expect( model.get( options.propertyToIncrease ) ).toBe( expectedValue );
  } );

}
{% endhighlight %}

### To sum it up

- test the API of your Behavior = its impact on the system, reacting to some events
- describe your Behavior tests in a factory that takes a context as a parameter
- embed your tests in each of your views tests, using the according context
- use `this.view._behaviors` to retrieve your Behavior — you can use an `id` for that — and its actual paremeters within the context of the view
