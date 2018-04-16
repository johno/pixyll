---
layout: post
robots: index,follow
published: true
comments: true

tags: [javascript, backbone, marionette, behaviors, tests]

title: Tester ses Behaviors Marionette.js
description: Comment tester unitairement, et simplement, ses Behaviors Marionette.js.
---

## Contexte

Ceci est un talk que j'ai présenté le 10 novembre 2015 au [meetup Backbone.js Paris S02E01](http://www.meetup.com/fr/backbone-paris/events/226050848/).

## Vidéo

<iframe width="560" height="315" src="https://www.youtube.com/embed/0VHW_7PyjBw?rel=0&t=28m20s" frameborder="0" allowfullscreen></iframe>

## Slides

<iframe src="https://slides.com/nicoespeon/tester-behaviors-marionette/embed" width="576" height="420" scrolling="no" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>

## Concrètement

### Les problématiques

Lorsqu'on se dit qu'on va tester notre Behavior, la première problématique que l'on rencontre est généralement la suivante : 

> Mince, comment je fais pour instancier ma Behavior pour pouvoir tester son API ?

En fait, *l'API d'une Behavior* ce ne sont pas particulièrement les méthodes publiques qu'on y déclare. Celles-ci ne seront jamais appellées directement :

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

Une Behavior [réagit à des événements](http://slides.com/stephanebachelier/marionettebehaviors#/10) (interactions DOM, trigger de la vue, etc.). 

Pour tester une Behavior, il faut donc **déclencher ces événements** puis **observer l'impact de la Behavior sur le système** pour voir si celle-ci a réagit correctement. Les Behaviors fonctionnant par effets de bord, c'est bel et bien ce qu'il faut tester.

Une Behavior est déclarée et instanciée dans le contexte d'une vue :

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

Pour tester une Behavior, il faut donc commencer par **instancier une vue** dans laquelle celle-ci est déclarée.

> OK ! Donc je vais mock une vue en y déclarant ma Behavior pour pouvoir la tester.
 
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

C'est une possibilité.

Cependant, je n'ai pas vraiment le comportement de la Behavior dans le **contexte** des vues de mon application. Ce n'est pas nécessairement grave puisque nous parlons de tests unitaires. Simplement, cela demande beaucoup de cérémonie pour mock tout ce qu'il faut :
 
- mock une vue avec les paramètres par défaut
- mock une vue avec des paramètres configurés
- mock tout ce qui doit être testé (template, events, triggers…)

Une autre solution consiste à **tester la Behavior instanciée dans chacunes des vues de notre application**, directement dans les tests de celles-ci en fait.

> OK ! Je vais tester la Behavior dans chacune de mes vues… Mais, mais… Et la duplication ?!

Effectivement, si on commence par tester le comportement de nos Behaviors dans le contexte de chacune de nos vues, on se retrouve à dupliquer les tests. Sachant que le principe de la Behavior c'est d'isoler un ensemble de comportements de vue pour ne pas avoir à le dupliquer, c'est un peu dommage de perdre ça côté tests.

### Comment on s'en sort ?

<i class="icon-github"></i> <a href="https://github.com/nicoespeon/testing-marionette-behaviors">Dépôt GitHub pour illustrer la solution proposée</a>

L'idée consiste à refactor les tests d'une Behavior dans une fonction qui prend un `context` en paramètre.

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

Cette *factory* embarque les tests de la Behavior et les déroule dans un contexte particulier.

Ceci nous permet de l'instancier dans le contexte de notre vue, avec les paramètres qui vont bien :

{% highlight javascript %}
describe( "Like View", () => {

  const View = LikeView.extend( { template: _.template( "" ) } );

  describe( "AddOnClick Behavior", () => {

    addOnClickTests( { ViewClass: View, ModelClass: LikeModel } );

  } );

} );
{% endhighlight %}

> Oui, mais ici tu testes les paramètres par défaut de la Behavior : « increase the model size by 1 ». Comment tester des paramètres en particulier ? On les passe dans le contexte ? Du coup, on fait à nouveau de la duplication, autant mock la vue complètement.

C'est effectivement la raison pour laquelle Marionette expose publiquement un tableau des Behaviors instanciées d'une vue dans son attribut `_behaviors` [depuis la v2.2.0](https://github.com/marionettejs/backbone.marionette/blob/2f3fcebc26aa6f0b1310ed077278c17f3b22aac0/src/marionette.view.js#L17).

L'astuce consiste donc à retrouver l'instance de la Behavior dans le contexte de la vue afin de pouvoir variabiliser les tests en fonction des paramètres avec lesquels la Behavior a été instanciée.

Pour cela, je déclare un `id` à mes Behaviors afin de pouvoir les retrouver facilement :

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

### Pour résumer

- on teste l'API de la Behavior = son impact sur le système en réaction à des événements
- on décrit nos tests de Behavior dans une factory qui prend un contexte en paramètre
- on embarque nos tests dans chacune de nos vues en y passant le bon contexte
- on utilise `this.view._behaviors` pour retrouver la Behavior (avec un `id` par exemple) et ses paramètres d'instanciation dans le contexte de la vue
