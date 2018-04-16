---
layout: post
robots: index,follow
published: true
comments: true

tags: [css, smacss, organisation]
icon: css

title: Tombez pour SMACSS
description: Petit tour d'horizon sur ces guidelines qui feront de vous un bûcheron du CSS, un vrai. Timber !
---

## TL;DR

**SMACSS** est un ensemble de conseils et de lignes de conduite élaborés par [Jonathan Snoovvk](https://twitter.com/snookca) et dont le but est de vous permettre d'organiser votre CSS de manière claire et intelligente.

Le premier principe réside dans **la catégorisation** : on distingue et regroupe les règles CSS par affinité logique afin de structurer son code (*base, layout, module, state, theme*).

Le second principe relève de **la convention de nommage** : ne pas utiliser des ID quand une classe fait très bien l'affaire, nommer les classes de manière à faire ressortir la logique qui s'y cache, ...

Le troisième principe consiste à **découpler le HTML du CSS** : garder chaque module indépendant du contexte HTML dans lequel il se trouve, utiliser les [sélecteurs d'enfants](http://www.yoyodesign.org/doc/w3c/css2/selector.html#child-selectors) à bon escient, ...

Avec ces 3 principes, SMACSS vous permet de poser des bases solides pour un CSS de qualité, made in Canada !

## Principe et intérêts

Il arrive bien (trop) souvent que l'organisation du CSS d'un projet web soit vraiment, vraiment mauvaise.

La raison à cela étant que les gens considèrent que [le CSS c'est facile](http://www.veronique-bouvier.com/css-cest-facile-par-hugo-giraudel/) : des sélecteurs, des attributs, des valeurs et roule ma poule ! Si bien que la plupart des projets sur lesquels j'ai travaillé tendent à organiser leur CSS de manière "naturelle", à savoir :

- un éventuel reset CSS ou autre framework de base,
- un fichier CSS principal pour tout ce qui est commun sur l'ensemble du site,
- un fichier CSS spécifique par page lorsqu'il est nécessaire d'ajouter du style,
- d'autres fichiers éventuels plus ou moins pertinents ("le CSS du carousel jQuery qu'on a choppé sur le web" en fait partie)

Les problèmes sont alors présents et de plus en plus évidents à mesure que le projet évolue :

- on ne livre pas un seul et unique fichier CSS compressé par page, [comme il le faudrait](http://browserdiet.com/#combine-css)
- on duplique les propriétés et le code qui va avec
- on ne sait plus où sont rangées les règles correspondant au formulaire X
- on galère pour maintenir le CSS, on préfère rajouter des règles les unes par dessus les autres
- on se demande où placer cette règle qui apparaît sur quelques pages... mais pas toutes
- on a oublié de racheter du café et c'est dimanche
- etc.

Bref, c'est le bordel dans votre CSS !

<div class="illustration">
    <img alt="Your CSS is a MESS" title="Your CSS is a MESS" src="/assets/img/css/your-css-is-a-mess.jpg">
</div>

La méthode **Scalable and Modular Architecture for CSS (SMACSS)** a pour but de venir organiser tout ça selon un ensemble de lignes de conduite assez simples à appréhender.

Ce n'est pas un framework au sens rigide du terme, mais des bonnes pratiques pour garder un code clairement architecturé et aisé à maintenir.

La philosophie **SMACSS** repose sur ces 3 grands principes que je vais détailler par la suite :

<div class="illustration">
    <img src="/assets/img/css/smacss-principles.jpg" alt="Les principes de SMACSS" title="Les principes de SMACSS">
    Les 3 grands principes de SMACSS
</div>


## Catégoriser son CSS

La première considération de SMACSS consiste à **regrouper les règles CSS selon des catégories** qui vont définir l'organisation du code.

La catégorisation est le principe central de SMACSS. Le fait de catégoriser les règles permet de distinguer des modèles type et de définir des bonnes pratiques pour chacunes de ces catégories.

On distingue 5 types de catégories :

1. *Base*
2. *Layout*
3. *Module*
4. *State*
5. *Theme*

#### Base

Il s'agit des éléments par défaut tels qu'ils sont définis sur l'ensemble du site. Ce sont les règles de style "de base" (sans blague).

Bien généralement il s'agit des éléments HTML basiques.<br>
Mais on peut également y retrouver des sélecteurs descendants (`h1 em`), des sélecteurs d'enfants (`ul > li`) ou même des pseudo-classes (`a:hover`).

**Cette catégorie ne doit contenir ni classe, ni identifiant !**<br>
**Vous ne devez pas utiliser `!important` dans cette catégorie.**

{% highlight css %}
/* Exemple des styles de base de ce blog */
body {
    background-color: #000;
    background-image: url('/assets/img/background.png');
    color: #FFF;
    font-family: 'Roboto', sans-serif;
}

h1 {
    color: #F44;
}

h1, h2, h3 {
    font-family: "Snippet", sans-serif;
}

h1 > span, h2 > span, h3 > span {
    color: #333;
    font-weight: normal;
}

em {
    font-style: normal;
    font-family: "Snippet", sans-serif;
}
{% endhighlight %}

<p class="islet">
    Les <strong>resets CSS</strong> font partie de cette catégorie.
</p>

#### Layout

Il s'agit du découpage de l'architecture de votre site en sections principales.

Généralement, il s'agit de sélecteurs simples, descendants ou d'enfants, voire de classes ou d'identifiants (pour le coup, c'est bien le seul endroit où l'usage d'ID est tolérable).

**Vous ne devez pas utiliser `!important` dans cette catégorie.**

<div class="illustration">
    <img src="/assets/img/css/smacss-layout.jpg" alt="La couche layout" title="La couche layout en SMACSS">
    Découpage du site en sections majeures pour le layout
</div>

{% highlight css %}
/* Exemple des styles layout de ce blog */
.container {
    margin-right: auto;
    margin-left: auto;
    padding: 0 20px;
    max-width: 1050px;
}

header > img, header > nav {
    line-height: 80px;
}

footer {
    font-size: 12px;
    font-size: 0.75rem;
    line-height: 2;

    padding-top: 10px;
    font-weight: 100;
}
{% endhighlight %}

<p class="islet">
    <strong>Attention à ne pas confondre le <em>layout</em> et les <em>modules</em> !</strong><br><br>
    Le <em>layout</em> correspond aux sections majeures de votre site, ce sont les grandes parties de votre template (le header, le footer, la sidebar, ...).<br>
    Les <em>modules</em> correspondent aux sections mineures qui peuvent apparaître sur votre site (menu de navigation, formulaire de connexion, ...). Le <em>layout</em> peut contenir un ou plusieurs <em>modules</em>.
</p>

#### Module

Un module est une section mineure, un composant autonome de la page.

Partir sur une structure modulaire est une bonne pratique à appliquer pour créer et maintenir un CSS flexible et réutilisable. A titre d'exemple, les modules les plus classiques sont certainement la navigation et les boutons.

**Vous ne devez pas utiliser d'ID ou `!important` dans cette catégorie.**

<div class="illustration">
    <img src="/assets/img/css/smacss-module.jpg" alt="La couche module" title="La couche module en SMACSS">
    Mise en lumière des modules de la page
</div>

{% highlight css %}
/* Exemple des styles du module block-list de ce blog */
.block-list {
    list-style: none;
    margin-left: 0;
}

.block-list > li {
    padding: 12px;
    border: 0 dashed #DDD;
    border-bottom-width: 1px;
}

.block-list > li:last-child {
    border: none;
}

.block-list__link {
    display: block;
    padding: 12px;
    margin: -12px;
}
{% endhighlight %}

Le plus complexe dans l'élaboration des modules est certainement le fait de devoir prendre garde à ce qu'ils soient modulaires, justement.

Un module doit être **un bloc autonome** et la structure des sélecteurs doit refléter cela. Si vous commencez à ajouter un contexte spécifique dans votre CSS pour styliser votre module "en fonction de là où il se trouve", vous passez à côté de la plaque !

Il faut penser modularité et réusabilité.

{% highlight css %}
header .block-list { ... } /* Mauvaise idée =( */
.block-list-fit { ... }    /* Bien mieux ! */
{% endhighlight %}

{% highlight html %}
<!-- Utilisation concrète -->
<header>
    <ul class="block-list block-list-fit">
        <li>Lorem ipsum dolor sit amet</li>
        <li>Possimus est fugit reiciendis</li>
        <li>Nostrum, ducimus, temporibus</li>
    </ul>
</header>
{% endhighlight %}

Ainsi, rien ne vous empêche d'appliquer le modificateur `.block-list-fit` ailleurs, ou de le retirer si besoin. C'est un Lego qui apporte sa pierre à l'édifice de votre design.

#### State

Il s'agit de classes qui viennent définir un état particulier dans lequel se trouvent vos éléments.

Généralement, une règle qui se trouve dans cette catégorie correspond à une simple classe CSS.

**C'est la seule catégorie où l'usage de `!important` peut être toléré, voire recommandé.**

En effet, ce genre de règles déterminent **un état final** du design, qui doit s'appliquer quoiqu'il advienne. Si votre code est propre, vous ne devriez pas avoir deux états s'appliquant sur le même élément et modifiant les mêmes attributs (sinon, vous avez un petit soucis de logique).

<div class="illustration">
    <img src="/assets/img/css/smacss-state.jpg" alt="La couche state" title="La couche state en SMACSS">
    Exemple des différents états possibles d'un bouton
</div>

{% highlight css %}
/* Exemple des styles state d'un projet */
.is-block {
    display: block !important;
}

.is-dragged  {
    color: rgb(0, 85, 128) !important;
    background-color: rgb(217, 237, 247) !important;
}
{% endhighlight %}

Bien souvent, les états correspondent à des interactions avec l'utilisateur et ont des dépendances avec Javascript.

En effet, quoi de plus simple que de rajouter et d'enlever une classe `.is-loading` sur la page pour faire un retour à l'utilisateur du traitement de sa requête ? Le JS n'en est que plus simple :

{% highlight javascript %}
// Exemple d'utilisation lors d'un traitement de formulaire
$('form#update-quantity').find('input').change(function() {
    // Ajoute le loading sur la page (calcul en cours)
    $('#content').addClass('is-loading');

    // Requête AJAX pour mettre directement à jour le formulaire
    $.ajax({
        url: "/cart/update/" + ref + "/" + quantity,
        dataType: "json",
        success: function(data) {
            // Retire le loading (fin du calcul)
            $('#content').removeClass('is-loading');

            // ...
        }
    });
});
{% endhighlight %}

<div class="illustration visuallyhidden--palm">
    <iframe width="100%" height="100" src="http://jsfiddle.net/espeon/dt58C/embedded/result" allowfullscreen="allowfullscreen" frameborder="0">Exemple du loading sur la page</iframe>
    Exemple de l'utilisation de <code>.is-loading</code> lors de la modification d'un champ
</div>

#### Theme

Dans certains cas, il se peut qu'un projet nécessite l'élaboration de différents thèmes pouvant s'interchanger en fonction des choix de l'utilisateur ou de l'équipe.

Dans ces cas, on peut **découpler l'apparence de la structure** des modules (notamment) afin de pouvoir switcher facilement entre ces différents designs.

Il s'agit donc généralement de redéfinir les styles de *base*, de *layout*, de *module* ou même de *state* en indiquant de manière claire quelles sont les règles qui définissent le thème et quelles sont celles qui n'en font pas partie.

Bien souvent, séparer clairement ces règles en les regroupant dans un fichier CSS relatif au thème suffit à montrer cette distinction.

{% highlight css %}
/* Exemple des styles d'un theme d'un projet */
body {
    font-family: "Roboto", sans-serif;
}

header {
    background-color: #33F;
    color: #A66105;
}

.block-list > li{
    border: 0 dashed #00D;
}

/* Ou bien si le thème est interchangeable, on peut envisager ceci */
.theme-ocean {
    font-family: "Roboto", sans-serif;
}

.theme-ocean header {
    background-color: #33F;
    color: #A66105;
}

.theme-ocean .block-list > li{
    border: 0 dashed #00D;
}
{% endhighlight %}

#### Bonus : Shame

Ce point ne fait pas véritablement partie de **SMACSS**, mais relève d'une idée/blague de Harry Roberts [au détour d'un post](http://csswizardry.com/2013/04/shame-css/). Tant qu'à y aller dans l'organisation du code, je trouvais pertinent de rajouter ce dernier point.

L'idée c'est que, dans la vraie vie, il arrive que les développeurs n'aient pas le temps de coder bien proprement une fonctionnalité de dernière minute ou bien qu'il soit nécessaire de rapidement corriger un problème sans qu'on n'ait vraiment eu le temps de comprendre ce qui n'allait pas.

Ainsi, en CSS comme ailleurs, il arrive de devoir faire un petit correctif rapide à grand coup de `overflow:hidden;` et autres `!important`.

Le problème, c'est que bien souvent les développeurs ne prennent pas (n'ont pas) le temps de venir faire le refactoring qui s'impose, histoire de nettoyer tout ça. Et ainsi le CSS se remplit de petits hacks divers et variés, dont on oublie la raison voire l'existence, et qui viennent saloper tout le travail (je vous raconte pas quand y'a plus d'un développeur sur le projet).

**La solution** est donc d'isoler ces petites magouilles dans un seul et même fichier : `shame.css`.

Le workflow est le suivant :

<ol>
    <li>Si la règle CSS que l'on va rajouter est un hack, on la place dans <code>shame.css</code></li>
    <li>On commente le hack le mieux possible
        <ul>
            <li>à quel code cela se réfère-t-il ?</li>
            <li>pourquoi c'était nécessaire ?</li>
            <li>comment ça fonctionne ?</li>
            <li>comment on pourrait le faire proprement en ayant plus de temps ?</li>
        </ul>
    </li>
    <li>On ne blâme pas le développeur s'il a correctement expliqué son hack</li>
    <li>Quand on a du temps disponible, on vient nettoyer <code>shame.css</code></li>
</ol>

Voici un exemple de hack (librement inspiré de celui de Harry) :

{% highlight css %}
/**
 * Nav specificity fix.
 *
 * Quelqu'un a utilisé un ID dans le header (`#header a{}`)
 * qui l'emportesur le sélecteur de nav (`.site-nav a{}`).
 * Utilisation de !important pour le surcharger d'ici qu'on ait
 * le temps derefactor le header.
 */
.site-nav a{
    color: #BADA55 !important;
}
{% endhighlight %}

Si vous faîtes les choses correctement, vous devrez inclure ce fichier **à la fin de votre CSS compressé final**.


## Nommer ses classes

En plus de la catégorisation des règles CSS et de la nouvelle structure que cela donne à notre code, il peut être particulièrement utile de convenir de certaines **conventions de nommage** au sein du projet.

Sans aller chercher très loin, c'est apporter une certaine rigueur et intelligence au code qui évitera aux futurs développeurs de venir se casser les dents sur des classes aux noms aléatoires.

Par exemple, `.titre-bleu` fait partie de ces fausses bonnes idées de début de projet. Si effectivement il s'agit de mettre le titre en bleu avec cette classe, qu'en sera-t-il dans 1 an lorsque finalement il aura été décrété que le rouge était plus tendance ? Changer le CSS ne fera que relever l'absurdité des ces `.titre-bleu` qui sont finalement rouges... Il faudra donc se taper toutes les occurences de cette classe dans le projet pour aller corriger le tir !

D'un autre côté, si le choix avait été porté sur `.titre-festif` (ou quelque chose d'aussi sémantique), alors il n'y aurait jamais eu de problème. C'est un concept de base qu'il faut bien assimiler si on veut éviter les erreurs qui coûtent (du temps, donc de l'argent).

