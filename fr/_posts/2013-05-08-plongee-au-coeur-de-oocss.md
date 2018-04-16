---
layout: post
robots: index,follow
published: true
comments: true

tags: [css, oocss]
icon: css

title: Plongée au coeur de l'OOCSS
description: OOCSS - qu'est-ce-que c'est, pourquoi c'est bien et comment ça marche.
---

# TL;DR

"C'est comme j'te dis tu fais du CSS et tu te base sur le contexte ! Non mais all'OOCSS ! J'sais pas vous m'recevez ?" - *Margina Remattia, OOCSS Evangelist*

# OOCSS, c'est quoi ?

Considérons un projet web qui débute : une start-up lambda qui se rêve de développer LA web-application incontournable du web de demain. La start-up veut bien faire et choisi judicieusement les technos, frameworks et environnements... Mais quoiqu'il en soit, le rendu front-end sera le même : *HTML, CSS et Javascript*.

Seulement voilà, si l'ensemble de l'application bénéficiera sûrement des avantages de quelques frameworks, jeter un coup d'oeil du côté de la feuille de style donnera probablement quelque chose dans ce goût là (avec ou sans pré-processeur) :

{% highlight css %}
#generateur-formulaire {
    width: 760px;
    margin: auto;
}

#generateur-formulaire label {
    font-weight: bold;
    font-size: 12px;
    /* ... */
}

#generateur-formulaire label.champ-titre {
    font-weight: normal;
    font-size: 11px;
    /* ... */
}

#generateur-formulaire textarea {
  width: 350px;
}

#generateur-formulaire .big textarea {
  width: 500px;
}

/* tout plein de CSS */
{% endhighlight %}

Or ce code va poser un certain nombre de problèmes avec le temps :

- **Manque de flexibilité**, il ne peut s'appliquer qu'aux éléments contenus dans le formulaire portant l'identifiant `#generateur-formulaire`. Ca peut paraître pertinent au début, mais quid si demain une autre page du site présente deux formulaires à l'apparence similaire ?

- **Trop de spécificité**, il oblige à accentuer toujours plus la spécificité des sélecteurs si l'on souhaite rajouter un cas particulier (`label.champ-titre` ou `.big textarea` par exemple).

- **Trop compliqué**, sa maintenance nécessite d'être **un expert** et de connaître l'architecture de chaque page pour décortiquer tout ce bazar. D'autant que cela promet de grossir encore et encore à mesure que le site se développe.

Ajoutez à cela une organisation plus ou moins claire des fichiers CSS et vous obtenez un joli code spaghetti propice aux erreurs et à la duplication de code, surtout si d'autres développeurs se rajoutent au projet par la suite.

Cette extrême dépendance à la structure HTML rend le code **particulièrement fragile** : même avec le code le plus propre qu'il soit, une simple maladresse d'un non-expert peut le ruiner complètement.

Bref, autant de signes de non-maturité qui risquent, à la longue, de lui compliquer la tâche à notre start-up, lui promettant de longues nuits blanches de debuggage et de refactoring.

Finalement, **le soucis de ce code réside dans la relation 1:1** que le CSS entretient avec le nombre de blocs, de pages et de modules du site. A mesure que le site grossit, le CSS grossit tout autant. Ca demande du temps de développement, donc de l'argent... On a vu mieux en terme de [ROI](http://fr.wikipedia.org/wiki/Retour_sur_investissement) !

<div class="illustration">
    <img alt="Your CSS is a MESS" title="Your CSS is a MESS" src="/assets/img/css/your-css-is-a-mess.jpg">
    Librement inspiré par <a href="https://speakerdeck.com/snookca/your">Jonathan Snoovvk</a> =)
</div>

L'**Object Oriented CSS (OOCSS)** vient apporter sa solution à tous ces problèmes. Il ne s'agit pas d'un pré-processeur, ni même d'un nouveau langage, mais plutôt d'une *philosphie de code*. C'est un ensemble de bonnes pratiques, de règles et de conseils.

L'OOCSS repose sur 2 grands principes :

1. **Séparation de la structure et de l'apparence**<br>
2. **Séparation du conteneur et du contenu**

#### 1. Séparation de la structure et de l'apparence

Les éléments d'un site web ont généralement un aspect visuel qui se répètent dans différents contextes (couleurs, police, bordures, bref... charte graphique). C'est **l'apparence**.

