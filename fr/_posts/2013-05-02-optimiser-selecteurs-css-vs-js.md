---
layout: post
robots: index,follow
published: true
comments: true

tags: [css, javascript, performance]
icon: css

title: Optimiser ses sélecteurs, CSS vs. JS
description: Petit mémo de bonnes pratiques quant à l'utilisation de sélecteurs en CSS et en Javascript. Ce qui vaut pour l'un ne l'est pas nécessairement pour l'autre.
---

## TL;DR

Les sélecteurs sont interprétés **de la droite vers la gauche**.

**En CSS**, il est préférable d'utiliser une classe plutôt qu'un identifiant dans la mesure où le premier fait tout aussi bien que le second et même plus. L'idée est de garder la spécificité du sélecteur la plus basse possible pour simplifier la maintenabilité du code.

**En JS**, un identifiant et une spécificité accrue donnera de meilleurs résultats en terme de performance. Il s'agit d'aller droit au but. Inutile cependant d'être trop spécifique, c'est contre-productif.

**Évitez d'utiliser le sélecteur universel `*` dans une chaîne de sélecteurs**.

Les deux pratiques ne sont pas incompatibles et n'empêchent pas votre HTML d'être sémantique :

{% highlight html %}
<!-- HTML -->
<article id="main-article">
    <!-- ... -->
    <ol role="navigation" class="nav nav--block pagination">
        <li class="pagination__prev">
            <a href="/page1">&lt; Previous</a>
        </li>
        <li class="pagination__next">
            <a href="/page3">Next &gt;</a>
        </li>
    </ol>
</article>
{% endhighlight %}

{% highlight css %}
/* CSS */
.nav {
    list-style:none;
    margin-left:0;
}

.nav--block {
    line-height:1;
}

/* Mauvaise idée */
.nav--block * {
    color: red;
}

/* Pas de gros soucis */
* {
    box-sizing: border-box;
}
{% endhighlight %}

{% highlight js %}
// Javascript (jQuery)
$('#main-article .nav--block .pagination__prev');   // fast
$('#main-article .nav--block li.pagination__prev'); // faster
$('#main-article').find('.pagination__prev');       // super-fast
{% endhighlight %}

## En CSS

<p class="islet">
    Ce qui va suivre relève de bonnes pratiques CSS connues sous le nom d'OOCSS (<em>Object Oriented CSS</em>). C'est une philosophie assez répandue et à laquelle j'adhère, mais ce n'est pas la seule façon de voir les choses. Je crois cependant qu'elle s'adapte à tout type de projets, grands ou petits, avec l'avantage d'être <em>future-proof</em>.<br><br>
    <a href="http://coding.smashingmagazine.com/2011/12/12/an-introduction-to-object-oriented-css-oocss/">Voici une introduction à ses principes</a>, pour ceux que ça intéresse, ainsi qu'une <a href="http://coding.smashingmagazine.com/2012/06/19/classes-where-were-going-we-dont-need-classes/">vision alternative</a> (que je ne partage pas, mais qui a sa légitimité selon moi). Libre à chacun de suivre sa voie.
</p>

#### Class ou ID ?

Pour faire bref, du point de vue du CSS **une classe peut faire tout ce que fait un identifiant mais un identifiant ne peut pas être réutilisé**.

Partant de ce constat, l'usage d'une classe peut facilement se substituer à celui d'un identifiant et permet d'anticiper sur l'avenir.

De plus, un identifiant augmente considérablement la spécificité de la déclaration, ce qui peut vite entraîner un joli bordel au fil du temps, et une utilisation inappropriée de `!important` ou autre déclarations de style inline, directement dans le HTML, pour surcharger le style désiré. Autrement dit, c'est pas joli à voir !

{% highlight html %}
<!-- Pas très future-proof -->
<ol id="pagination">
    <li>
        <a href="/page1">&lt; Previous</a>
    </li>
    <li>
        <a href="/page3">Next &gt;</a>
    </li>
</ol>
{% endhighlight %}

{% highlight css %}
#pagination {
    list-style:none;
    margin-left:0;
    line-height:1;
}
{% endhighlight %}

Quid si demain apparaît un autre type de pagination sur un module de la page ? On crée un nouvel identifiant avec un autre nom et peu ou prou les mêmes propriétés ? Et puis, la pagination n'est-elle pas une sorte de menu de navigation en soi ?

{% highlight html %}
<!-- Future-proof -->
<ol class="nav pagination">
    <li>
        <a href="/page1">&lt; Previous</a>
    </li>
    <li>
        <a href="/page3">Next &gt;</a>
    </li>
</ol>
{% endhighlight %}

{% highlight css %}
.nav {
    list-style:none;
    margin-left:0;
}

.pagination {
    line-height:1;
}
{% endhighlight %}

La classe `.nav` est d'ailleurs parfaitement réutilisable, c'est une couche d'abstraction qui détermine les propriétés communes à tous mes menus de type *navigation* sur mon site (*à son pépère !*).

#### Bewaaaaare la spécificité !

