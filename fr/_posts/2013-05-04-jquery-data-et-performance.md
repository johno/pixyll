---
layout: post
robots: index,follow
published: true
comments: true

tags: [javascript, jquery, performance, html5]
icon: jquery

title: jQuery, data et performance
description: Bonne pratique et manipulation des données en jQuery, sans colorants ni conservateurs.
---

## TL;DR

jQuery simplifie la manipulation des données rattachées aux éléments.

L'attribut HTML5 `data-*` est lié à l'objet **data** de jQuery pour les éléments du DOM.

`$.data(element, key[, value])` permet de manipuler des données rattachées aux éléments du DOM.

`$.fn.data(key[, value])` permet de manipuler des données rattachées aux éléments jQuery.

`$.data` étant plus basique que `$.fn.data`, il est plus rapide à l'exécution. Il est en revanche moins flexible, moins pratique et il ne permet pas d'accéder aux attributs `data-*`.

{% highlight html %}
<!-- HTML -->
<div id="main-content"></div>
{% endhighlight %}

{% highlight javascript %}
// Javascript
var $el = $('#main-content');

$el.data('key', 'plop');    // rapide
$.data($el, 'key', 'plop'); // 10 fois plus rapide
{% endhighlight %}

Enfin, ces 2 méthodes ne modifient pas le DOM, contrairement à `$.fn.attr`.

{% highlight javascript %}
$el.data('key', 'plop');
    // <div id="main-content"></div>
$.data($el, 'key', 'plop');
    // <div id="main-content"></div>
$el.attr('data-key', 'plop');
    // <div id="main-content" data-key="plop"></div>
{% endhighlight %}

## Manipuler des data avec jQuery

Rattacher une information à un élément et la manipuler au fil de l'exécution d'un script est une opération vraiment simple avec jQuery. En effet, la bibliothèque dispose de méthodes permettant de stocker, modifier et supprimer les données relatives à un élément.

Par ailleurs, il est intéressant de savoir que les attributs `data-*` introduits par le HTML5 sont automatiquement transformés en objet **data** jQuery et sont donc accessibles par le biais de certaines de ces méthodes.

#### $.fn.data

La méthode la plus populaire est `$.fn.data` qui s'utilise de la manière suivante :

{% highlight javascript %}
// Affecte la chaîne de caractère "plop" à la clef "key"
elem.data('key', 'plop');

// Lit la donnée portant la clef "key"
elem.data('key');
{% endhighlight %}

{% highlight html %}
<!-- Code valide en HTML5 -->
<div id="elem" data-my-key="hey"></div>
{% endhighlight %}
{% highlight javascript %}
$('#elem').data('myKey'); // Retourne "hey"
{% endhighlight %}

<p class="islet">
    Vous noterez que l'on retire <code>data-</code> et l'on supprime les tirets du HTML pour spécifier la clef, avec une notation à la CamelCase conformément à <a href="http://www.w3.org/TR/html5/dom.html#embedding-custom-non-visible-data-with-the-data-*-attributes">la spécification W3C</a>.
</p>