Dans le même temps, un certain nombre de propriétés "invisibles" sont également répétés (dimensions des blocs, overflow, etc.). C'est **la structure**.

Le fait de distinguer les deux permet de créer des éléments **ré-utilisables** à souhait sur d'autres éléments partageant les mêmes propriétés : on parle alors d'**objets** (ce qui devrait sonner familier aux développeurs back-end, soit dit en passant).

#### 2. Séparation du conteneur et du contenu

On parle ici de ne pas limiter bêtement le style d'un élément (le **contenu**) au contexte dans lequel il se trouve (le **conteneur**).

Si l'on stylise les titres, pourquoi se limiter à ceux du `<header>`, simplement parce-que c'est le seul titre actuel ? Il y a même de fortes chances, si notre design est un tant soit peu homogène, que les titres se comportent sensiblement de la même façon sur l'ensemble des pages du site, question d'ergonomie.

C'est encore plus vrai pour les modules.

# OOCSS, pourquoi c'est bien ?

#### Les 10 bonnes pratiques

Voici la liste des 10 bonnes pratiques qui forment l'esprit de l'OOCSS :

1. **Créer une bibliothèque par composant**<br>
Chaque composant (bouton, tableau, lien, image, clearfix, etc.) doit être tel un Lego = combinable et réutilisable à souhait.

2. **Utiliser des styles sémantiques et consistants**<br>
Le style d'un nouvel élément créé en HTML doit être prévisible.

3. **Designer des modules transparents**<br>
Le module est le cadre conteneur pouvant être utilisé avec n'importe quel contenu.

4. **Être flexible**<br>
Les hauteurs et largeurs doivent être extensibles et s'adapter ([RWD](http://fr.wikipedia.org/wiki/Responsive_Web_Design) inside).

5. **Apprendre à aimer les grilles**<br>
Les grilles permettent de contrôler la largeur, la hauteur se gère par le contenu.

6. **Minimiser les sélecteurs**<br>
S'en tenir à une spécificité `[0-0-1-0]` permet [un meilleur contrôle sur les sélecteurs](http://nicoespeon.com/fr/2013/05/optimiser-selecteurs-css-vs-js#bewaaaaare_la_spcificit_).

7. **Séparer la structure de l'apparence**<br>
Il faut distinguer les deux, c'est un principe fondamental de l'OOCSS. Elaborez des objets abstraits pour la structure des blocs et des classes pour habiller ces blocs, indépendamment de leur nature.

8. **Séparer le conteneur du contenu**<br>
Il faut distinguer les deux, c'est un principe fondamental de l'OOCSS. Construisez des **relations 1:n** en décomposant conteneur et contenu.

9. **Étendre les objets en appliquant de multiples classes aux éléments**
Les classes/objets sont autant de Legos qui s'assemblent pour obtenir le résultat désiré.

10. **Utiliser les resets et les fonts YUI**<br>
C'est un choix relatif du [framework OOCSS](https://github.com/stubbornella/oocss/wiki).

<p class="islet">
    <strong>Les Legos d'abord</strong> - Une bonne pratique consiste également à styliser les pages individuelles après que tous les composants basiques aient étés créés.
</p>

#### Les 9 pièges à éviter

Voici la liste des 9 erreurs **à bannir** selon l'esprit OOCSS :

1. **Créer des styles dépendant du contexte**<br>
Il n'y a rien de moins flexible qu'un sélecteur du genre `article > p:nth-child(2) > span.plop` ou autres fantaisies.

2. **Spécifier le tag auquel s'applique une classe**<br>
`div.ma-classe` est inutilement spécifique, `.ma-classe` suffit tout autant. En revanche, c'est tout à fait pertinent s'il s'agit de surcharger une classe pour certains éléments spécifiques (`strong.error` permet de surcharger les règles par défaut de `.error`).

