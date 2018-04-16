---
layout: post
robots: index,follow
published: true
comments: true

tags: [javascript, backbone.js, oop]

title: Héritage, composition et Backbone.js
description: Pourquoi la composition d'objets est préférable à l'héritage en JavaScript ? Et surtout, comment applique-t-on cette idée avec Backbone ?
---

## "Favor objects composition over inheritance"

Dans la Programmation Orientée Objet (POO), on crée un certain nombre d'objets avec leur structure de données et les méthodes qui composent leur interface. Pour décider de comment découper nos objets, on suit le *Single Responsibility Principle* (SRP) : **chaque objet doit avoir une seule et unique raison de changer**.

Pour faire des choses intéressantes, il faut combiner ces objets.

Or, en gros, il existe 2 types de relations dans le modèle objets : l'héritage et la composition.

On peut faire l'analogie avec un arbre généalogique :

- **l'héritage**, c'est comme une naissance : quand ça arrive, c'est pour la vie.
- **la composition** c'est comme un mariage : ça arrive au cours de l'existence des objets et ça peut changer. Les objets peuvent se séparer et trouver de nouveaux partenaires avec qui s'associer. On notera néanmoins que les objets ne sont pas monogames.

> Source: [Object Design - Roles, Responsibilities and Collaborations](http://www.amazon.com/Object-Design-Roles-Responsibilities-Collaborations/dp/0201379430)

### "Heritage" all the things!

Le premier réflexe des développeurs JavaScript consiste souvent à tenter de reproduire les règles d'héritage pseudo-classique.

On se retrouve alors vite avec des `new` un peu partout et des chaînes d'héritage longues comme le bras. Ça produit souvent quelque chose **très difficile à maintenir**.

Il est vrai qu'en Java on dispose de tout ce qu’il faut pour faire de l’héritage avec des classes, des interfaces, etc.

Ce n’est pas le cas en JavaScript.

### Keep It Simple, Seriously

En JavaScript, la base, c'est **l'héritage de prototype**.

Si on oublie le jargon technique, disons qu'on a tout simplement **des objets qui peuvent se lier à d'autres objets** (OLOO).

Du coup, il est vachement plus simple d'encapsuler les méthodes d'une même logique dans un objet, puis de simplement **retourner cet objet**. Au besoin, on peut aussi créer une fonction qui va retourner un objet (ce qu'on appelle une *factory*).

Cet objet on va le prendre, éventuellement le composer avec d'autres, pour former le prototype avec lequel on va instancier notre classe. Tout simplement.

Pour résumer : plutôt que de créer des chaînes d'héritage plus ou moins bancales à grands coups de constructeurs, créez simplement vos objets et composez les pour former un prototype avec lequel vous allez instancier votre classe.

### Concatenative inheritance

Quelqu'un m'a fait très justement remarqué que ce dont je vous parle ici s'appelle **l'héritage multiple**, plutôt que d'**object composition** au sens propre du terme.

Object composition fait référence au fait de faire pointer les attributs de notre objet vers des instances d'autres classes.

Il n'y a pas d'héritage multiple à proprement parler en JavaScript. Mais le fait de composer différents prototypes pour en former un nouveau est la notion qui s'en rapproche, ce qui peut générer de la confusion. On parle de "composer des prototypes", ce qui est le cas, mais pas dans le sens de la composition d'objets…

Voici pour une explication plus concrète : [Composition, Inheritance, and Aggregation in JavaScript](http://stackoverflow.com/questions/8696695/composition-inheritance-and-aggregation-in-javascript)

Du coup, nous appellerons ça la **concatenative inheritance**, [à la manière d'Eric Eliott](https://medium.com/javascript-scene/3-different-kinds-of-prototypal-inheritance-es6-edition-32d777fa16c9#.d084tr4c8).

## Sur un exemple concret

### Contexte

Depuis quelques temps déjà, je travaille à temps plein sur [Vinoga](https://beta.vinoga.com), un jeu de social farming sur le vin, développé en HTML5.

Entre autres bibliothèques, nous utilisons *Backbone.js* pour découpler simplement nos vues de nos données.

Prenons donc un cas concret : les éléments sur la carte.

En posant les choses, on se rend vite compte qu'il y a 2 types d'éléments :

1. les `Props` qui sont les éléments de décor (arbres, rochers, chemins…)
1. les `Buildings` qui sont les bâtiments du jeu (cuverie, château…)

Une différence parmi d'autres, mais notable à ce stade : les `Buildings` sont constructibles (depuis le menu de construction), les `Props` ne le sont pas (ils sont déjà sur la carte).

Quoiqu'il en soit, tous les éléments partagent un comportement commun : ils sont sur la carte. Du coup, `Props` et `Buildings` dérivent tous deux de `Objects`, qui décrit le comportement d'un "objet" sur la carte.

Mais il y a aussi différents types de `Buildings`, notamment :

- les `Markets` qui sont les bâtiments qui vont refléter l'état de la boutique du joueur
- les `Productions` qui sont les bâtiments qui vont permettre de transformer une ressource (raisin, jus) en produit (jus, bouteille)

<div class="illustration">
    <img alt="Héritage, niveau 1" title="Héritage, niveau 1" src="/assets/img/object-composition-backbone/1-inheritance.png">
    Notre chaîne d'héritage initiale
</div>

### À propos de la constructibilité

Après avoir discuté avec le Game Designer, on se rend finalement compte que les `Markets` ne sont pas constructibles : il sont déjà sur la carte de base.

La constructibilité est un comportement qui faisait partie intégrante de `Buildings` à ce stade. Mais soit, on peut se dire qu'on va s'en sortir facilement en changeant la chaîne d'héritage ainsi :

<div class="illustration">
    <img alt="Héritage, niveau 2" title="Héritage, niveau 2" src="/assets/img/object-composition-backbone/2-longuer-inheritance-chain.png">
    Notre chaîne d'héritage modifiée pour s'adapter
</div>

### Et là, c'est le drame

Puis le temps passe, les specs évoluent et les features avec : brace yourself, `Decorations` are coming!

Les `Decorations`, ce sont des éléments de décor (des `Props`), sauf qu'ils sont constructibles eux aussi !

Bon, à ce stade on est un peu coincés parce-que `Constructables` ça hérite de `Buildings`. On aimerait éviter de dupliquer `Constructables` pour recoder quasiment la même chose côté `Props`.

Dans le meilleur des scénarios, on se retrouve donc avec des classes qui héritent de propriétés inutiles.

<div class="illustration">
    <img alt="Héritage, le problème" title="Héritage, le problème" src="/assets/img/object-composition-backbone/3-inheritance-issue.png">
    On n'a pas été très malins et on est coincés !
</div>

### Why so pseudo-classical?

Alors comment en sommes-nous arrivés là ? Comment s'en sortir ?

En fait, nous nous sommes un peu précipités quand la problématique de la constructibilité est apparue. Sans plus y réfléchir nous avons tenu la logique "`Productions` EST un `Constructables` qui EST un `Buildings` qui EST un `Objects`". Et PAF l'héritage !

Si on y regarde mieux, la constructibilité c'est un **comportement**. On ne peut pas dire que sans `Buildings` il n'y a pas d'élément `Constructables`. C'est une subtilité et une erreur assez fréquente en JavaScript parce-que l'héritage pseudo-classique c'est la seule chose que l'on retient : c'est le premier (mauvais) réflexe.

Dans notre cas, la seule chaîne d'héritage vraiment légitime est peut-être celle qui lie `Decorations` à `Props`. Et encore, je dis que l'on peut s'en passer.

En réalité, ce que l'on fourre dans `Objects`, c'est un ensemble de comportements qui sont communs à `Props` et `Buildings`. Mais en pratique, `Objects` ne représente rien de concret : ce serait une *classe abstraite* si nous faisions du Java. Idem pour `Buildings` ici d'ailleurs.

### Embrace composition

En JavaScript, je vous suggère de le prendre autrement : décrivons chaque comportement dans un objet qui lui est propre. Laissons tomber les constructeurs et la chaîne d'héritage.

Puis, combinons ces objets pour former le prototype des objets qui nous intéresse. Pas de *classe* à l'horizon, simplement des objets qui **se composent** d'autres objets. Éventuellement des *factories* pour construire le bon objet au besoin.

<div class="illustration">
    <img alt="Composition, la solution" title="Composition, la solution" src="/assets/img/object-composition-backbone/4-composition-resolution.png">
    Il est bien plus simple de jouer aux Legos !
</div>

<p class="islet">
  Dans le cas de où l'on vient augmenter notre prototype avec d'autres objets, qui décrivent des comportements, on parle alors de <strong>mixin</strong>.<br><br>
  Si notre objet hérite d'un autre objet, on préfèrera utiliser <strong>l'héritage de prototype</strong>.
</p>

## Et avec Backbone ?

### Backbone.extend

Quand on utilise Backbone, on se sert de `.extend()` pour surcharger `Backbone.[Model|Collection|View|…]`. Puis on l'instancie avec `new`.

Du coup, il est assez fréquent de suivre le réflexe de l'héritage pseudo-classique et de se retrouver avec :

{% highlight javascript %}
var ObjectsModel = Backbone.Model.extend( … );
var BuildingsModel = ObjectsModel.extend( … );
var MarketsModel = BuildingsModel.extend( … );
{% endhighlight %}

Ce qui revient d'ailleurs à écrire :

{% highlight javascript %}
var MarketsModel = Backbone.Model.extend(…).extend(…).extend(…);

// Et on instancie au besoin
var marketsModel = new MarketsModel();
{% endhighlight %}

Backbone est ainsi fait et `.extend()` nous emmène très facilement sur cette pente glissante où les Models dépendent les uns des autres de manière plus ou moins subtile.

### Composer son prototype PUIS étendre

Quitte à devoir hériter de Backbone, autant limiter les dégâts. Ce n'est pas parce-que `.extend()` existe que nous sommes contraints de l'utiliser pour chaque objet que nous créons. Le seul objet que nous ayons à `.extend()` véritablement ici, c'est `Backbone.Model`.

L'idée, c'est de composer des objets pour former le prototype que nous allons **ensuite** utiliser dans le `.extend()` de notre Model / Collection / Vue…

{% highlight javascript %}
var objectsModelProto = { /* … */ };
var buildingsModelProto = { /* … */ };
var constructablesModelProto = { /* … */ };

// On compose pour former un nouveau prototype.
var marketsModelProto = _.assign(
  { /* … */ }, // -> interface spécifique à markets
  objectsModelProto,         //
  buildingsModelProto,       // => nos mixins
  constructablesModelProto,  //
  { /* … */ } // -> pour surcharger nos mixins, si besoin
);

// Une fois le prototype créé, on hérite de Backbone.
var MarketsModel = Backbone.Model.extend( marketsModelProto );

// Puis on instancie.
var marketsModel = new MarketsModel();
{% endhighlight %}

Ici `objectsModelProto`, `buildingsModelProto` et `constructablesModelProto` viennent surcharger le prototype de base de `marketsModelProto` pour rajouter des comportements spécifiques.

#### Merge ou assign

À noter qu'il peut être intéressant d'utiliser `_.merge` plutôt que `_.assign` si l'on souhaite pouvoir fusionner les attributs. Ça peut être pratique avec Backbone pour fusionner certains attributs tels que `events` :

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

## Pour conclure

Préférez la **composition d'objets** plutôt que **l'héritage**. N'utilisez l'héritage que si cela fait vraiment sens, ou si c'est nécessaire. Gare aux longues chaînes d'héritage : c'est fragile.

Ce qu'il est préférable d'éviter :

{% highlight javascript %}
// markets.model.js
var MarketsModel = ConstructablesModel.extend( { /* … */ } );

// main.js
var marketsModel = new MarketsModel();
{% endhighlight %}

Plus flexible, plus simple :

{% highlight javascript %}
// markets.model.js
var marketsModelProto = _.assign(
  { /* … */ }, // -> interface spécifique à markets
  objectsModelProto,
  buildingsModelProto,  
  constructablesModelProto
);

// main.js
var MarketsModel = Backbone.Model.extend( marketsModelProto );
var marketsModel = new MarketsModel();
{% endhighlight %}

Pour finir, voici quelques articles que je vous recommande pour aller plus loin sur le sujet de la composition et de l'héritage en JavaScript :

- [Understanding Prototypes, Delegation & Composition](http://www.datchley.name/understanding-prototypes-delegation-composition/) > une explication de A à Z simple, claire et illustrée
- [Common Misconceptions about Inheritance in Javascript](https://medium.com/javascript-scene/common-misconceptions-about-inheritance-in-javascript-d5d9bab29b0a) > FAQ détaillée qui va au fond de la question