En CSS, [les règles de spécificité](http://blog.organicweb.fr/comprendre-le-poids-des-regles-css) sont plus ou moins simples, plus ou moins connues et engendrent plus ou moins de problèmes selon que l'on ait plus ou moins écrit son CSS intelligemment.

Pour faire bien, faisons simple : **ne vous lancez pas dans des sélecteurs trop spécifiques qui alourdissent la règle inutilement**.

Il s'agit de rester dans l'esprit OOCSS : les classes sont autant d'objets plus ou moins abstraits que l'on combine, tels des legos, pour produire le résultat attendu. C'est plus stable et maintenable dans le temps !

{% highlight css %}
ol.nav { ... }              /* 0-0-1-1 spécification inutile */
article > .nav li a { ... } /* 0-0-1-3 trop spécifique ! */
.pagination__prev { ... }   /* 0-0-1-0 OK */
{% endhighlight %}

L'idée est de produire un code CSS performant car :
- non dépendant du contexte HTML dans lequel il se trouve (flexibilité)
- pouvant être facilement surchargé (maintenabilité)
- accessoirement, simple à concevoir

Un bon indicateur d'un CSS qui part en vrille réside dans le fait d'utiliser `!important` pour appliquer un style *"parce-que sinon ça ne marche pas et konsaipapourkoi"* !

Si les chiffres ne sont pas votre fort (et que vous n'aimez pas mon lien précédent et son dessin récapitulatif), [voici un calculateur en ligne de spécificité CSS](http://css-specificity.webapp-prototypes.appspot.com/) qui peut vous aider. L'idée est de garder une spécificité avoisinant `[0-0-1-0]` pour vos règles (l'équivalent d'une classe CSS), d'une manière générale. Ainsi, plus de perte de temps à investiguer pourquoi votre style ne s'applique pas.

## En Javascript

<p class="islet">
    <strong>N.B.</strong> - <em>Javascript</em> est un abus de langage ici dans la mesure où je parle de bibliothèques JS avec jQuery en référence.<br><br>
    Il convient cependant de noter qu'en termes de performances, le JS pur donnera de meilleurs résultats et <code>document.getElementById()</code> est probablement <a href="http://jsperf.com/id-selector-comparison/3">le plus performant</a>.
</p>

#### Un(e) bon(ne) ID

L'identifiant est de loin le plus efficace des sélecteurs. Une fois que le moteur de sélection a trouvé l'élément, il arrête sa traversée du DOM. L'utilisation d'un identifiant est pertinente dans le cas du Javascript car l'on souhaite, la plupart du temps, travailler avec un élément bien précis, identifié.

En bref, il est bien plus efficace **d'isoler l'identifiant dans le sélecteur**, puis de chainer avec une fonction de recherche, afin de limiter le champ de recherche du moteur :
{% highlight js %}
$('#main-article .pagination__prev');         // rapide
$('#main-article').find('.pagination__prev'); // 2 fois plus rapide
{% endhighlight %}

Dans le premier cas, le moteur va chercher l'ensemble des éléments dans le DOM portant la classe `.pagination__prev`, puis rechercher ceux qui se trouvent dans le bloc identifié par `#main-article`.

Dans le second cas, le moteur va d'abord rechercher le bloc `#main-article`, puis va chercher les éléments portant la classe `.pagination__prev` à l'intérieur de ce bloc.

Je vous invite à [tester par vous-même les performances](http://jsperf.com/optimized-js-selectors).

#### Spécifique mais pas trop

Il s'agit d'un petit point mais **augmenter la spécificité à droite de votre sélecteur** peut permettre à votre moteur d'aller plus vite dans sa recherche effectivement.

En revanche, inutile d'en faire des caisses : évitez d'alourdir inutilement votre sélecteur ou votre performance en pâtira.

{% highlight js %}
$('ol.nav--block .muted');                    // non-optimisé
$('.nav--block li.pagination__next a.muted'); // non-optimisé
$('.nav--block a.muted');                     // optimisé
{% endhighlight %}

## Gare au sélecteur universel

<p class="islet">
    MAJ le 4 Mai 2013 après une <a href="http://paulirish.com/2012/box-sizing-border-box-ftw/">intéressante lecture</a> sur l'utilisation de <code>*</code> en CSS et son impact sur la performance (le paragraphe sur la performance).
</p>

Que ce soit en CSS ou en JS, `*` peut devenir la bête noire des performances en terme de sélection.

Mal utilisé en CSS ou, sans le savoir, dans les sélecteurs JS, c'est ce qu'il peut y avoir de pire pour le moteur de sélection qui doit se coltiner tous les éléments du DOM.

**Dans le cas du CSS**, posez-vous la question : ais-je vraiment besoin de cibler tous les éléments, quels qu'ils soient ? La réponse sera probablement "non".

Et n'allez pas croire que ceci est une bonne idée :

{% highlight css %}
.nav--block * {
    color: red;
}
{% endhighlight %}

Car si vous lisez *"dans les éléments `.nav--block`, tous les éléments"*, le moteur lira *"tous les éléments, puis ceux qui ont `.nav--block` comme parent"*. De droite à gauche on vous dit !

En revanche, ceci ne posera pas de soucis de performance, à moins que vous en soyez à peaufiner votre score [Page Speed](https://developers.google.com/speed/pagespeed) au delà de 90 (autrement dit, c'est pas la priorité) :

{% highlight css %}
/* apply a natural box layout model to all elements */
* {
    -moz-box-sizing: border-box;
    -webkit-box-sizing: border-box;
    box-sizing: border-box;
}
{% endhighlight %}

**Dans le cas du JS**, c'est encore plus fourbe car si vous ne faîtes pas attention, vous le suggérez par défaut. Enfin, il existe probablement des fonctions alternatives qui permettent d'arriver à exprimer ce que vous souhaitez faire.

{% highlight js %}
$('.nav--block > *');         // ouch !
$('.nav--block').children();  // mieux

$('.form-fields :radio');      // = $('.form-fields *:radio');
$('.form-fields input:radio'); // mieux
{% endhighlight %}

## Le mot de la fin

Voilà pour mon petit point de vue sur les sélecteurs.

Ce sont quelques bonnes pratiques que j'ai intégré avec le temps et qui sont ouvertes à la discussion ; n'hésitez pas à émettre des remarques, questions ou suggestions ci-dessous =)

Plop !