3. **Utiliser des identifiants**<br>
[Ce qu'un identifiant peut faire, une classe le fait tout autant](http://nicoespeon.com/fr/2013/05/optimiser-selecteurs-css-vs-js#class_ou_id_) ; la réciproque est en revanche fausse. De plus, les identifiants contribuent à créer des problèmes de spécificité.

4. **Utiliser des ombres et des bords arrondis sur des backgrounds irréguliers**<br>
Ca tend à donner des résultats inattendus.

5. **Faire une sprite contenant toutes les images (sauf s'il y a très peu de pages)**<br>
C'est pas très très optimal non plus sachant qu'il faut alors tout gérer en CSS.

6. **Ajuster très précisément la hauteur**<br>
La hauteur d'un élément se contrôle par le contenu. Différencier le conteneur du contenu vous simplifiera la vie.

7. **Utiliser des images comme des textes**<br>
Niveau accessibilité on fait mieux.

8. **Faire de la redondance**<br>
Deux composants qui se ressemblent trop pour être différenciés sur une même page, se ressemblent trop pour être utilisés sur le site : choisissez-en un !

9. **Faire de l'optimisation précoce**<br>
Les développeurs ont tendance à perdre plus de temps à réfléchir à l'optimisation de parties non critiques avant de se concentrer sur l'essentiel.

#### Les avantages de l'OOCSS

Au fur et à mesure que le projet avance, il devient possible de créer de nouvelles pages en combinant les composants de sorte qu'**il n'est plus nécessaire de rajouter du CSS**, même pour une architecture complètement différente.

Réutiliser les éléments est également un **gain de performance** totalement gratuit ! Vous créez de nouveaux éléments avec 0 ligne de code CSS, on peut difficilement faire mieux.

L'OOCSS nous force à penser le site dans sa globalité plutôt que de simples pages mises les unes à côtés des autres. Il s'agit d'anticiper l'avenir.

Enfin, le principal avantage de cette philosophie selon moi est qu'elle rend le CSS modulaire, donc plus **facilement maintenable dans le temps**. Cette modularité rend le CSS plus robuste : un nouveau développeur sur le projet aura moins de chance de tout casser en travaillant dessus.

# OOCSS, comment ça marche ?

#### Des exemples concrets

Souvenez-vous des 2 grands principes de la philosophie :

1. Séparation de la structure et de l'apparence
2. Séparation du conteneur et du contenu

Avec les bonnes pratiques en tête, voyons comment l'appliquer sur un code de tout les jours.

#### 1. Séparation de la structure et de l'apparence

Pour reprendre l'éternel exemple du bouton, un code CSS "classique" ressemble souvent à cela :

{% highlight css linenos %}
#button {
    display: inline-block;
    padding: 4px 12px;
    margin-bottom: 0;

    font-size: 14px;
    line-height: 20px;
    color: #333333;
    text-align: center;

    vertical-align: middle;
    cursor: pointer;

    background-color: #d5d5d5;
}

#button-primary {
    display: inline-block;
    padding: 4px 12px;
    margin-bottom: 0;

    font-size: 14px;
    line-height: 20px;
    color: #ffffff;
    text-align: center;
    text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.25);

    vertical-align: middle;
    cursor: pointer;

    background-color: #006dcc;
}

#button-large {
    display: inline-block;
    padding: 8px 16px;
    margin-bottom: 0;

    font-size: 18px;
    line-height: 28px;
    color: #333333;
    text-align: center;

    vertical-align: middle;
    cursor: pointer;

    background-color: #d5d5d5;
}

#button-activation {
    display: inline-block;
    padding: 8px 16px;
    margin-bottom: 0;

    font-size: 18px;
    line-height: 28px;
    color: #ffffff;
    text-align: center;
    text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.25);

    vertical-align: middle;
    cursor: pointer;

    background-color: #006dcc;
}
{% endhighlight %}

{% highlight html%}
<!-- Le HTML correspondant -->
<a href="#" id="button">Default</a>
<a href="#" id="button-primary">Primary</a>
<a href="#" id="button-large">Large</a>
<a href="#" id="button-activation">Large Primary</a>
{% endhighlight %}

Au final, beaucoup de redondance et un `#bouton-activation` qui n'est que la version large du `#bouton-primary`.

En retravaillant le CSS avec OOCSS, on obtient quelque chose de beaucoup plus flexible :

{% highlight css linenos %}
.button {
    display: inline-block;
    padding: 4px 12px;
    margin-bottom: 0;

    font-size: 14px;
    line-height: 20px;
    color: #333333;
    text-align: center;

    vertical-align: middle;
    cursor: pointer;

    background-color: #d5d5d5;
}

.button-primary {
    color: #ffffff;
    text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.25);

    background-color: #006dcc;
}

.button-large {
    padding: 8px 16px;

    font-size: 18px;
    line-height: 28px;
}
{% endhighlight %}

