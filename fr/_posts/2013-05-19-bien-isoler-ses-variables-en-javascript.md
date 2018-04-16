---
layout: post
robots: index,follow
published: true
comments: true

tags: [javascript, jquery]

title: Bien isoler ses variables en Javascript
description: Une histoire de fonctions anonymes et auto-exécutantes (IIFE)... Parce-qu'on n'y pense pas assez, et que c'est bien pratique quand même !
---

## TL;DR

Ne pas se préoccuper de la portée des variables en Javascript, c'est aller au-devant de graves déconvenues. Il est important **d'isoler l'environnement de son script** afin de ne pas modifier involontairement des variables globales lors de son exécution.

Les **fonctions anonymes auto-exécutantes** (ou [IIFE](http://en.wikipedia.org/wiki/Immediately-invoked_function_expression), selon) permettent donc d'isoler le code sans perturber son exécution :

{% highlight javascript %}
(function() {
    // votre code JS
})();
{% endhighlight %}

De plus, elle rendent le code plus flexible et robuste en permettant de créer des alias aux variables globales passées en paramètre :

{% highlight javascript %}
(function(window, $) {
    // votre code JS
})(window, jQuery);
{% endhighlight %}


## Enveloppé, Piqué, Porté(e) !

Je laisse les premiers points aux Étoiles et je me concentrerais ici sur la question de **la portée des variables** en Javascript. Ce point, auquel on ne songe pas assez, est en effet susceptible de causer bien des soucis à grande échelle si l'on n'y prend pas garde.

Pour faire simple, il serait fort regrettable que le script que l'on est en train d'écrire ne se comporte pas comme prévu parce-que la variable `gobgob` que l'on déclare est déjà utilisée ailleurs et qu'on n'y a pas fait attention.

Il serait également gênant que notre superbe plugin de slideshow se mettent à planter complètement à l'exécution de notre script. Pourquoi ? Parce-que nous n'aurons pas pris garde au fait que ce magnifique plugin utilise la même variable que nous, et que nous venons tout juste de changer sa valeur (du coup) !

Pour éviter ce genre de scénario bien fâcheux, il faut **isoler les variables** de notre script du reste de l'environnement. C'est tout à fait réalisable et, si ce plugin avait été si magnifique que ça, c'est ce qu'il aurait fait !

#### Petit rappel sur la portée des variables en JS

En déclarant une variable comme il se doit, celle-ci est accessible à tout le script dans lequel elle est contenue, y compris dans les fonctions qui y sont déclarées.

{% highlight javascript %}
var gobgob = "Hey !";
function maFonction() {
    console.log(gobgob);
}

// Renvoie "Hey !"
maFonction();
{% endhighlight %}

En revanche, une variable proprement déclarée dans une fonction n'est pas accessible à l'extérieur de celle-ci : elle est isolée dans la fonction.

Cependant, le fait d'omettre le mot clef `var` lors de la déclaration d'une variable rend celle-ci **globale**, c'est à dire accessible depuis tout le script (ce qui, en général, n'est pas très très propre).

{% highlight javascript %}
function maFonction() {
    var gobgob = "Hey !";
    gubgub = "Ho !";
}

maFonction();

// Renvoie "ReferenceError: gobgob is not defined"
console.log(gobgob);

// Renvoie "Ho !"
console.log(gubgub);
{% endhighlight %}

Ce que nous souhaitons, c'est faire en sorte que les variables de notre script ne viennent pas modifier d'éventuelles variables qui existeraient déjà ailleurs !

{% highlight javascript %}
var gobgob = "Hey!";

// (...)
// Quelque part, bien loin dans votre JavaScript...
// ... une surchage sauvage d'une variable existante (et oubliée) apparaît !
var gobgob = "Ho!";
{% endhighlight %}


## Sortez couverts !

Pour résoudre nos soucis, il s'agit donc **d'isoler les variables** afin de limiter leur portée au seul endroit qui nous intéresse et ne pas venir redéfinir par mégarde des variables ou polluer l'environnement (écologie toussa toussa) avec des variables globales qui n'ont pas lieu d'être.

Pour cela, il s'agit d'envelopper notre code Javascript dans ce que l'on appelle basiquement une **fonction anonyme auto-exécutante** :

{% highlight javascript %}
(function() {
    // votre code JS
})();
{% endhighlight %}

Cette encapsulation est donc :

- **anonyme** car la fonction ne porte pas de nom
- **auto-exécutante** car elle est interprétée directement grâce au petit `();` final

Pour reprendre notre exemple précédent :

{% highlight javascript %}
var gobgob = "Hey !";

// On enveloppe notre script comme il faut
(function() {
    var gobgob = "Ho!";

    // Renvoie "Ho!"
    console.log(gobgob);
})();

// Renvoie "Hey !" -> bingo !
console.log(gobgob);
{% endhighlight %}

Rien n'est boulversé dans l'exécution du script.

Par contre, **nous n'avons plus à nous soucier des autres variables** qui peuvent exister à partir du moment où nous travaillons dans notre environnement isolé : nous ne venons pas modifier par mégarde une variable globale !

En revanche, rien ne nous empêche d'utiliser une variable globale pour autant :

{% highlight javascript %}
var gobgob = "Hey !";

(function() {
    // Renvoie "Hey !"
    console.log(gobgob);
})();
{% endhighlight %}

#### Renommer des variables globales dans notre script

Il est également possible de **passer des variables en paramètre**, généralement afin de les redéfinir pour l'usage de notre script. C'est d'ailleurs une bonne pratique à adopter lorsque vous travailler avec une librairie telle que *jQuery* !

Imaginez que vous souhaitiez créer un petit script sympatoche. Si vous utilisez *jQuery*, vous allez probablement utiliser des `$` à gogo !

Seulement, que se passe-t-il si demain une autre bibliothèque vient complémenter *jQuery* et utilise également le `$` comme référence ? Vous aller passer *jQuery* [en mode `noConflict()`](http://api.jquery.com/jQuery.noConflict/)... et vous allez devoir reprendre votre script pour transformer tous vos `$` en `jQuery`.

Ou alors, vous avez retenu ce que vous avez lu ici et 2 lignes de code vous permettront d'isoler bien proprement votre script, qui s'exécutera quoiqu'il arrive :

{% highlight javascript %}
(function($) {
    // votre script JS avec des $ tout partout
})(jQuery);
{% endhighlight %}

L'avantage de cette technique c'est que vous pouvez rapidement switcher de librairie sans modifier votre script, qui gagne donc en flexibilité et stabilité :

{% highlight javascript %}
(function($) {
    // votre script JS avec des $ tout partout
})(Zepto);
{% endhighlight %}

<p class="islet">
    <strong>Note performance</strong> - Le double effet Kiss Cool de cette technique intervient lors de la minification de votre script. En effet, il sera possible de minifier les noms de toutes vos variables sans affecter le code (puisqu'il s'agit ni plus ni moins d'alias au final), donc de gagner de la place.
</p>

{% highlight javascript %}
// Exemple où les occurrences à `window` ont été minimifiées
(function(a) {
    console.log(a === window); // Renvoie `true`
})(window);
{% endhighlight %}

#### Astuce : Créer un alias pour `undefined`

Une bonne pratique, qui est également utilisée [dans le code source de *jQuery*](http://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.js), consiste à déclarer un paramètre supplémentaire non défini, qui vaudra alors `undefined` dans votre script :

{% highlight javascript %}
(function(window, $, undefined) {
    // Crée une variable gobgob valant `undefined`
    var gobgob;
    console.log(gobgob === undefined);  // Renvoie `true`

    // Notre dernière variable est donc un alias pour `undefined`
})(window, jQuery);
{% endhighlight %}

#### Astuce bis : Accéder au variables, en dehors

*Merci [@fabien0102](https://twitter.com/fabien0102) pour m'avoir fait remarquer qu'il manquait ce point de détail.*

Isoler son code, c'est bien. Mais parfois, on développe un plugin/une librairie et on aimerait bien pouvoir accéder à notre objet de l'extérieur, histoire de pouvoir s'en servir.

Il existe probablement différentes alternatives, mais en voici une toute simple : il suffit d'attacher notre variable à `window`, et ça marche.

{% highlight javascript %}
(function(window, undefined) {
    // Crée une variable gobgob et l'attache à window
    var gobgob = "Hey !";
    window.gobgob = gobgob;
})(window);

// Renvoie "Hey !"
console.log(gobgob);
{% endhighlight %}


## Le mot de la fin

Cet article français se place dans la lignée des bonnes pratiques Javascript. C'est un premier pas vers l'élaboration de splendides scripts modulaires qui sont les composantes de plus gros projets.

Ce n'est pas quelque chose de radicalement nouveau pour autant, bien qu'il n'y ait pas masse d'articles francophones sur la question (à ce niveau là, il faut généralement se mettre à la langue de Shakespeare).

Enfin, je trouvais que cela faisait une bonne mise en pied à l'explication du fonctionnement d'un plugin jQuery (ça c'est du teasing).

Comme d'habitude, n'hésitez pas à émettre remarques, suggestions et questions aussi diverses que variées ci-dessous.

Plop !