D'une manière générale, **la convention de nommage doit clarifier les intentions**.

Voici quelques pistes :

- pour les *modules*, il est judicieux que les classes partagent la même racine correspondant au module en question. Des projets comme *Bootstrap* [adoptent d'ailleurs cette convention](https://github.com/twitter/bootstrap/blob/master/less/buttons.less).

{% highlight css %}
.btn {}
.btn-search {}
.btn-small {}
.btn-large {}
/* ... */
{% endhighlight %}

- pour *state*, il s'agit d'un état logique dans lequel se trouve un élément. Ainsi, il n'est pas bête que chaque classe transmettent cette intention avec `.is-` par exemple :

{% highlight css %}
.is-loading {}
.is-collapsed {}

/* et pour les états relatifs à un module... */
.is-btn-active {}
.is-btn-disabled {}
{% endhighlight %}

- pour les *themes* donc, il est envisageable de créer une sorte de namespace explicite, notamment s'il est possible de switcher entre les différents thèmes proposés :

{% highlight css %}
.theme-ocean {}
.theme-silver {}
/* ... */
{% endhighlight %}


## Découpler le HTML du CSS

Ce point recoupe de manière assez explicite les bonnes pratiques d'OOCSS [que j'avais introduites il y a quelque temps]({% post_url 2013-05-08-plongee-au-coeur-de-oocss %}).