{% highlight html%}
<!-- Le HTML correspondant -->
<a href="#" class="button">Default</a>
<a href="#" class="button button-primary">Primary</a>
<a href="#" class="button button-large">Large</a>
<a href="#" class="button button-large button-primary">Large Primary</a>
{% endhighlight %}

`.button` définit les propriétés génériques (et ici "par défaut") de nos boutons. En le surchargeant, l'on obtient des classes qui peuvent se combiner pour donner le résultat attendu, **tels des Lego** !

Et elle est là l'astuce.

#### 2. Séparation du conteneur et du contenu

Il n'est pas rare au cours du développement du design principal de se retrouver avec un code ressemblant à cela :

{% highlight css linenos %}
header h1 {
    font-family: 'Roboto', Helvetica, sans-serif;
    font-size: 2em;

    color: #F44;
}

/* tout plein de code CSS */

footer h1 {
    font-family: 'Roboto', Helvetica, sans-serif;
    font-size: 1.5em;

    color: #F44;
    opacity: 0.5;
    filter: alpha(opacity = 50);
}
{% endhighlight %}

{% highlight html%}
<!-- Le HTML correspondant -->
<header>
    <h1>Header Title</h1>
</header>
<footer>
    <h1>Small title in the footer</h1>
</footer>
{% endhighlight %}

Là encore, échec : **on duplique du code inutilement**, probablement sans même s'en rendre compte.

Les éléments déclarés ici ne sont tout simplement pas réutilisables, ils dépendent directement du conteneur dans lequel on les a défini. Or il apparaît clairement que certaines propriétés ne sont pas simplement spécifiques à ces conteneurs.

Ainsi, on devrait plutôt envisager l'alternative suivante :

{% highlight css linenos %}
h1 {
    font-family: 'Roboto', Helvetica, sans-serif;

    color: #F44;
}

/* ... */

h1, .h1-size { font-size: 2em;   }
h2, .h2-size { font-size: 1.8em; }
h3, .h3-size { font-size: 1.5em; }

/* ... */

.muted {
    opacity: 0.5;
    filter: alpha(opacity = 50);
}
{% endhighlight %}

{% highlight html%}
<!-- Le HTML correspondant -->
<header>
    <h1>Header Title</h1>
</header>
<footer>
    <h1 class="h3-size muted">Small title in the footer</h1>
</footer>
{% endhighlight %}

Ici vous me direz : *"Bah, à quoi bon s'embêter avec ça ? On a pas vraiment gagné de place dans le code pour le coup !"*. Et oui, pour le coup, c'est vrai... sur cet exemple particulier où l'on ne se concentre que sur le titre.

Mais l'OOCSS vous oblige à penser bien plus en amont les possibilités d'évolution de votre site. Ici, je n'ai pas simplement amélioré la flexibilité de mes titres, j'ai également introduit de nouveaux éléments :