[La documentation](http://api.jquery.com/data/) est simple à assimiler et présente plutôt bien le concept.

Notez que l'on dispose également de la méthode `$.fn.removeData` pour nettoyer tout cela si besoin :

{% highlight javascript %}
elem.removeData('key'); // Bye bye !
{% endhighlight %}

#### $.data

Il existe également la méthode jQuery `$.data` plus bas-niveau, moins connue. Elle remplie quasiment le même rôle, à ceci près que sa syntaxe diffère et qu'elle considère l'élément du DOM associé en paramètre.

{% highlight javascript %}
// Affecte la chaîne de caractère "plop" à la clef "key"
$.data(elem, 'key', 'plop');

// Lit la donnée portant la clef "key"
$.data(elem, 'key');
{% endhighlight %}

Là encore, je vous invite à jeter un oeil à [la documentation officielle](http://api.jquery.com/jQuery.data/).

L'on dispose également de la méthode `$.removeData` pour supprimer des données, ainsi que de la méthode `$.hasData` pour vérifier si l'élément a des données rattachées ou non :

{% highlight javascript %}
$.hasData(elem);           // Retourne "true"
$.removeData(elem, 'key'); // Bye bye !
$.hasData(elem);           // Retourne "false"
{% endhighlight %}

## Performance vs. Puissance

Quel est l'intérêt d'utiliser `$.data` quand `$.fn.data` est plus sexy me direz-vous ?

Et bien comme la méthode est plus bas-niveau, plus simple, **elle s'exécute aussi bien plus rapidement** !

{% highlight javascript %}
el.data('key', 'plop');    // rapide
$.data(el, 'key', 'plop'); // jusqu'à 10 fois plus rapide
{% endhighlight %}

Je vous invite à [tester les performances par vous-même](jsperf.com/jquery-fn-data-vs-data).

En contrepartie, elle doit rattacher les données à un élément du DOM tandis que `$.fn.data` peut gérer des données sur toute sorte d'objet jQuery, y compris les évènements :

{% highlight javascript %}
// Affecte l'index de chaque lien comme donnée de l'événement "click"
// Quand on clique sur un lien, ça affiche son index
$("a").each(function(i) {
    $(this).on('click', {index:i}, function(e) {
        alert('Mon index est ' + e.data.index);
    });
});
{% endhighlight %}

Enfin, `$.data` ne gère pas les attributs HTML5 `data-*` tandis que `$.fn.data` si.

En pratique :
- si l'on travaille avec un événement, on utilise `$.fn.data`
- si l'on travaille avec un attribut HTML5 `data-*`, on utilise `$.fn.data`
- dans tous les autres cas, on utilise `$.data` parce-qu'il est plus performant

## Un mot sur le DOM

Il est bon de noter que les deux méthodes `$.data` et `$.fn.data` ont ceci en commun qu'elles **ne modifient pas le DOM**.

Plus concrètement, si la méthode `$.fn.data` permet d'accéder aux attributs `data-*`, elle ne les modifiera pas (pas dans le DOM). En effet, il ne faut pas se laisser embrouiller par le niveau d'abstraction de la fonction : ce n'est pas l'attribut que vous manipulez par cette méthode mais **un objet jQuery**, créé automatiquement pour l'occasion.

En contrepartie, la méthode `$.fn.attr` est une alternative qui permet d'accéder aux attributs du DOM ainsi que de les modifier.

{% highlight html %}
<div id="main-content" data-my-key="hey"></div>
{% endhighlight %}

{% highlight javascript %}
$('#main-content').data('myKey', 'plop');
    // Change l'objet jQuery mais ne change pas le DOM
    // <div id="main-content" data-my-key="hey"></div>
    // Rq: $('#main-content').data('myKey') retourne bien "plop"

$('#main-content').attr('data-my-key', 'plop');
    // Change effectivement le DOM
    // <div id="main-content" data-key="plop"></div>
{% endhighlight %}

Dans le premier cas, nous avons bel et bien modifié l'objet jQuery, mais aucune opération n'est menée sur le HTML.

Dans le second cas en revanche, c'est bel et bien le HTML que l'on modifie.

En ce qui concerne la performance, il est à noter que [le second est plus rapide que le premier](http://jsperf.com/jquery-fn-data-vs-fn-attr). Une raison à cela est probablement que `$.fn.data` fait bien plus que juste "accéder" à l'élément : il le caste en fonction de son type.

Ainsi, cela peut être assez utile pour l'élaboration de plugins ou de widgets :

{% highlight html %}
<div class="widget" data-row="2" data-responsive="true"></div>
{% endhighlight %}

{% highlight javascript %}
$('.widget').each(function () {
    $(this).myWidget(
        $(this).data('rows'),
        $(this).data('responsive')
    );
});
{% endhighlight %}

En contrepartie, `$.fn.attr` renverra toujours une chaîne de caractères, ce qui peut être utile dans certains cas.

## Le mot de la fin

Voici pour une brève (mais intense !) présentation des méthodes qui existent en jQuery pour manipuler les données.

Le point sur la performance me semblait intéressant, il ne faut pas se formaliser pour autant : ce n'est pas cela qui boostera considérablement vos scripts. Cela étant, c'est toujours bon à savoir !

Avec un peu de chance, cela aura été l'un de vos *"Aha moment"* en JS ([comme diraient certains](http://hugogiraudel.com/2013/04/30/css-aha-moment/)) =)

Plop !
