---
layout: post
robots: index,follow
published: true
comments: true

tags: [less, sass]
icon: css

title: Convertir un projet SASS en LESS
description: Similitudes, différences et équivalences de ces deux pré-processeurs CSS.
---

## Les goûts et les couleurs

[LESS](http://lesscss.org/) et [SASS](http://sass-lang.com/) sont aujourd'hui [les deux pré-processeurs CSS les plus populaires](http://css-tricks.com/poll-results-popularity-of-css-preprocessors/), et de loin.

Tous deux sont assez similaires et apportent au CSS les fonctionnalités dont rêvent basiquement tout développeur front-end, à savoir : variables, fonctions, opérations mathématiques, imbrication des sélecteurs, etc.

Cependant, leur nature diffère quelque peu :

- SASS est compilé en Ruby, il présente deux syntaxes différentes : `.sass` et `.scss`.<br>
La seconde, plus proche de celle du CSS, est la plus utilisée.
- LESS est compilé en Javascript, il présente une syntaxe assez proche du CSS.

D'une manière générale, on constate que [SASS est plus puissant que LESS](http://css-tricks.com/sass-vs-less/) car il dispose notamment d'un certain nombre de fonctionnalités supplémentaires. Toutefois, les goûts et les couleurs étant ce qu'ils sont, LESS peut tout à fait suffir à vous contenter car il est bien suffisant et, selon moi, un peu plus facile à prendre en main au début (puis l'habitude fait le reste).

Personnellement, **j'utilise LESS plutôt que SASS** sur mes projets, par habitude probablement.<br>
Dans le même temps, j'ai tendance à utiliser le framework [inuit.css (plutôt que Bootstrap)]({% post_url 2013-04-12-decouvrez-inuitcss %}) sur ces projets. Mais inuit.css, c'est du SASS !

