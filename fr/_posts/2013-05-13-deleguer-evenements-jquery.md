---
layout: post
robots: index,follow
published: true
comments: true

tags: [javascript, performance, jquery, events]
icon: jquery

title: Déléguer les événements en jQuery
description: Un petit rappel sur les écouteurs d'événements et les bonnes pratiques de délégations en jQuery.
---

## TL;DR

Jusqu'à **jQuery 1.7** on faisait la distinction entre `$.fn.bind`, `$.fn.live` et `$.fn.delegate` afin de créer des écouteurs d'événements.

`$.fn.bind` est la manière la plus basique d'attacher un écouteur à un objet, généralement un noeud du DOM.

`$.fn.live` est plus puissant car il attache l'écouteur à la racine du document et fait *vivre* le comportement sur chaque élément du DOM correspondant, y compris ceux créés par la suite.

`$.fn.delegate` se comporte plus ou moins comme `$.fn.live` à ceci près que l'on spécifie un noeud du DOM où l'on attache notre écouteur *live*, ce qui est bien plus rapide à l'exécution.

`$.fn.delegate` est plus performant que `$.fn.live` qui est plus performant que `$.fn.bind`.

Depuis **jQuery 1.7**, toutes ces méthodes ont étés remplacées par l'unique méthode `$.fn.on`. Les principes de performance sont les mêmes, seule la syntaxe change.


## Never gonna `bind` you up

C'est la méthode la plus élémentaire pour attacher un écouteur d'événements à un objet jQuery. Elle est généralement utilisée sur des éléments du DOM dans le but de créer des intéractions avec l'utilisateur :

{% highlight javascript %}
// Utilisation basique de $.fn.bind
$('div#main-content').bind('click', function() { ... });
{% endhighlight %}

Notre objet écoute désormais l'événement nommé `'click'` et réagira à chaque fois que cet événement sera déclenché. Sur l'exemple précédent par exemple, la fonction définie sera déclenchée à chaque fois que l'on cliquera sur l'élément `#main-content`.

`'click'` est l'un des noms d'événements usuels qui dispose d'une méthode raccourcie équivalente :
{% highlight javascript %}
// Équivalent du code précédent
$('div#main-content').click(function() { ... });
{% endhighlight %}

Cependant, il est possible de spécifier n'importe quel nom d'événement utilisé dans le code. En fait, c'est le point de départ de la [programmation événementielle](http://fr.wikipedia.org/wiki/Programmation_%C3%A9v%C3%A9nementielle) en JS, permettant de créer des applications web avancées.

{% highlight javascript %}
$('#foo').bind('my-event', function() { ... });
$('#foo').trigger('my-event');  // Déclenchera l'événement lié
{% endhighlight %}

<p class="islet">
    La méthode pour arrêter un tel écouteur est <code>$.fn.unbind</code>.
</p>

Avant **jQuery 1.7**, c'était la manière la plus basique de faire les choses.


## Born to be a `live`

Bien que le principe de `$.fn.bind` soit sympatoche, la méthode est assez limitée. Typiquement, elle a deux inconvénients :

1. Il attache un écouteur pour chacun des éléments qui correspondent au sélecteur, ce qui n'est pas la solution la plus optimale lorsque l'on cible plus d'un élément

2. Il attache un écouteur seuelement sur les éléments qui correspondent au sélecteur à ce moment précis, si vous modifiez le DOM et souhaitez créer de nouveaux éléments identiques, il vous faudra attacher les événements à nouveau.

{% highlight javascript %}
// Pas glop...
$('a.tooltip').bind('click', function() { ... });
// ou $('a.tooltip').click(function() { ... });
{% endhighlight %}

La solution développée avant **jQuery 1.7** était la méthode `$.fn.live` :

{% highlight javascript %}
// Utilisation basique de $.fn.live
$('li.text-info').live('hover', function() { ... });
{% endhighlight %}

Au lieu d'attacher un écouteur d'événements à chaque élément, il en attache un au niveau du *document root*. Ainsi, chaque nouvel élément qui correspond au sélecteur se comportera de la même manière. De plus, c'est **bien plus efficace** en termes de performance.

