---
layout: post
robots: index,follow
published: true
comments: true

tags: [javascript, functional programming]

title: Fonctions pures en JavaScript
description: Qu'est-ce-qu'une fonction pure et pourquoi s'y intéresser en JavaScript ?
---

## C'est quoi ça une fonction "pure" ?

Une fonction pure **ne dépend pas** et **ne modifie pas l'état de variables hors de sa portée**.

En pratique, cela signifie qu'**une fonction pure retourne toujours le même résultat avec des paramètres identiques**. Son exécution ne dépend pas de l'état du système.

Les fonctions pures sont d'ailleurs un pilier de la [programmation fonctionnelle](http://fr.wikipedia.org/wiki/Programmation_fonctionnelle).

### Quelques exemples

{% highlight javascript %}
var values = { a: 1 };

function impureFunction ( items ) {
  var b = 1;

  items.a = items.a * b + 2;
}

var c = impureFunction( values );
// Désormais `values.a` vaut 3 car la fonction impure l'a modifié.
{% endhighlight %}

Ici, on modifie les attributs de l'objet passé en paramètre, donc on modifie l'objet en dehors de la portée de notre fonction également : elle est impure dans ce cas.

{% highlight javascript %}
var values = { a: 1 };

function pureFunction ( a ) {
  var b = 1;

  a = a * b + 2;

  return a;
}

var c = pureFunction( values.a );
// `values.a` n'a pas été modifié, c'est toujours 1
{% endhighlight %}

Ici, on modifie simplement le paramètre dans la portée de la fonction, on ne touche à rien d'autre en dehors !

{% highlight javascript %}
var values = { a: 1 };
var b = 1;

function impureFunction ( a ) {
  a = a * b + 2;

  return a;
}

var c = impureFunction( values.a );
// En fait la valeur de `c` dépend de celle de `b`.
// Dans une base de code plus grande vous risquez d'oublier ce
// détail et le résultat peut vous surprendre car il peut varier
// de manière implicite.
{% endhighlight %}

La variable `b` n'est pas dans la portée de la fonction. Le résultat dépendra du contexte : surprises garanties !

{% highlight javascript %}
var values = { a: 1 };
var b = 1;

function pureFunction ( a, c ) {
  a = a * c + 2;

  return a;
}

var c = pureFunction( values.a, b );
// Ici il est clair que la valeur de `c` dépend de celle de `b`. 
// Pas de surprise en douce.
{% endhighlight %}

## Et en pratique ça donne quoi ?

Considérons que ce code existe :

{% highlight javascript %}
var getMinQuantity = function getMinQuantity ( name ) {
  // Une fonction pure qui retourne une valeur numérique
  // en fonction du name.
};
{% endhighlight %}

Et prenons donc l'exemple du code suivant que l'on pourrait retrouver dans un projet lambda :

{% highlight javascript %}
var popover = {

  // Un tas de code…

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

  // Un tas de code…

};
{% endhighlight %}

Ici nous avons `addQuantityText()`, `formatQuantityText()` et `setQuantityTextColor()` qui sont toutes impures.

Dans notre contexte, c'est `addQuantityText()` qui est utilisée lorsque l'on souhaite "afficher la quantité" dans notre `$$boxContainer`. C'est le point d'entrée qui se charge de tous les détails. C'est dans cette fonction qu'on va aller jeter un œil si un soucis se présente avec notre `$$quantity`. Ça risque de devenir un vrai jeu de piste.

La manière dont il a été écrit peut être propice à certaines erreurs sur le long terme.

### Quand ça devient compliqué

Dans l'exemple, l'ordre d'exécution des fonctions est garant du bon fonctionnement du code.

**Il suffit d'échanger l'ordre de 2 lignes pour tout casser**. Ça peut paraître évident, mais ça l'est beaucoup moins à repérer :

{% highlight javascript %}
var popover = {

  // Un tas de code…

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

  // Un tas de code…

};
{% endhighlight %}

Il y a désormais une erreur dans le code. Le problème, c'est que ça ne saute pas aux yeux !

Ici, `setQuantityTextColor()` est responsable de la couleur de `$$quantity`. Du coup, il faut naviguer de méthodes en méthodes pour trouver celle qui modifie l'objet en dernier et reconstituer le flow pour comprendre ce qui pourrait mal se passer.

À ce moment là, on pourrait presque s'en mordre les doigts d'avoir découpé `formatQuantityText()` en petites méthodes pour simplifier les détails de son implémentation.

D'une manière générale d'ailleurs, ça fait pas mal de code à considérer en cas de debug. Et si on commence à estimer que décomposer une grosse méthode en petites complique la tâche de debug, alors le concept de **fonction pure** prend de l'intérêt.

