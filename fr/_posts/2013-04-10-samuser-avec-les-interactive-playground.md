---
layout: post
robots: index,follow
published: true
comments: true

jsbin: true
codepen: true

tags: [dabblet, jsFiddle, JSBin, CodePen]
icon: lab

title: S'amuser avec les interactive playground
description: JSBin, jsFiddle, dabblet, ... Si ces noms ne vous parlent pas, alors peut-être devriez-vous jeter un œil par ici et découvrir le principe de ces "terrains de jeu interactifs".
---

## Interactive playquoi ?

Il s'agit en fait d'un IDE en ligne permettant de réaliser du développement front-end (HTML, CSS et JS bien souvent) et de visualiser le résultat.

La plupart permettent également de sauvegarder le code et de le partager, ce qui mène à un certain nombre d'applications pratiques de ces outils à savoir :

- **débogage de codes**, l'environnement permettant de reproduire un bug ou un effet non désiré et d'en isoler la cause, ce qui en fait [un outil particulièrement apprécié des développeurs](http://css-tricks.com/seriously-just-make-a-jsfiddle/).

- **création de snippets**, particulièrement utile pour répondre à une problème ou une question sur [StackOverflow](http://stackoverflow.com/questions/210717/using-jquery-to-center-a-div-on-the-screen) (par exemple) ou pour [réaliser des showcases](http://dabblet.com/gist/3350582/).

- **enseignement par mise en pratique** utilisé par des sites tels que [CodeSchool](http://www.codeschool.com), produisant de véritables TP-live pour mettre en pratique ce qui vient d'être vu.

Voici donc, après cette petite mise en jambes, une petite présentation non-exhaustive des web playgrounds que je connais et que j'affectionne.


## JSBin

[JSBin](http://www.jsbin.com) est le premier que je connaisse. Un vieux de la vieille qui existe depuis 2008. Il dispose des 4 panels classiques pour éditer le **HTML**, le **CSS**, le **Javascript** et constater le **résultat**. Il dispose également d'un panel **Console** qui tient le rôle de console javascript une fois le code interprété. Fait appréciable : les modifications apportées au code sont visibles en temps réel.

Particulièrement abouti, il permet d'interpréter directement les Gist, ce qui est appréciable en soi pour les grands adeptes de la plateforme.

<p class="islet">
    <a href="https://gist.github.com/">Gist</a> est un moyen rapide et efficace que propose Github pour partager des snippets de codes versionnés sous Git. JSBin permet donc de visualiser directement dans le navigateur le rendu du code, permettant de le modifier et de sauvegarder une nouvelle version du Gist.
</p>

Il dispose également d'un certain nombre de features notables comme [JSHint](http://jshint.com/) (un linter qui vérifie que votre Javascript ne comporte pas d'erreur) ou encore la possibilité d'insérer le JS/CSS à un endroit spécifique du HTML avec `%code%`/`%css`.

<p class="visuallyhidden--palm">
    <a class="jsbin-embed" href="http://jsbin.com/uduvaf/5/embed?live">Exemple d'un JSBin intégré</a>
</p>

#### Points forts

- Pas nécessaire d'être enregistré pour l'utiliser
- Visualisation du rendu en temps réel
- [Intégration de Gists](http://www.youtube.com/watch?feature=player_embedded&v=_GtjaW4Ma3c)
- Particulièrement riche en fonctionnalités (JSHint, Ajax, templates, ZenCoding, ...)
- Les JSBin peuvent être intégrés et modifiés directement dans des sites web


## jsFiddle

[jsFiddle](http://jsfiddle.net) fonctionne peu ou prou selon le même principe, avec une interface à l'ergonomie quelque peu différente.

Les fonctionnalités sont sensiblement les mêmes à ceci près que jsFiddle permet toutefois de coder en [SASS](http://sass-lang.com/) plutôt qu'en CSS et en [CoffeeScript](http://coffeescript.org/) plutôt qu'en Javascript, ce qui peut être un argument pour les aficionados de ces pré-processeurs.

Fait notable également : le HTML est épuré, il est inutile de renseigner les entêtes ou le doctype puisque le code du panel sera de facto intégré entre les balises `<body>`. En contrepartie, la configuration du doctype et des informations se fait sur le côté, via un panneau de configuration.

<p class="islet">
    <a href="https://twitter.com/csswizardry">Harry Roberts</a> utilise d'ailleurs jsFiddle pour présenter les fonctionnalités d'<a href="http://jsfiddle.net/user/inuitcss/fiddles/"><em>inuit.css</em></a>, ce qui permet de se faire rapidement une idée de comment fonctionne le framework et de ses capacités sans même avoir à le télécharger.
</p>

<p class="visuallyhidden--palm">
    <iframe width="100%" height="300" src="http://jsfiddle.net/espeon/stVTF/embedded/" allowfullscreen="allowfullscreen" frameborder="0">Exemple d'un jsFiddle intégré</iframe>
</p>

#### Points forts

- Pas nécessaire d'être enregistré pour l'utiliser
- Intégration de Gists
- Particulièrement riche en fonctionnalités (TidyUp, JSHint, Ajax, ZenCoding, ...)
- Possibilités d'utiliser des pré-processeurs CSS/JS
- Les fiddles peuvent être intégrés directement dans des sites web, mais pas modifiés


## CodePen

[Codepen](http://codepen.io) est une autre version assez populaire, avec un style quelque peu différent et une stratégie économique établie. En effet, CodePen propose [une version PRO](http://codepen.io/pro/) permettant par exemple de dispenser un cours en temps réel, ou bien de coder à plusieurs collaborateurs, simultanément, en live.

CodePen propose un certain nombre de features intéressantes, y compris l'usage de pré-processeurs. A noter qu'en se connectant avec son compte Github, les Pens que l'on crée se transforment automatiquement en Gists sur notre compte. Les modifications se font également en temps réel...

<p class="islet">
    En revanche <strong>il faut être connecté afin de pouvoir intégrer les Pens</strong>, ce qui ne nécessite pas forcément de créer un compte si l'on dispose d'un compte Github. De nombreuses fonctionnalités de CodePen vont également bien plus loin que les précédents projets mais sont réservées à la version PRO (<em>business is business</em>, ce qui est tout à fait compréhensible en soi).
</p>

<div class="visuallyhidden--palm">
    <pre class="codepen" data-height="300" data-type="result" data-href="geycm" data-user="nicoespeon" data-safe="true"><a href="http://codepen.io/nicoespeon/pen/geycm">Exemple d'un CodePen intégré</a></pre>
</div>

#### Points forts

- Pas nécessaire d'être enregistré pour l'utiliser
- Visualisation du rendu en temps réel
- Sauvegarde des Pens en tant que Gists
- Particulièrement riche en fonctionnalités (JSHint, Ajax, ZenCoding, ...), notamment avec un compte PRO
- Possibilités d'utiliser des pré-processeurs CSS/JS/HTML
- Les Pens peuvent être intégrés directement dans des sites web, mais pas modifiés


## dabblet

[dabblet](http://dabblet.com/) est un peu particulier dans le genre. En effet, **ce dernier s'oriente** non pas sur le Javascript (fer de lance de JSBin et jsFiddle, rien que par le nom) mais **sur le CSS**.

<p class="islet">
    L'idée de <a href="https://twitter.com/LeaVerou">Léa Verou</a> était de produire une alternative qui ne s'embarassait pas de requêtes HTTP à chaque fois que l'on fait/code quelque chose dans l'éditeur. Si cela prend sens pour le Javascript, ce n'est d'aucun intérêt quand on ne cherche qu'à tester du HTML/CSS.
</p>

Sous son apparence design, dabblet offre également tout un panel de fonctionnalités comme la visualisation du rendu en temps réel, des "inline previewers" particulièrement sympathiques sur toutes sortes de propriétés CSS (pour visualiser une longueur, une couleur, un effet, ...) et même l'incorporation native de [-prefix-free](http://leaverou.github.com/prefixfree/), luxe ultime pour tout développeur CSS. Ce dernier vous permet d'utiliser les propriétés CSS3 sans vous préoccuper des préfixes, il les ajoute en background quand c'est nécessaire.

<p class="islet">
    A noter cependant que, sous la demande, dabblet expérimente également la possibilité d'intégrer du Javascript. Mais il y a fort à parier que ce sera juste un possibilité offerte et non pas le fer de lance de cet environnement, bien au contraire !
</p>

<p class="visuallyhidden--palm">
    <iframe width="100%" height="400" src="http://dabblet.com/gist/5360845" allowfullscreen="allowfullscreen" frameborder="0">Exemple d'un dabblet intégré</iframe>
</p>

#### Points forts

- Pas nécessaire d'être enregistré pour l'utiliser
- Visualisation du rendu en temps réel
- Synchronisation totale avec les Gists (connecté sous Github)
- Inline previewers et utilisation native de -prefix-free pour le développement CSS
- Les dabblet peuvent être intégrés et modifiés directement dans des sites web


## Le problème, c'est le choix

Il y a effectivement de quoi faire et suffisamment d'environnements pour que chacun s'y retrouve. Chaque développeur peut s'orienter vers la solution qui s'adapte le plus à ses besoins, qui lui convient le mieux, qui le séduit le plus. Et tout comme pour les IDE, rien n'interdit de passer d'un environnement à un autre, pour se faire une idée, au contraire.

- Personnellement, j'utilise beaucoup **jsFiddle** jusqu'à présent...

- ... je garde un oeil sur **JSBin** mais je n'ai pas eu de grosse raison de changer d'environnement pour le moment...
- ... **CodePen** ne me convient pas exactement, même si je le trouve cool dans l'esprit...
- ... et **dabblet** est mon petit coup de coeur que j'ai découvert récemment. Il n'est pas encore aussi mature que les autres, mais il a des atouts indéniables qui justifient le détour.