<p class="islet">
    La méthode pour arrêter un tel écouteur est <code>$.fn.die</code>.
</p>

Cette méthode est dépréciée depuis **jQuery 1.7**, mais le principe reste le même, ce qui est bon à savoir.


## Learn to `delegate`

La méthode `$.fn.delegate` est basiquement la même que `$.fn.live`, présentant les mêmes avantages par rapport à `$.fn.bind`:

{% highlight javascript %}
// Utilisation basique de $.fn.delegate
$('ul#main-navigation').delegate('li.text-info', 'hover', function() { ... });
{% endhighlight %}

Le truc c'est que, au lieu d'attacher chaque écouteur au *document root*, vous spécifiez l'élément du DOM où vous souhaitez porter votre attention. Ainsi, vous **augmentez significativement la performance** car c'est bien plus spécifique !

<p class="islet">
    La méthode pour arrêter un tel écouteur est <code>$.fn.undelegate</code>.
</p>


## Turn me `on`

Depuis **jQuery 1.7**, toutes les précédentes méthodes ont étés fusionnées dans une seule, puissante et unique méthode : `$.fn.on`.

Maintenant que vous avez compris comment les précédentes fonctionnent, voyons quels sont leur équivalent avec la syntaxe de celle-ci :

{% highlight javascript %}
// Utilisation basique de $.fn.on au lieu de $.fn.bind
$('div#main-content').on('click', function() { ... });

// Utilisation basique de $.fn.on au lieu de $.fn.live
$(document).on('hover', 'li.text-info', function() { ... });

// Utilisation basique de $.fn.on au lieu de $.fn.delegate
$('ul#main-nav').on('hover', 'li.text-info', function() { ... });
{% endhighlight %}

La distinction entre `$.fn.live` et `$.fn.delegate` et plus claire avec cette simple méthode, l'accent mis sur la délégation prend son sens (sauf si vous souhaitez explicitement attacher votre écouteur à la racine du document, ce qui est rare).

Vous pouvez également passer des **event data** via la méthode :

{% highlight javascript %}
// Attache des données à l'événement
$("a").each(function(i) {
    $(this).on('click', {index:i}, function(e) {
        alert('My index is ' + e.data.index);
    });
});
{% endhighlight %}

L'utilisation de `$.fn.on` est instinctive et rend la gestion événementielle très facile à prendre en main avec jQuery!

<p class="islet">
    La méthode pour arrêter un tel écouteur est... <code>$.fn.off</code>.
</p>

## Et pour la performance ?

Comme expliqué, voici le listing des méthodes, de la plus performante à la moins performante :

1. `.on(events, selector, [data,] handler)` équivaut à `$.fn.delegate`
2. `$(document).on(events, selector, [data,] handler)` équivaut à `$.fn.live`
3. `.on(events, [data,] handler)` équivaut à `$.fn.bind`

Pour résumer :

- Si vous avez besoin d'attacher un écouteur d'événements à plus d'un élément, utilisez `.on(events, selector, [data,] handler)`
- Si vous n'avez pas d'ancre sur laquelle vous rattacher, utilisez `$(document).on(events, selector, [data,] handler)`
- Sinon, utilisez `.on(events, [data,] handler)`, ou la fonction raccourcie s'il y en a une

## Conclusion

C'était un bref et gentil rappel sur la délégation des événements en jQuery.

Rien de nouveau sous le soleil mais cette article traite d'un point important. C'est un point à savoir que vous pouvez facilement retrouver sur le net en faisant quelques recherches.

Je me suis rendu compte il y a quelque temps que j'avais la fâcheuse tendance de toujours utiliser la fonction raccourcie, même pour traiter un certain nombre d'éléments, alors que j'aurais pu employer des méthodes bien plus efficaces. **Lorsque vous vous retrouvez à gérer plus d'un élément, pensez à la méthode `$.fn.on` !**

J'espère que ce petit point vous aura appris quelque chose ou rafraîchi la mémoire. Si c'est le cas, n'hésitez pas à me laisser votre opinion ci-dessous ;-)

Plop!