- Chaque niveau de titre à une `font-size` standard, homogène. Mais chacune de ces `font-size` est affecté dans le même temps à une classe afin de pouvoir être réutilisé indépendamment du contexte.<br><br>
Vous noterez qu'en faisant cela je me préserve de tomber dans la mauvaise pratique (bouh !) qui consiste à choisir le niveau de titre en fonction de la taille que je veux donner visuellement à mon élément : c'est bon pour ma sémantique, c'est bon pour mon accessibilité et c'est bon pour ma [SEO](http://fr.wikipedia.org/wiki/Optimisation_pour_les_moteurs_de_recherche) \o/

- J'ai créé l'élément `.muted` qui me permet d'atténuer la visibilité (opacité) d'un élément. Je gage que cette petite classe utilitaire pourra me reservir ça et là à l'avenir et je suis sûr que je n'irais pas dupliquer le code un peu partout dans mon CSS.

#### Le media object

L'exemple le plus célèbre pour illustrer l'OOCSS est bien entendu le **media object** créé par [Nicole Sullivan](http://www.stubbornella.org/) et qui [permet d'économiser des centaines de lignes de code](http://www.stubbornella.org/content/2010/06/25/the-media-object-saves-hundreds-of-lines-of-code/).

<div class="illustration">
    <img alt="The Media Object" title="Media Object, an example of objects extension" src="/assets/img/css/media-object.jpg">
</div>

Il s'agit ni plus ni moins de l'objet abstrait pour représenter un *media object* (une image, une vidéo) à côté d'un *media body* (texte typiquement), à gauche comme à droite.

C'est un schéma typique qui tend à se répéter, le meilleur exemple qu'il soit étant Facebook notamment.

Voici basiquement en quoi le module consiste :

{% highlight css %}
.media, .media-body { overflow:hidden; }
.media-img          { float:left; margin-right:20px; }
.media-img-rev      { float:right; margin-left:20px; }
.media-img img      { display:block; }
{% endhighlight %}

{% highlight html %}
<!-- Structure du media object de base -->
<div class="media">
    <a href="#" class="media-img">
        <img src="#" alt="#">
    </a>
    <div class="media-body">
        <p>
            Lorem ipsum dolor sit amet, consectetur adipisicing elit.
        </p>
    </div>
</div>
{% endhighlight %}

Ces quelques lignes de CSS, réutilisables à souhait, génère un gain de temps et de performance considérable sur l'ensemble d'un projet.

Je ne saurais que trop vous conseiller de jeter un oeil au court article de Nicole que je vous ai indiqué précédemment. D'ailleurs [je le remet](http://www.stubbornella.org/content/2010/06/25/the-media-object-saves-hundreds-of-lines-of-code/), vous n'aurez pas d'excuse !

Notez par exemple que [Bootstrap l'a implémenté](https://github.com/twitter/bootstrap/blob/master/less/media.less), de même que [inuit.css](https://github.com/csswizardry/inuit.css/blob/master/objects/_media.scss) ce qui n'est pas étonnant sachant que ces deux frameworks se basent sur le concept de l'OOCSS.

<p class="islet">
    Harry Roberts a récemment <a href="http://csswizardry.com/2013/05/the-flag-object/">proposé le <strong>flag object</strong></a> qui reprend ni plus ni moins le <strong>media object</strong> avec la notion de centrage vertical en bonus, ce qui peut servir à certaines occasions.
</p>

#### Implémenter l'OOCSS dans son projet

Avant tout, il s'agit de bien comprendre et adhérer à la philosophie. Il n'y a pas de règles absolue et les bonnes pratiques changent à mesure que le web se développe et évolue. De plus, il faut toujours considérer le contexte du projet et définir ce qui est bon pour vous.

Cela étant, l'on peut synthétiser la mise en place d'un esprit OOCSS par quelques pratiques concrètes :

- N'utilisez pas d'ID dans le CSS
- Ne spécifiez pas vos sélecteurs (`.error` et pas `p.error`), sauf pour surcharger
- Évitez au maximum l'utilisation de `!important`
- Distinguer les composants de votre projet et faîtes en des modules
- Si c'est pertinent, adoptez un framework CSS qui se base sur l'OOCSS. Je vous conseillerais *[Bootstrap](http://twitter.github.io/bootstrap/)* si vous avez besoin d'un design pré-conçu ; *[inuit.css](http://inuitcss.com/)* si seule la structure vous suffit (vous vous occupez de l'apparence, principe #1). Notez qu'il existe le framework *[oocss](https://github.com/stubbornella/oocss/wiki)* de Nicole Sullivan comme référence.


# Quelques remarques

#### Bonnes remarques et fausses idées

Il va sans dire que cette manière de voir les choses n'est pas absolue et suscite débats.

Voici cependant quelques points qu'il convient de noter :

- **Il est tout à fait possible d'utiliser des ID** dans le HTML, pour le Javascript notamment. De plus, les identifiants pourraient également se révéler intéressants en guise de *namespace* pour un module particulier que l'on partagerait, afin de ne pas causer de conflit potentiel.

- Une des réticences à l'encontre de l'OOCSS rélève du fait que le HTML se retrouve "pollué" par un nombre conséquent de classes, ce qui fait rechigner les puristes. Il s'agit d'une appréciation personnelle de ce qu'est le juste milieu et cela se fait dans le choix de niveau d'abstraction. Cela étant, **l'OOCSS n'impacte en rien la sémantique du HTML**.

- Les principes de l'OOCSS font des miracles du côté des gros projets où le jeu vaut vraiment la chandelle. Pour des petits projets (le site vitrine d'une association par exemple), *it's up to you!* Cependant, **la philosophie s'adpate quelque soit la taille du projet** et ne demande pas plus de temps à être mise en place qu'un développement ordinaire une fois que vous commencez à vous faire la main dessus. Au contraire, les modules que vous avez créé pour tel ou tel autre projet peuvent tout autant vous resservir tels quels, il n'y a qu'à les rhabiller.

<p class="islet">
    Bien que l'OOCSS soit une vision plutôt bien répandue par les bienfaits qu'elle apporte, je dois dire que moi j'étais perplexe en lisant ZE phrase choc : <em>"avoid the use of ID in CSS, ever"</em>.<br>
    Mais depuis que j'ai compris l'intérêt de cette pratique je la recommande chaudement.
    <br><br>
    Cela étant, ayant également adopté <a href="http://smacss.com/">SMACSS</a> dans l'organisation de mon code, j'utilise les identifiants dans mon CSS à <strong>un seul et unique endroit</strong> : <a href="https://github.com/nicoespeon/nicoespeon.github.io/blob/develop/assets/less/ui/layout.less">le layout</a>.
    <br><br>
    Tout est donc question d'adapter ce qui convient à son projet et sa philosophie.
</p>

#### Une autre philosophie

[Une autre vision du CSS](http://coding.smashingmagazine.com/2012/06/19/classes-where-were-going-we-dont-need-classes/) consiste au contraire dans une importance accordée au contexte où se situent les éléments.

C'est une autre philosophie, *"interface-oriented"* qui pose comme principe que le CSS vient styliser l'interface HTML existante. Il n'y a pas lieu de venir polluer le HTML avec des classes alors que les sélecteurs et une bonne organisation du code peuvent tout aussi bien intervenir sur le design.

Bien que je n'adhère pas à cette pratique (du moins pour tout projet susceptible de prendre de l'ampleur), elle est néamoins intéressante et n'en reste pas moins pertinente, dans le cas de petits projets par exemple.


# Pour aller plus loin

#### Articles et liens intéressants

Voici une série de liens auxquels je vous suggère de jeter un oeil si vous souhaitez approfondir ma présentation :

- [An introduction to OOCSS](http://coding.smashingmagazine.com/2011/12/12/an-introduction-to-object-oriented-css-oocss/), article introductif sur le concept par Smashing Magazine.
- [The OOCSS perspective](http://fr.slideshare.net/stubbornella/the-cascade-grids-headings-and-selectors-from-an-oocss-perspective-ajax-experience-2009) par Nicole Sullivan, ou bien [la version courte](http://fr.slideshare.net/stubbornella/object-oriented-css) si vous n'êtes pas téméraires.
- [Liste des articles OOCSS](http://www.stubbornella.org/content/category/general/geek/css/oocss-css-geek-general/) sur le blog de Nicole Sullivan (oui, toujours elle, il faut rendre à César ce qui est à César).
- [Breaking Good Habits](http://vimeo.com/44773888), speech de Harry Robert's sur la question dont [voici les slides](https://speakerdeck.com/csswizardry/breaking-good-habits).
- [OOCSS & RWD](http://andrewhathaway.net/posts/oocss-and-rwd) pour une petite réflexion sur comment l'OOCSS contribue à réaliser des sites web responsive et consistants.
- [Le CSS Orienté Objet expliqué avec Monsieur Patate](http://www.design-fluide.com/21-09-2011/le-css-oriente-objet-explique-avec-monsieur-patate/), parce-que oui il y a quand même quelques articles français sur la question qui trainent sur le web.
- [CSSLint](http://csslint.net/) est un outil permettant de confronter votre CSS aux principes de OOCSS et de le corriger en ce sens.

#### Conclusion

Notre petite plongée au coeur de l'OOCSS s'achève ici.

Vous remarquerez que la très grande majorité des articles/sujets portant sur ces pratiques avancées de CSS sont en anglais, ce qui peut s'expliquer notamment par le fait que le sujet est encore récent (2009 pour les prémices, en pleine popularisation depuis le développement des frameworks CSS). Ce fut d'ailleurs la raison pour laquelle j'ai souhaité apporter ma pierre à l'édifice en rédigeant cet article en français.

J'espère que le sujet aura pu vous faire réfléchir sur vos pratiques CSS, voire même vous intéresser. Si vous avez des questions, des remarques, des suggestions ou même des idées à partager avec moi, n'hésitez pas à me laisser quelques commentaires ci-dessous =)

<div class="illustration">
    <img alt="After OOCSS" title="Code smells better with OOCSS" src="/assets/img/css/after-oocss.jpg">
    Vous aussi, adoptez le "Oh Oh" CSS
</div>

Plop !