Le principe est donc le même : **le CSS doit être indépendant du contexte HTML dans lequel les éléments se trouvent**.

C'est la condition *sine qua none* d'un code flexible, modulaire et réutilisable. C'est d'autant plus vrai quand vous pensez aux modules qui constituent une bonne partie de votre CSS une fois les bases et le layout posés.

De plus, faîtes en sorte que vos modules aient **une structure prédictible** ! Pour cela, utilisez les sélecteurs d'enfants et ne soyez pas trop génériques, au risque de ne pas envisager tous les cas de figure.

Enfin, **si le HTML n'est pas prédictible, créez une classe !**

#### Des modules prédictibles

Pour reprendre l'exemple employé par Jonathan Snoovvk, voici un code à problème :

{% highlight html %}
<!-- Un menu de navigation classique -->
<ul class="nav">
    <li><a href="/">Accueil</a></li>
    <li><a href="/products">Nos produits</a></li>
    <li><a href="/contact">Contactez-nois</a></li>
</ul>
{% endhighlight %}

{% highlight css %}
.nav {
    margin: 0;
    padding: 0;
    list-style: none;
}

.nav li {
    float: left;
}

.nav li a {
    display: block;
    padding: 5px 10px;
    background-color: blue;
}
{% endhighlight %}

C'est un cas de figure tout ce qu'il y a de plus classique sur un projet et, jusqu'à présent, ça fonctionnait pas trop mal.

