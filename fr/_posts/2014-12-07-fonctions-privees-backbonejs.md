---
layout: post
robots: index,follow
published: true
comments: true

tags: [javascript, backbone.js, privacy]

title: Fonctions privées avec Backbone.js
description: Pourquoi et comment faire des fonctions privées. Et concrètement, comment implémenter ça tout en utilisant Backbone.js.
---

## Fonctions privées, c'est-à-dire ?

Pour faire simple et concis : une fonction / méthode privée est une méthode qui n'est pas exposée et ne peut donc pas être appelée "de l'extérieur".

Il s'agit donc d'une notion de **portée**, ni plus ni moins.

{% highlight javascript %}
function yolo() {
  var privateMethod = function() {
    console.log( "can't be accessed outside of `yolo()`" );
  };
  var privateVar = true;

  // ici, on peut appeler `privateMethod` si ça nous chante.
  // ici, `privateVar` vaut `true`.

  return "that's all you've got from me!";
}

// ici, `privateMethod` n'existe pas.
// ici, `privateVar` n'est pas défini.

yolo(); // affiche "that's all you've got from me!"
{% endhighlight %}

Cette notion prend tout son sens lorsqu'on utilise le *module pattern*.

Pour en savoir plus sur ce point, je vous recommande cet article parmi tous les autres : [Mastering the module pattern](http://toddmotto.com/mastering-the-module-pattern), simple et efficace.

Et donc concrètement, ça donne ce genre de code :

{% highlight javascript %}
var MyModule = (function () {
  // tout un tas de trucs encapsulés -> privés si pas exposés.
  var _cantTouchThis = function() {
    console.log( "I just met you!" );
  };

  var _nbOfCats = 3;

  // ce que l'on retourne lorsque la fonction est exécutée
  // -> ce qu'on expose (= public).
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

Ceci nous permet donc de toucher à la partie publique, **l'interface**, sans pour autant avoir accès à la partie privée :

{% highlight javascript %}
MyModule.nbOfRainbows = 42;
MyModule.logNumberOfRainbows(); // affiche "42"
MyModule.logNumberOfCats(); // affiche "3"
MyModule.touchThis(); // affiche "Hey!" "I just met you!"
{% endhighlight %}

## Fonctions privées… Et pour quoi faire ?

Question légitime. Personnellement, je vois l'intérêt d'une fonction privée ainsi :

- elle **simplifie l'interface publique** en s'occupant des détails techniques d'implémentation
- elle **n'a pas à être testée unitairement**

Le premier point coule généralement de source. Le second point découle du premier, mais rend souvent perplexe. Je m'explique…

## Tests unitaires et fonctions privées

Pour tester notre module, on l'instancie, puis on va prendre chacune de ses méthodes et vérifier leur sortie à partir d'une entrée (variables + contexte). On teste *unitairement* les méthodes exposées en prenant garde de faire varier l'entrée pour tester tous les cas de figure et obtenir une bonne couverture de tests.

On peut d'ailleurs résumer la pratique du **Test Driven Development** (TDD) :

- écrire d'abord le test avec les cas de figures requis pour une fonctionnalité
- coder la méthode afin de passer ces tests
- retravailler le code à la fin pour le nettoyer. Tant que les tests passent on sait qu'on n'a rien cassé.

L'étape de *refactor* vient en dernier car l'objectif est de produire un code qui fonctionne, puis de faire des optimisations.

Pour revenir à la question des méthodes privées : elles ne sont pas exposées, donc *techniquement* elles ne sont pas testées unitairement. Pas directement en fait.

## Quelques considérations sur les fonctions privées

Le point sur les tests unitaires peut laisser perplexe selon la manière dont on considère et utilise la notion de fonction privée. Je dirais qu'il y a 2 façons de voir les choses :

1. je code tout en privé et j'expose que ce qui doit l'être *in fine*
1. les fonctions privées sont le fruit du refactor de mes fonctions publiques

### Comment choisir entre privé et public ?

Si on considère que l'on fait du TDD… on développe l'interface publique **avant** (puisque c'est ce que testent les tests).

Personnellement, je code mes tests (qui ne passent pas), puis mon interface publique : les méthodes publiques ou les *event handlers* (petit point là-dessus plus bas, pour ceux qui s'interrogent). Rien de privé chez moi à ce stade.

Les fonctions privées proviennent de l'étape de refactor, finalement. Et puis si je n'ai pas le temps de nettoyer, au moins ça marche.

Finalement, **les tests unitaires testent l'interface publique**.

Les méthodes privées sont testées à travers les méthodes publiques. On peut se dire que tester le détail de l'implémentation technique serait judicieux pour mieux debugguer, mais c'est un coût d'implémentation et de maintenance conséquent. À l'inverse, je peux ici modifier / refactor mes méthodes privées autant que je veux tant que mon module fonctionne.

À choisir : autant tester plus de scénarios sur l'interface publique. La coverage indiquera si oui ou non on teste les méthodes privées en passant.

### Le cas des events handlers

L'interface publique, c'est donc ce qui compte.

Qu'en est-il des événements qui font réagir notre module ? Les events handlers (= `onClick()` & co) doivent-elles être publiques pour pouvoir être testées ?

En fait, non.

On parle d'événements. Notre module écoute des événements et réagit en fonction. Les tests doivent donc déclencher le comportement en émettant les événements, puis en observant le résultat attendu (impact sur le système, etc.). La méthode liée peut bien être publique ou privée, ce n'est pas ce qui compte au moment où l'on teste la manière dont le module répond à l'événement.

### Préfixer avec "_"

Par convention (assez répandue), on préfixe les noms des méthodes / variables privées avec un `_`.

C'est également ce que je fais pour 2 raisons :

1. c'est une convention qui présente l'avantage de se démarquer. On n'a pas de `private` en JS, mais la plupart comprendront qu'on parle là d'une fonction "supposée" privée…
1. cela facilite le travail de documentation automatique. Souvent, par convention, l'autocompletion considérera cette fonction comme privée et n'oubliera pas de mettre `@private`. Ça vaut ce que ça vaut, en tout cas ça ne coûte rien \o/

C'est donc personnellement une considération de **clarté**. La nature *privée* de la méthode `_joke()` saute plus facilement aux yeux.

En revanche, il est assez commun que cette convention soit utilisée pour tenter de **définir** la nature privée d'une méthode au lieu de la mettre en valeur. C'est-à-dire que l'interface publique exposée est composée de méthodes dont certaines sont préfixées avec `_` pour indiquer que celles-ci doivent être *considérées comme privées*.

<p class="islet">
  C'est un point qui génère de nombreux débats. D'après mon expérience personnelle, c'est généralement quelque chose qui est mis en place quand on ne sait pas trop comment on fait pour véritablement mettre en place des méthodes privées. Du coup tout est public, mais on indique que certaines sont <em>privées par intention</em>.
</p>

En pratique, il est assez simple de mettre en place des méthodes privées avec le *module pattern*. Tant qu'à faire, je conseille donc de partir du principe que tout ce qui est exposé est public. Si on souhaite qu'une fonction soit privée, alors autant l'écrire comme telle et utiliser le préfixe `_` simplement pour la lisibilité du code.

Cela étant, à chaque projet de définir et suivre ses conventions selon ses besoins.


### C'est pas dans le prototype… du coup pour l'héritage et la performance ?

Effectivement, étant donné qu'elle n'est pas accessible, **une méthode privée ne peut pas être surchargée**. C'est la raison pour laquelle je considère les méthodes privées comme un moyen de simplifier l'interface exposée de mon module. Si j'ai besoin du détail de l'implémentation, que je dois pouvoir y accéder en héritant ma classe, alors j'ai besoin que ce détail soit public.

Là encore, le scepticisme n'est pas tellement causé la nature des méthodes privées en soi, mais plutôt à une interprétation / implémentation maladroite de celles-ci.

On notera également le point sur la performance : il y aura autant de fonctions privées que d'instances de mon module, ce qui est techniquement *moins performant*. Mais en [analysant effectivement l'impact](http://jsperf.com/public-vs-private-methods), cette remarque relève de l'ordre de l'optimisation précoce dans mon utilisation des méthodes privées, pour le moment.

### Et comment j'accède à mes méthodes publiques depuis mes méthodes privées ?

Ceci peut être un point de blocage.

En fait, si ma fonction privée provient d'un refactor de ma méthode publique, ce n'en est plus un. Tout simplement parce-que ma méthode privée a pour rôle de simplifier l'interface publique, c'est-à-dire de **rendre plus lisible** ma méthode publique.

J'envisage donc la méthode privée comme un "helper" personnel du module, dont il se sert pour faire son travail. Toutes les variables dont la méthode a besoin lui son donc passées en paramètre.

Ainsi, on peut simplement envisager de passer le contexte de l'interface publique à la méthode privée :

{% highlight javascript %}
var MyModule = (function () {
  var _addSomeCats = function( context ) {
    context.cats++;
    context.logNumberOfCats();
  };

  return {
    cats: 1,
    addSomeCats: function() {
      // En soi cela n'a pas grand intérêt ici de tout envoyer
      // dans une méthode privée, mais c'est pour illustrer la
      // manière dont on passe le contexte.
      _addSomeCats( this );
    },
    logNumberOfCats: function() {
      console.log( this.cats );
    }
  };
})();
{% endhighlight %}

Ce qui donnera :

{% highlight javascript %}
MyModule.addSomeCats(); // affiche "2"
{% endhighlight %}

<p class="islet">
  Dans cet exemple, le contexte est passé en paramètre.<br>
  En pratique, il est possible d'utiliser <code>this</code> dans la méthode <code>_addSomeCats</code> et de l'appeller en lui passant le contexte avec <code>.call()</code> ainsi : <code>_addSomeCats.call( this );</code>.
</p>

L'exemple précédent ne présente pas un grand intérêt, mais concrètement cela peut se présenter de la manière suivante dans un projet :

{% highlight javascript %}
var MyModule = (function () {
  // syntaxe alternative de `var _createViewInstance = function() { … }`.
  // on a refactor ici quelques tâches répétitives du module.
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
        app.err( err ); // -> notre façon de log les erreurs qui peuvent subvenir
        this.ordersView = {};
      }

      // un tas d'autres trucs…
    }

    // …
  };
})();
{% endhighlight %}

Ce qui nous amène effectivement à **Backbone.js**.

## Implémentation avec Backbone.js

C'est le point qui fut pour moi la cause de cet article. En effet, après avoir assimilé le concept et bien visualisé sa mise en place avec un module, on peut rester perplexe sur la manière de l'implémenter quand on à l'habitude de ceci :

{% highlight javascript %}
var MyModule = (function() {

  var Books = {};

  Books.Model = Backbone.Model.extend({

    // un peu de configuration…

    isPrivate: function() {
      console.log( "certainly not…" );
      return false;
    },

    _intendedToBePrivate: function() {
      // le genre de méthode qui apparaît dans ce genre de situation.
    }

  });

  // …

  return Books;

})();
{% endhighlight %}


Finalement, le principe est simple : `.extend()` prend un objet en paramètre. Qu'à cela ne tienne, on peut lui envoyer une [IIFE](http://nicoespeon.com/fr/2013/05/bien-isoler-ses-variables-en-javascript/) qui lui retourne un objet (son API).

{% highlight javascript %}
var MyModule = (function() {

  var Books = {};

  var ModelConfiguration = (function() {
    var _actuallyPrivate = function() {
      console.log( "look 'ma, I'm private!" );
    };

    // on expose la configuration.
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

## Pour conclure

La question des fonctions privées et de leur intérêt fait toujours débat et peut laisser sceptique. Parfois (souvent ?), ça complique plus le schmilblick qu'autre chose. Aussi, chaque projet doit trouver midi à sa porte et adopter la position qui lui convient.

En ce qui me concerne, **je crée des méthodes privées lors de mes opérations de refactor**. Si la méthode est publique par nature, je la traite comme telle : pas de préfixe `_`, des tests unitaires. Le plus important pour moi, c'est de ne pas me leurrer avec une convention.

Quoiqu'il en soit, je me suis questionné un bon moment pour comprendre comment cela pouvait se traduire en utilisant *Backbone.js*. Et comme j'ai eu du mal à faire le déclic, je me suis fendu de cet article pour aider les prochains qui entreront dans les mêmes réflexions que j'ai pu avoir.

Cela étant, c'est un point à débats et à réflexions. N'hésitez donc pas, je suis preneur de suggestions et remarques à ce sujet !