Fort heureusement, je ne suis pas le seul à aimer LESS et [Peter Wilson](http://twitter.com/pwcc) s'est efforcé de mettre en place la version LESS du framework. Emballé par l'idée, j'ai rejoint son projet et je maintient aujourd'hui [le port LESS officiel de inuit.css](https://github.com/peterwilsoncc/inuit.css).

Le principe consiste donc à **traduire le framework SASS en LESS**, ce qui conduit à 3 éventualités :

1. Le code SASS est identique au code LESS, c'est le même principe
2. Le code SASS a un équivalent en LESS, il faut alors trouver l'alternative
3. Le code SASS n'a pas d'équivalent en LESS et il faut savoir ruser (ou fermer les yeux)

Voici donc un petit tour sur ces cas de figures, d'après ce que j'ai pu en expérimenter.


## Ce qui est identique en LESS

Dans ce cas, c'est peinard : il n'y a pas grand chose à faire.

En effet, malgré leurs différences, SASS et LESS partagent quelques concepts fondamentaux.

#### Imbrication (nesting)

L'un des principes phares du pré-processeur CSS : l'imbrication des sélecteurs.

Plutôt que de créer des sélecteurs à rallonge afin de spécifier l'héritage, il suffit d'imbriquer les sélecteurs les uns dans les autres. Ainsi, ceci :

{% highlight css %}
.islet {
    margin-top: 24px;

    p {
        color: #BADA55;
        font-weight: bold
    }
}
{% endhighlight %}

Produira le code suivant, dans les deux langages :

{% highlight css %}
.islet {
    margin-top: 24px;
}

.islet p {
    color: #BADA55;
    font-weight: bold
}
{% endhighlight %}

<p class="islet">
    <strong>Attention</strong> - Il arrive souvent que les développeurs, expérimentés ou non, s'emportent avec l'imbrication et en abusent plus que de raison, ce qui a tendance à alourdir inutilement le CSS, un vrai cauchemard !<br><br>
    Gardez donc en tête la <a href="http://thesassway.com/beginner/the-inception-rule">règle de l'inception</a> : <strong>ne jamais aller au delà de 4 niveau d'imbrication</strong>.
</p>

#### Commentaires et compilation

Outre les fonctionnalités qu'ils apportent, les pré-processeurs permettent de disposer d'un code source clair et organisé, tout en produisant un seul fichier CSS compilé (et compressé) pour la production.

Dans cet état d'esprit, SASS et LESS proposent tous deux des commentaires alternatifs qui ne sont pas conservés lors de la compilation. Ainsi donc, ceci :

{% highlight css %}
/**
 * The date/time
 */
.timeline__time {
    position: absolute;
    display: block;

    // The actual inner width is `25% - x`, `x` is the padding
    padding-right: 24px;
    width: 200px;
}
{% endhighlight %}

Produira le code suivant :

{% highlight css %}
/**
 * The date/time
 */
.timeline__time {
    position: absolute;
    display: block;

    padding-right: 24px;
    width: 200px;
}
{% endhighlight %}

Ce qui peut être assez pratique pour placer des commentaires qui n'ont aucune pertinence dans le code compilé, mais ont un sens vis-à-vis du code source.

Notez cependant qu'un fichier compilé en production sera préférentiellement compressé de manière à ne pas inclure les commentaires CSS, à moins de les préserver explicitement (avec `/*! */` en utilisant [YUI compressor](http://yui.github.io/yuicompressor/css.html), par exemple).

#### Imports

Les pré-processeurs permettent également d'importer très simplement d'autres fichiers grâce à `@import`, ce qui permet la mise en place d'une architecture claire et modulaire des fichiers sources. Oui, les pré-processeurs CSS sont les grands amis de l'OOCSS.

Une bonne pratique consiste donc à créer un fichier principal `main.less` / `_main.scss` dont le rôle est d'importer les fichiers dont vous aurez besoin pour produire le fichier final `main.css` :

{% highlight css %}
/**
 * Setup
 */
@import "inuit.css/defaults";
@import "vars";
@import "inuit.css/inuit";


/**
 * She’s all yours, cap’n... Begin importing your stuff here.
 */
@import "ui/base";
@import "ui/layout";

@import "ui/mod-block-list";
@import "ui/mod-helper";

/* etc. */
{% endhighlight %}

Vous noterez que préciser l'extension n'est pas utile, que ce soit en SASS ou en LESS.

<p class="islet">
    <strong>Attention</strong> - Malgré toute ressemblance, la commande <code>@import</code> des pré-processeurs n'a rien à voir avec celle de CSS. En effet, le pré-processeur va importer vos fichiers lors de la compilation afin de produire un fichier CSS unique tandis que l'import en CSS fera télécharger plusieurs fichiers par le navigateur.<br><br>
    Notez également que l'utilisation de <code>@import</code> est <a href="http://browserdiet.com/fr/#prefer-link-over-import">une mauvaise pratique CSS</a>, à éviter donc.
</p>


## Ce qui a un équivalent en LESS

Dans ce cas, il s'agit surtout de connaître la syntaxe et les spécificités de chaque langage, les principes fondamentaux étant les mêmes. Voyons donc ce que nous avons...

#### Variables

SASS comme LESS donnent la possibilité de créer des variables. Et les variables en CSS, c'est quasiment le Saint Graal !

Le concept est assez simple à assimiler, la seule différence entre les deux c'est que SASS utilise des `$` tandis que LESS utilise des `@`. Les goûts et les couleurs...

{% highlight css %}
/* En SASS */
$color: #BADA55;

.header {
    color: $color;
}
{% endhighlight %}

{% highlight css %}
/* En LESS */
@color: #BADA55;

.header {
    color: @color;
}
{% endhighlight %}

Le rendu CSS :

{% highlight css %}
.header {
    color: #BADA55;
}
{% endhighlight %}

#### Mixins

SASS et LESS permettent de créer ce qu'on appelle des **mixins**.

Ce mot barbare signifie tout simplement qu'il est possible de créer des groupes de propriétés pouvant être inclus très simplement ailleurs.

Là encore, c'est surtout la syntaxe qui diffère, le principe est le même :

{% highlight css %}
/* En SASS */
@mixin bordered {
    border-top: dotted 1px black;
    border-bottom: solid 2px black;
}

.header {
    @include bordered;
}
{% endhighlight %}

{% highlight css %}
/* En LESS */
.bordered() {
    border-top: dotted 1px black;
    border-bottom: solid 2px black;
}

.header {
    .bordered();
}
{% endhighlight %}

Ce qui donnera en CSS :

{% highlight css %}
.header {
    border-top: dotted 1px black;
    border-bottom: solid 2px black;
}
{% endhighlight %}

Il est à savoir que les mixins vont plus loin que ça et peuvent prendre en compte des paramètres, des valeurs par défaut, des conditions, etc.

Sans rentrer dans les détails, sachez par exemple que les mixins peuvent prendre en compte **un nombre d'arguments variables**.

Cependant, là où SASS gère parfaitement les différentes valeurs distinctes passées en paramètre, il faut échapper celles de LESS si on veut qu'il n'interprète pas le tout comme une seule grosse variable (qu'il prenne en compte la virgule quoi).

<p class="islet">L'échappement en LESS permet tout simplement de retourner une chaîne de caractère telle quelle grâce à <code>~"ma chaîne"</code>, ce qui servira dans un certain nombre d'astuces (du coup).</p>

Techniquement cela se présente comme ceci :

{% highlight css %}
/* En SASS */
@mixin box-shadow($shadows...) {
    -moz-box-shadow: $shadows;
    -webkit-box-shadow: $shadows;
    box-shadow: $shadows;
}

.shadows {
    @include box-shadow(0 4px 5px #666, 2px 6px 10px #999);
}
{% endhighlight %}

{% highlight css %}
/* En LESS */
.box-shadow(@shadows...) {
    -moz-box-shadow: @shadows;
    -webkit-box-shadow: @shadows;
    box-shadow: @shadows;
}

.shadows {
    .box-shadow(~"0 4px 5px #666, 2px 6px 10px #999");
}
{% endhighlight %}

Ce qui donnera en CSS :

{% highlight css %}
.shadows {
    -moz-box-shadow: 0 4px 5px #666, 2px 6px 10px #999;
    -webkit-box-shadow: 0 4px 5px #666, 2px 6px 10px #999;
    box-shadow: 0 4px 5px #666, 2px 6px 10px #999;
}
{% endhighlight %}

Outre les petites spécificités, les mixins fonctionnent de la même manière.

#### Opérations

Chaque pré-processeur apporte son lot d'opérations mathématiques, très utiles pour réaliser un certain nombre de calculs et d'ajustements qui ne dépendront que de quelques variables, modifiables à souhait.

Les syntaxes sont similaires et assez intuitives (des histoires de `+`, de `-`, etc.). Une bonne pratique consiste à isoler les opérations entre parenthèses afin d'éviter les confusions et potentiels conflits.

Cependant, il faut savoir que LESS considère la première unité spécifiée dans le calcul, ce qui peut conduire à des aberrations (SASS lui ne compilera pas et vous sortira un joli warning) :

{% highlight css %}
.container {
    width: 300px + 2em; // == 302px o_O
}
{% endhighlight %}

En LESS il est donc préférable de **ne pas spécifier les unités des variables** afin de ne pas avoir de mauvaises surprises lors des opérations mathématiques. Il suffit de prendre l'habitude d'appliquer l'unité à la fin, lors de son affectation à une propriété :

{% highlight text %}
@base-font-size: 16;
@base-spacing-unit: 24;

html {
    font-size: (@base-font-size/16)*1em;
    margin-bottom: @base-spacing-unit*1px;
}
{% endhighlight %}

Ce qui donnera :

{% highlight css %}
html {
    font-size: 1em;
    margin-bottom: 24px;
}
{% endhighlight %}

#### Fonctions

Chaque pré-processeur vient avec son lot de fonctions qui permettent de faire un certain nombre de trucs très sympa comme transformer les couleurs, faire des maths, manipuler des chaînes de caractères, etc.

Le plus simple, c'est de vous donner les liens vers les listes exhaustives de chacun :

- [Les fonctions de SASS](http://sass-lang.com/docs/yardoc/Sass/Script/Functions.html)
- [Les fonctions de LESS](http://lesscss.org/#reference)

#### Interpolation

Parfois, il est nécessaire d'inclure des variables au sein de chaines de caractères et de les interpréter tout de même. C'est ce qu'on appelle l'interpolation et SASS comme LESS permettent cela :

{% highlight css %}
/* En SASS */
$base-url: "../images";

.container {
    background-image: url("#{$base-url}/bg.png");
}
{% endhighlight %}

{% highlight css %}
/* En LESS */
@base-url: "../images";

.container {
    background-image: url("@{base-url}/bg.png");
}
{% endhighlight %}

Ce qui donnera :

{% highlight css %}
.container {
    background-image: url("../images/bg.png");
}
{% endhighlight %}

Seule la syntaxe diffère, `#{ $var }` pour SASS et `@{ var }` pour LESS.

Il est également possible d'interpoler des variables dans les sélecteurs, comme nous allons le voir avec les boucles (oui, je travaille mes transitions).

#### Boucles

Techniquement parlant, les deux pré-processeurs permettent de créer des boucles, ce qui peut s'avérer assez utile parfois.

En revanche, si SASS gère nativement la logique de l'itération, LESS n'a rien de tel. En fait, il s'agit véritablement d'une alternative qui consiste à se baser sur les mixins afin de créer le comportement de la boucle.

En LESS, le principe est donc le suivant :

1. On crée un mixin se basant sur un `@index`
2. Le mixin produit le contenu de la boucle tant que `@index > 0`
3. A la fin du mixin, on décrémente `@index`
4. On crée une variante vide du mixin pour arrêter la boucle quand `@index = 0`

Ce qui nous donne les syntaxes suivantes :

{% highlight text %}
/* En SASS */
$index: 5;

@while $index > 0 {
    // On interpole le nom de la classe
    .container-#{$index} {
        z-index: $index;
    }

    // On décrémente l'index
    $index: $index - 1;
}
{% endhighlight %}

{% highlight text %}
/* En LESS */
.loop (@index) when (@index > 0) {
    // On interpole le nom de la classe
    .container-@{index} {
        z-index: @index;
    }

    // Relance la boucle en décrémentant l'index
    .loop (@index - 1);
}

// Arrête la boucle à 0
.loop (0) {}

// Lance la boucle (le mixin)
.loop (5);
{% endhighlight %}

Ce qui donnera, une fois compilé :

{% highlight css %}
.container-5 { z-index: 5; }
.container-4 { z-index: 4; }
.container-3 { z-index: 3; }
.container-2 { z-index: 2; }
.container-1 { z-index: 1; }
{% endhighlight %}

Cette technique est notamment utilisée par Bootstrap [pour générer leurs spans en fonction du nombre de colonnes](https://github.com/twitter/bootstrap/blob/master/less/mixins.less#L577-L595).

#### Extensions et classes silencieuses

En SASS, il est possible d'étendre les propriétés d'une classe à une autre afin de partager un style commun, la seconde classe héritant de la première.

Par exemple, ceci :

{% highlight css %}
.error {
    border: 1px #f00;
    background-color: #fdd;
}

.serious-error {
    @extend .error;
    border-width: 3px;
}
{% endhighlight %}

Donnera le code suivant :

{% highlight css %}
.error, .serious-error {
    border: 1px #f00;
    background-color: #fdd;
}

.serious-error {
    border-width: 3px;
}
{% endhighlight %}

SASS permet également de créer ce que l'on appelle des *classes silencieuses* : il s'agit de définir des classes qui ne seront pas compilées avant d'être explicitement incluses avec `@extend`.

Ainsi, ceci :

{% highlight css %}
a%error {
    color: red;
    font-weight: bold;
}

.notice {
    @extend %error;
}
{% endhighlight %}

Produira le code suivant :

{% highlight css %}
a.notice {
    color: red;
    font-weight: bold;
}
{% endhighlight %}

En LESS, on utilise généralement **les mixins** pour réaliser ce genre d'extension. Selon le même principe que la classe silencieuse, le mixin ne sera pas compilé tant qu'il n'aura pas été inclus quelque part. Le principe est donc sensiblement le même, seule la syntaxe diffère :

{% highlight css %}
.error() {
    a& {
        color: red;
        font-weight: bold;
    }
}

.notice {
    .error();
}
{% endhighlight %}

Cela étant, vous noterez que SASS gère intelligemment l'extension en synthétisant les sélecteurs (`.error, serious-error` dans l'exemple précédent). En LESS, il faudrait le faire à la main.

<p class="islet">
    <strong>Note</strong> - <a href="https://github.com/cloudhead/less.js/blob/master/CHANGELOG.md#140-beta-1--2">La version 1.4 de LESS</a> (actuellement en béta) introduit <code>:extend()</code> qui permettra de gérer les extensions au niveau des sélecteurs. La syntaxe sera donc plus proche du CSS, rappelant celle des pseudo-sélecteurs, ce qui devrait donner quelque chose du genre :
</p>

{% highlight css %}
.error {
    border: 1px #f00;
    background-color: #fdd;
}

.serious-error:extend(.error) {
    border-width: 3px;
}
{% endhighlight %}


#### Variables `!default`

Avec SASS, il est possible de donner une valeur par défaut aux variables, a posteriori. Cela signifie que la valeur sera affectée si et seulement si la variable n'est pas déjà définie.

{% highlight sass %}
$base-font-size:    14px;
$base-font-size:    16px !default;
$base-spacing-unit: 24px !default;

.container {
    font-size:        $base-font-size;
    margin-bottom:    $base-spacing-unit;
}
{% endhighlight %}

{% highlight css %}
.container {
    font-size: 16px;
    margin-bottom: 24px;
}
{% endhighlight %}

L'intérêt de cette technique, c'est de pouvoir définir des variables par défaut au coeur du module développé, tout en permettant à celles-ci d'être **redéfinies de l'extérieur**.

Un exemple concret ? Le coeur du framework d'inuit.css utilise un ensemble de variables par défaut, permettant au développeur d'utiliser ce dernier comme un sous-module : il le met éventuellement à jour mais ne touche jamais au code qu'il y a dedans.

Pour modifier une variable, il doit simplement la redéfinir plus haut, dans son propre fichier de configuration :

{% highlight text %}
.
|-- inuit.css/          # Coeur du framework
|   |-- base/
|   |-- generic/
|   |-- objects/
|   |-- _defaults.scss  # Variables par défaut
|   |-- _inuit.scss     # Fichier setup inuit.css
|
|-- ui/
|-- _vars.scss          # Variables spécifiques
|-- main.scss           # Fichier setup projet
{% endhighlight %}

Il lui suffit de surcharger éventuellement des variables dans `_vars.scss` et d'organiser son `main.scss` ainsi :

{% highlight css %}
/**
 * Setup
 */
@import "vars";
@import "inuit.css/inuit";
{% endhighlight %}

Sans toucher au code de inuit.css, il est donc capable de le configurer entièrement.

**En vérité, vous n'avez pas besoin de cette fonctionnalité en LESS.**

Merci [Chris Snyder](https://twitter.com/KB1RMA) de m'avoir fait remarqué ce point !

Pendant un bon moment je pensais que LESS ne proposait pas d'équivalent aux variables par défaut de SASS, et qu'il fallait trouver d'habiles hacks pour contourner le problème.

En réalité, les variables fonctionnent différement avec LESS car le pré-processeur fait du [lazy loading](http://lesscss.org/features/#variables-feature-lazy-loading). Ce qui signifie que les variables peuvent être utilisées **avant** d'être définies.

Ainsi, vous pouvez parfaitement surcharger les variables plus tard dans votre code. Ce qui est équivalent à avoir des variables par défaut :

{% highlight css %}
@base-font-size:    14px;
@base-spacing-unit: 24px;

.container {
    font-size:        @base-font-size;
    margin-bottom:    @base-spacing-unit;
}

/* … plus loin dans votre code */
@base-font-size:    16px;
{% endhighlight %}

Donnera le même résultat :

{% highlight css %}
.container {
    font-size: 16px;
    margin-bottom: 24px;
}
{% endhighlight %}

De cette façon, nous pouvons faire la même chose avec inuit.css et tranquillement utiliser des variables (par défaut) dans le framework tout en laissant la possibilité aux développeurs de les surcharger ensuite.

{% highlight css %}
/**
 * Setup
 */
@import "inuit.css/inuit";
@import "vars";
{% endhighlight %}


## Ce qui ne peut être reproduit en LESS

Voici donc une liste non exhaustive de ce dont SASS est capable sans qu'il n'existe de véritable alternative en LESS (éventuellement des ruses de sioux).

#### Bloc de contenu dans un mixin

Avec SASS il est possible de passer tout un bloc de contenu au sein d'un mixin avec la variable `@content`. Concrètement, ceci :

{% highlight text %}
@mixin apply-to-ie6-only {
    *html {
        @content;
    }
}

@include apply-to-ie6-only {
    #logo {
        background-image: url(/logo.gif);
    }
}
{% endhighlight %}

Se compile ainsi :

{% highlight css %}
*html #logo {
    background-image: url(/logo.gif);
}
{% endhighlight %}

D'autant que je sache, il n'existe pas d'équivalent en LESS (désolé).

#### Variabiliser les propriétés

En SASS, il est également possible d'utiliser l'interpolation pour variabiliser une propriété. C'est extrêmement utile pour créer des mixins concis et puissants. Ainsi, ceci :

{% highlight text %}
@mixin border-badass($side) {
    border-#{$side}: 1px #BADA55 solid;
}

.container {
    @include border-badass(left);
}
{% endhighlight %}

Donnera par exemple :

{% highlight css %}
.container {
    border-left: 1px #BADA55 solid;
}
{% endhighlight %}

**En LESS en revanche, il s'agira de faire un mixin par propriété**, ce qui complique énormément la tâche pour ce genre de cas de figure. Il faut donc apprendre à s'en passer...

...

... bon, en réalité, il existe une bidouille qui permet d'obtenir le même résultat, mais qui n'a rien de très propre. A utiliser en votre âme et conscience donc !

Le principe se base sur le fait que les navigateurs ignorent les propriétés inconnues en CSS.

Ainsi, `hack: 1;` ne sera pas très valide, mais ne sera pas considéré. Sachant cela, et en le combinant avec l'interpolation LESS qui peut se faire sur les valeurs, on peut imaginer le code suivant :

{% highlight text %}
.border-badass(@side) {
    hack: 1 ~"; border-@{side}: 1px #BADA55 solid";
}

.container {
    .border-badass(left);
}
{% endhighlight %}

Qui donnera :

{% highlight css %}
.container {
    hack: 1;
    border-left: 1px #BADA55 solid;
}
{% endhighlight %}

Techniquement, ça marche.

De là à l'utiliser, tout dépend de votre besoin je dirais. On peut imaginer que vous traitiez automatiquement votre CSS compilé lors du build pour supprimer les occurrences à `hack:1;` par exemple. On peut aussi imaginer que LESS intègrera cette fonctionnalité à l'avenir.

Sinon, gardez en tête que c'est un peu sale (quand même).


## Pour finir

Voici donc les principales similarités et différences qui existent entre SASS et LESS, d'après mon expérience. Convertir un projet SASS en LESS n'a rien de bien sorcier en soit, à condition de connaître et prendre garde aux spécificités de chaque langage.

D'un point de vue objectif, SASS est plus puissant que LESS et dispose de véritables notions de programmation qui peuvent en séduire plus d'un. Cependant, sa syntaxe et son esprit s'éloignent d'autant, LESS étant plus "naturel" et proche du langage CSS selon moi.

C'est donc plutôt **une question de préférence et de confort** que vous aurez à faire dans la plupart des cas. Le principal, c'est d'avoir fait le pas et d'utiliser un pré-processeur pour simplifier le développement et faciliter la maintenance de votre CSS : vous vous direz merci tôt ou tard !

Pour ceux qui veulent jouer et tester tout ceci en ligne, voici :

- [Sass-try](http://sass-lang.com/try.html), pour le SASS
- [Less2css](http://less2css.org/), pour le LESS

Si vous voyez des ajouts, des erreurs ou avez des remarques à émettre sur ce post, n'hésitez pas.

Plop !