Seulement voilà, le projet évolue et le menu se développe, donnant quelque chose d'un peu plus complexe :

{% highlight html %}
<!-- Un menu de navigation un peu plus cossu -->
<ul class="nav">
    <li><a href="/">Accueil</a></li>
    <li>
        <a href="/products">Nos produits</a>
        <ul>
            <li><a href="/products/shoes">Chaussures</a></li>
            <li><a href="/products/jackets">Blousons</a></li>
        </ul>
    </li>
    <li><a href="/contact">Contactez-nois</a></li>
</ul>
{% endhighlight %}

Et là, c'est le drame...

Le code précédent n'avait pas envisagé cette possibilité et voilà que le menu imbriqué hérite d'un design non désiré : le sous-menu est affecté par le `float: left;` qu'il faut à présent annuler (et pis le client, il voulait le sous-menu en rouge, paraît que c'est tendance).

Une fausse bonne idée (mais naturelle) pour corriger cela consiste à créer de nouvelles règles plus spécifiques :

{% highlight css %}
.nav {
    margin: 0;
    padding: 0;
    list-style: none;
}

.nav li {
    float: left;
}

.nav li a {
    display: block;
    padding: 5px 10px;
    background-color: blue;
}

.nav li li {
    float: none;
}

.nav li li a {
    padding: 2px;
    background-color: red;
}
{% endhighlight %}