### Avec des fonctions pures

Reprenons notre code en utilisant cette fois un maximum de fonctions pures :

{% highlight javascript %}
var popover = {

  // Un tas de code…

  // L'ensemble des modifications de l'état du système sont
  // concentrées ici.
  // Seule cette méthode est responsable de l'insertion
  // d'un élément, ce qui simplifie le debug et limite les
  // effets de bord.
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

  // Cette fonction n'a pas d'effet de bord.
  // Elle n'appelle que des fonctions pures. Elle crée et
  // retourne l'objet canvas désiré, correctement configuré !
  formatQuantityText: function ( options ) {
    var namespace = options.namespace || "quantity";
    var quantity = options.quantity || 0;

    var $$quantity = new Canvas(); // implementation details hidden
    $$quantity.name = namespace;
    $$quantity.value = quantity;
    $$quantity.color = this.getQuantityTextColor( quantity, namespace );

    return $$quantity;
  },

  // Cette méthode n'a plus d'effet de bord non plus,
  // elle se charge de renvoyer la bonne couleur en fonction
  // de la quantité en paramètre.
  getQuantityTextColor: function ( quantity, namespace ) {
    var minQuantity = getMinQuantity( namespace );
    var hasEnoughQuantity = (quantity && quantity >= minQuantity);

    return (hasEnoughQuantity) ? "green" : "red";
  },

  // Un tas de code…

};
{% endhighlight %}

Il n'y a pas de changement fondamental dans cette nouvelle version du code. Et pourtant, les bénéfices ne sont pas négligeables.

Ce qu'on a fait :

- `getQuantityTextColor()` plutôt que `setQuantityTextColor()`
- la méthode nous retourne une couleur en fonction de la quantité passée en paramètre au lieu de modifier l'objet qu'on lui passait en paramètre auparavant
- les méthodes ne dépendent plus de variables en dehors de leur portée
- les méthodes appellent uniquement des méthodes pures
- on isole la création / modification de l'objet `$$quantity` dans `formatQuantityText()`
- on isole les modifications de l'état du système dans la seule méthode `addQuantityText()`

Ainsi, nous avons supprimé les méthodes qui avaient des effets de bords. Nous avons donc **simplifié la maintenance du code**. Si jamais il y a un soucis avec `$$quantity`, il n'y a qu'une méthode à regarder.

### Simplification de l'interface

Nous utilisons ici des méthodes publiques. Il serait tout à fait envisageable, voire carrément pertinent, de les rendre privées.

En effet, elles n'ont pas grand chose à faire dans notre API car **leur rôle est de simplifier l'interface**. Allez jeter un œil à mon article sur [les fonctions privées avec Backbone.js]({% post_url 2014-12-07-fonctions-privees-backbonejs %}) si ça vous laisse perplexe.

Comme elles sont pures, les extraire est un jeu d'enfant puisqu'elles ne dépendent d'aucun contexte mais simplement des paramètres !

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

Et du coup, plus loin dans le code :

{% highlight javascript %}
var popover = {

  // Un tas de code…

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

  // Un tas de code…

};
{% endhighlight %}

## L'intérêt des fonctions pures

L'avantage d'une fonction pure, c'est qu'**elle n'a pas d'effets de bord**. Elles ne modifient pas l'état du système en dehors de leur portée. Ainsi, elles simplifient et clarifient le code : quand on appelle une fonction pure, on peut se concentrer sur la valeur qu'elle retourne puisqu'on sait qu'elle ne va pas impacter le système en passant.

Une fonction pure est également robuste. **Son ordre d'exécution n'a pas d'impact sur le système**. Les opérations sur des fonctions pures sont donc parallélisables.

De même, **il est très simple de tester une fonction pure** puisqu'il n'y a pas de contexte considérer. Il suffit de se concentrer sur les entrées / sorties.

Enfin, maximiser le nombre de fonctions pures **rend le code plus simple, plus flexible**.

## Une question de design

En pratique quand on fait de l'orienté-objet, on se dit que les concepts de la programmation fonctionnelle paraissent inadaptés. C'est une erreur car [POO et FP sont parfaitement compatibles](http://blog.cleancoder.com/uncle-bob/2014/11/24/FPvsOO.html) !

En effet, l'idée ici est toute simple : **simplifier le code en limitant le nombre de fonctions qui ont un impact sur l'état du système**.

En s'efforçant à écrire un maximum de fonctions pures, en limitant le nombre de fonctions qui ne le sont pas, on se simplifie la vie !

En tout cas, c'est l'idée. Et souvent, en pratique, c'est surtout une question de design, de choix entre un `get` et un `set` par exemple.