Et c'est ainsi que votre CSS devient petit à petit un joyeux bordel...

Avec SMACSS, vous auriez retenu le 3e principe et pris garde à ce que la structure de votre module soit prédictible :

{% highlight html %}
<!-- Un menu de navigation un peu plus cossu -->
<ul class="nav">
    <li><a href="/">Accueil</a></li>
    <li>
        <a href="/products">Nos produits</a>
        <ul class="nav nav-imbricated">
            <li><a href="/products/shoes">Chaussures</a></li>
            <li><a href="/products/jackets">Blousons</a></li>
        </ul>
    </li>
    <li><a href="/contact">Contactez-nois</a></li>
</ul>
{% endhighlight %}

{% highlight css %}
.nav {
    margin: 0;
    padding: 0;
    list-style: none;
}

.nav > li {
    float: left;
}

.nav > li > a {
    display: block;
    padding: 5px 10px;
    background-color: blue;
}

.nav-imbricated > li > a {
    padding: 2px;
    background-color: red;
}
{% endhighlight %}

Plus de problème de design du sous-menu : il suffit de lui appliquer une variante du menu de navigation. Plus besoin de devoir annuler le `float: left;` non désiré non plus, c'est goody !

#### Dans le doute, créez une classe

Parfois, il s'avère que la structure d'un module soit flexible et qu'il puisse contenir tout un tas d'éléments différents. Il serait alors absurde de vouloir envisager toutes les possibilités ainsi :

{% highlight css %}
.media {
    overflow:hidden;
}

.media > div {
    float:left;
    margin-right:20px;
}

.media > div img, .media > p img {
    display:block;
}

.media > p, .media > ul, .media > div {
    overflow:hidden;
}
{% endhighlight %}

La solution à ce genre de problème consiste à créer une classe afin de définir la structure, quelque soit l'élément qui sera utilisé pour la sémantique HTML :

{% highlight css %}
.media {
    overflow:hidden;
}

.media-img {
    float:left;
    margin-right:20px;
}

.media-img img {
    display:block;
}

.media-body {
    overflow:hidden;
}
{% endhighlight %}

Ce qui peut être à nouveau simplifié et présente les bases du **media object** :

{% highlight css %}
.media, .media-body { overflow:hidden;}
.media-img          { float:left; margin-right:20px;}
.media-img img      { display:block;}
{% endhighlight %}

C'est ce que l'on appelle découpler le HTML du CSS \o/


## Démonstration par l'exemple

Pour terminer sur la question, je me propose de vous présenter comment je met en application SMACSS dans l'organisation de mon CSS.

Prenons l'exemple de ce blog ([dont le code est disponible sur Github](https://github.com/nicoespeon/nicoespeon.github.io)). L'architecture du CSS se présente de la manière suivante (dossier `/assets/less`) :

{% highlight text %}
.
|-- inuit.css/                  # Framework inuit.css
|
|-- ui/
|   |-- base.less               # Éléments de base
|   |-- layout.less             # Structure globale
|   |-- mod-block-list.less     # Module block-list
|   |-- mod-image.less          # Module image
|   |-- mod-island.less         # Module island
|   |-- mod-pagination.less     # Module pagination
|   (...)
|   |-- (state.less)            # Design des états possibles
|
|-- vars.less                   # Variables globales LESS
|-- nicoespeon.less             # Fichier de setup
{% endhighlight %}

En pratique, c'est le fichier [`nicoespeon.less`](https://github.com/nicoespeon/nicoespeon.github.io/blob/develop/assets/less/nicoespeon.less) qui est interprété et qui s'occupe d'importer les fichiers utilisés dans le bon ordre, puis de compiler tout ça et de générer un seul et unique fichier CSS compressé, rangé dans `/assets/css/nicoespeon.css`.

Personnellement, j'ai choisi de préfixer les noms de chaque module par `mod-`. J'aurais également pu les placer dans un dossier `modules/`, tout comme inuit.css dispose du dossier `objects/` qui remplit ni plus ni moins le même rôle.

C'est donc **un choix personnel**, et là est toute la question : à vous de prendre la philosophie et de l'adapter à votre réalité, à vos besoins... et de vous y tenir !


## Conclusion

Voilà pour cette présentation de la philosophie SMACSS !

Bien évidemment, je vous suggère d'aller faire un tour du côté du site officiel :

<a href="http://smacss.com" class="illustration">
    <img src="/assets/img/css/get-smacked.jpg" alt="Get Smacked" title="Get Smacked">
</a>


Vous y trouverez l'essentiel du livre gratuitement. Vous pourrez également vous procurer le bouquin pour $15-20 si le cœur vous en dit (et disposer de conseils plus avancées sur la question).

Les images utilisées dans cet article sont tirées de "[Your CSS is a mess](https://speakerdeck.com/snookca/your)", slideshow de Jonathan Snoovvk que je vous recommande.

Vous pouvez également jeter un oeil à [son intervention à la Smashing Conference 2012](http://vimeo.com/61755493).

Enfin, si vous avez des réactions à propos de cet article je vous en prie : faîtes donc ci-dessous !

Plop !
