---
layout: post
robots: index,follow
published: true
comments: true

tags: [kanban, trello, productivité, jeux vidéo]
icon: reliability

title: Kanban et Game Development avec Trello
description: Comment Kanban nous permet d'être efficaces pour produire des jeux vidéo en tant que start-up ? Et comment utilisons-nous Trello pour cela ?
---

## Vidéo & Slides

J’ai présenté ce talk le 2 février 2016 au [meetup Trello French UG #02](http://www.meetup.com/fr-FR/Trello-France-User-Group/events/227984227/).

L’article détaille le sujet en profondeur ci-dessous.

<iframe width="560" height="315" src="https://www.youtube.com/embed/4P-mfUew8MQ?rel=0" frameborder="0" allowfullscreen></iframe>

<iframe src="http://slides.com/nicoespeon/kanban-game-development-trello/embed" width="576" height="420" scrolling="no" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>

## Contexte

### Metidia, une start-up qui développe des jeux vidéo

Je suis associé d'une start-up parisienne qui s'appelle [Metidia](http://metidia.com/index/).

Concrètement, nous développons des jeux vidéo autour de produits de consommation car nous voulons changer l'univers de l'achat en ligne. Ainsi, nous travaillons sur [Vinoga](https://apps.facebook.com/metidia-vinoga/?utm_source=nicoespeon-kanban-game-dev) : un jeu Facebook de social-farming (pensez « FarmVille », « Hay Day ») sur le thème du vin. Vous êtes vigneron(e) qui redécouvrez les étapes de production de véritables bouteilles au travers de votre aventure. Entre deux vendanges, vous pouvez donc jeter un œil à votre carte des vins, personnaliser, commander puis déguster en vrai les crus que vous avez virtuellement produits.

Le challenge d'une start-up est **d'itérer d'une idée de départ à un business model qui fonctionne avant d'être à cours de ressources**.

Et, entre les multiples casquettes typiques d'une start-up, j'ai celle du responsable de la partie production : faire en sorte que l'équipe concrétise les idées, teste les hypothèses et crée un jeu qui corresponde aux attentes des clients-joueurs.

Notre équipe de production est composée de 1 Game Designer, 1 Graphiste et 2/3 Développeurs. Si nous avions commencé à 2 avec une organisation de type [La Rache](http://www.la-rache.com/), il a vite fallu nous adapter pour ne pas répéter les déboires des premiers temps (assets produites, mais devenues obsolètes avant d'être intégrées ; faible qualité du code qui doit être retravaillé à cause des bugs…).

Nous avons profité de notre flexibilité pour adopter *de facto* les pratiques Agiles. J'ai pas mal tâtonné à ce sujet. Par exemple, nous avons beaucoup appris de [Scrum](https://fr.wikipedia.org/wiki/Scrum_(m%C3%A9thode)) pour nous organiser, mais il s'est avéré trop lourd, inadapté pour notre contexte.

<p class="islet">
  En fin de compte, je pense que <strong>l'Agile est un buffet dans lequel il faut se servir</strong>.<br><br>
  Au fur et à mesure, nous avons composé un processus qui nous est adapté, en picorant les bonnes pratiques qui fonctionnent pour nous.
</p>

Finalement, Kanban s'est révélé être particulièrement efficace pour l'équipe : suffisamment flexible pour s'adapter au quotidien ; mais assez solide pour éviter que ça se disperse dans tous les sens (ce qui n'est pas toujours évident avec des esprits créatifs).

### Kanban, kézako ?

Pour résumer simplement, [Kanban](https://fr.wikipedia.org/wiki/Kanban_(d%C3%A9veloppement)) est « un système visuel de gestion des processus qui indique, quoi produire, quand le produire et en quelle quantité ».

Le cœur de Kanban consiste à **visualiser le processus de production** pour mettre en place un **système de tirage limité des tâches en cours**. Ce qui veut dire qu'on limite le nombre de tâches en parallèle pour chaque étape du processus. Lorsqu'une place est libre, c'est l'étape en aval qui vient prendre une tâche en amont (système de tirage) et non l'inverse.

Concrètement, voici à quoi ressemble un processus Kanban en action : [One day in Kanban land](http://blog.crisp.se/2009/06/26/henrikkniberg/1246053060000)

Le passage à Kanban est assez simple car l'on part de l'existant :

- identification des processus existants (ex : processus de production, de support au joueur…)
- décomposition des workflows pour chaque processus
- fixation des limites de tâches en cours (là encore, on commence à partir de l'existant)

Puis, l'idée est de venir améliorer le flow au fur et à mesure en impliquant l'équipe. C'est le [Kaizen](https://fr.wikipedia.org/wiki/Kaizen), composante essentielle de Kanban : l'équipe fait un point régulièrement pour **améliorer de manière incrémentale et continue son organisation**. Cela permet à l'équipe d'adapter son fonctionnement à son contexte, de tester des choses, de s'adapter au changement…

C'est ainsi que nous avons fait évolué au fur et à mesure les limites de tâches en cours (= WIP) de chaque étape du processus jusqu'à atteindre des valeurs qui nous permettent d'être plus productifs (WIP bas = débit plus important), sans nous retrouver bloqués… ce qui est bon pour le moral !

## Big picture

Nous avons intégré [Trello](https://trello.com/) depuis le tout début, dès 2013. Gratuit, intuitif, simple à prendre en main, c'est notre tableau blanc virtuel et compagnon dans l'aventure qui a pu évoluer avec nous à mesure que nous nous organisions.

Les boards (= tableaux) de Trello sont très flexibles, ce qui nous permet de les faire évoluer avec le temps au gré des besoins.

Nous avons donc diverses boards qui se créent ou se ferment en fonction des projets. L'organisation de ces boards s'adapte au contexte : un projet temporaire planifié en mode GANTT pour des besoins business (avec l'extension [Elegantt](http://elegantt.com/trello/)) ; un simple Kanban *TODO > Doing > Done* pour gérer un sous-projet temporaire ; etc.

À côté de ça, nous avons une board pour chaque processus identifié, à savoir :

- Production
- Business
- Support
- Communication

Chaque board représente une activité qui a son workflow.

Dans cet article, je vais me concentrer exclusivement sur le fonctionnement de la board de production.

## La board de production

La board (Kanban) de production représente notre force de production, le travail de l'équipe de production. Et ce, peu importe ce qu'il faut produire : correctif de bug, nouvelle feature sur Vinoga ou sur un autre produit, hotfix… Tout ce qui est livré.

Cela permet d'être honnête sur la capacité de travail de l'équipe, de prioriser tout ce que nous faisons et d'homogénéiser le processus de production.

<div class="illustration">
  <img alt="Board de production" src="/assets/img/kanban/overview.png">
  Notre board de production
</div>

### Goals

<div class="illustration">
  <img alt="Goals" src="/assets/img/kanban/goals.png">
</div>

La première liste de la board contient nos key metrics : les 3/4 KPIs les plus importants pour nous. Ça permet à l'équipe de toujours les avoir sous les yeux et c'est motivant.

Les objectifs sont revus chaque mois, ce qui nous permet de faire le point sur notre cap et nos performances.

C'est aussi l'occasion de célébrer les réussites tous ensemble, parce que c'est bon pour le moral !

### Templates

<div class="illustration">
  <img alt="Templates" src="/assets/img/kanban/templates.png">
</div>

Cette liste est plutôt utilitaire : elle contient les cartes qui font office de template pour nous simplifier la vie.

En fait, il n'y a pas vraiment de *« template de carte »*, car créer une carte quand on a une idée doit rester quelque chose de simple. Tout le monde peut créer une carte, mais tout le monde ne pense pas à dupliquer une carte pour cela : cela n'a rien d'intuitif.

En revanche, cela nous est très utile pour les **templates de checklists**. 

En effet, Kanban préconise de « rendre les normes de processus explicites » : chacun doit pouvoir savoir si une carte est prête pour passer à la prochaine étape du flow ou non. Pour cela, l'équipe se met d'accord sur (et fais évoluer) **les règles de sortie** de chaque étape du flow de production. Et, après avoir tâtonné sur le meilleur format pour ce faire avec Trello, les checklists se sont avérées être le moyen le plus efficace !

<div class="illustration">
  <img alt="Detailed template" src="/assets/img/kanban/template-detailed.png">
  Exemple de template pour les conditions de sortie explicites
</div>

Ainsi, lorsque l'on en a fini avec une carte, chacun sait qu'il faut créer la checklist de sortie. Ce qui est aisé avec les templates :

<div class="illustration">
  <img alt="Copy a template" src="/assets/img/kanban/template-copy.png">
  Il suffit de copier un template de checklist
</div>

<p class="islet">
  Notre astuce pour retrouver rapidement nos checklists templates, c'est de nommer la carte de manière à ce qu'elle apparaisse en premier dans la liste déroulante.<br><br>
  D'où le préfixe <code>(Template)</code> qui fait très bien l'affaire.
</p>

### Icebox / Backlog

<div class="illustration">
  <img alt="Icebox & Backlog" src="/assets/img/kanban/backlog.png">
</div>

Le fonctionnement du « Backlog » est probablement ce qui nous a causé le plus de tâtonnement : où mettre les idées, les TODOs à venir, sans que ce soit lourd ou long à traiter. 

Nous avons donc testé pas mal de choses, y compris une board « Planning » [à la manière de UserVoice](https://community.uservoice.com/blog/trello-google-docs-product-management/). Mais ce qui a marché pour nous fut d'intégrer une liste « Backlog » directement dans la board. 

<p class="islet">
  Les cartes y sont priorisées, ce qui veut dire que l'équipe traitera, dès que possible, la carte qui est tout en haut. Ainsi, nous pouvons re-prioriser les cartes jusqu'au dernier moment.<br><br>
  Décider le plus tard possible pour être plus efficaces.
</p>

Pendant un temps, nous limitions la taille du backlog pour éviter que les cartes ne s'y accumulent plus vite qu'elles ne puissent être traitées. Cette limitation a finalement été abandonnée, car l'équipe est désormais capable de s'auto-gérer. Le [Cumulative Flow Diagram](http://brodzinski.com/2013/07/cumulative-flow-diagram.html) nous permet de visualiser rapidement la tendance et de savoir si nous ajoutons plus de cartes que raisonnable, ou non.

« Backlog » contient donc les cartes que nous avons décidé de traiter prochainement, généralement parce-qu'elles impactent l'un des goals que nous nous sommes fixés.

Cela étant, vous n'empêcherez pas une équipe créative d'avoir des idées ! Et pour favoriser cela, il faut faire tomber les barrières. C'est le rôle de la liste « Icebox ».

Sans limite de cartes, elle permet de recueillir toutes les idées ou suggestions qui ne vont pas forcément faire partie du backlog (ex : des idées pour améliorer la monétisation du jeu tandis que le focus actuel est porté sur la rétention).

Nous repassons régulièrement sur les cartes de cette liste pour les déplacer dans le backlog si elles deviennent pertinentes, les supprimer si elles ne sont plus valables ou pour y ajouter des idées, des compléments d'information…

Le fait de garder cette liste dans la board simplifie les choses. Cela rend le tout plus flexible, tout en nous permettant d'avoir une vision à moyen-long terme. Mais on ne perd pas trop notre temps dessus, car, en start-up, le moyen-long terme ça peut changer très vite.

### Workflow de production

<div class="illustration">
  <img alt="Production workflow" src="/assets/img/kanban/production.png">
  Le flow de production
</div>

Ceci représente concrètement les différentes étapes par lesquelles chaque carte va passer.

Chaque étape a une limitation du travail en cours (le WIP) indiquée dans le titre de la liste.

Les cartes s'écoulent en mode par tirage (mode « pull ») : lorsque le traitement d'une carte est terminé pour une étape, elle reste à ce niveau (avec un petit label vert) jusqu'à ce que quelqu'un de l'étape d'après soit disponible pour s'en occuper. Tout cela, dans le respect des limites de WIP.

Exceptionnellement, il peut y avoir des cartes qui font fi des limites de WIP. Ça peut être le cas d'une urgence (ex : hotfix critique en production) ou d'une attente externe à une carte (ex : en attente de validation de Facebook). Dans ces cas-là, les cartes ont un label rouge explicite. Et ces cas-là sont rares.

#### Card Preparation

Les cartes y sont *préparées* pour la suite du flow. 

C'est à partir de ce moment que l'on va décrire le use case de la carte, ainsi que l'[objectif SMART](https://fr.wikipedia.org/wiki/Objectifs_et_indicateurs_SMART) de celle-ci. Toute carte a un objectif (sinon, que ferait-elle ici ?). Que ce soit de corriger un bug en production ou d'implémenter une nouvelle fonctionnalité, il y a une raison pour laquelle nous allons traiter cette carte plutôt qu'une autre. Et, surtout, nous allons déterminer *comment* nous saurons si l'objectif est atteint et que faire en cas de succès ou d'échec.

Ainsi, nous ne perdons pas de temps à trop préparer l'ensemble des cartes qui sont dans le backlog. Seul l'objectif général importe, mais c'est dans **Card Preparation** que l'on va creuser l'idée, se mettre d'accord sur la portée de la carte et, éventuellement, de son découpage en plus petites cartes (notamment dans le cadre d'une mécanique de jeu, qui se décompose souvent en petites fonctionnalités que l'on peut intégrer au fur et à mesure).

#### Production

C'est ici que va se faire le game design / spelling / graphisme / développement d'une carte.

Chacun est libre de se servir de checklists, voire même d'ouvrir une board temporaire, pour s'organiser.

<p class="islet">
  Pendant un temps, chaque étape de production (specs, graphisme, dév…) était représenté par une liste. Néamoins, ce n'était pas assez flexible et ne reflétait pas la réalité.<br><br>
  Une seule liste permet plus de latitude afin par exemple que les développeurs travaillent directement avec les graphistes lors de l'intégration ; ou lorsqu'il n'y a pas de graphiste disponible pendant 1 semaine (on évite les « bulles d'air » dans le flow).
</p>

#### Tests QA

C'est ici que nous allons nous assurer que le rendu est conforme à ce qui était attendu. C'est habituellement un pair qui s'occupe de cette partie pour assurer la qualité (le game designer, quelqu'un du business, un autre développeur que celui qui a codé…).

On s'assure également ici que nous sommes en mesure d'analyser l'objectif SMART défini pour cette carte. 

Si un souci est relevé, la carte reste ici et bloque le flow tant qu'il n'est pas corrigé. Ainsi, l'équipe se préoccupe de **terminer les tâches en cours avant d'en attaquer de nouvelles**. Et chacun se préoccupe de la qualité de ce qui est produit.

#### Mise en live

Il s'agit de la procédure de livraison en production de ce qui a été produit.

Tout est déployé en continu. Au besoin, nous faisons du feature flipping pour activer / désactiver des fonctionnalités.

### Live

<div class="illustration">
  <img alt="Live" src="/assets/img/kanban/live.png">
</div>

Une fois en production, les cartes ne sont pas oubliées.

En effet, à chaque carte a été associé un objectif SMART, validé par l'équipe. Une fois en production, nous analysons ce dernier.

Cela peut être fait une fois la carte en production (dans le cas des correctifs par exemple), ou bien plus tard si l'analyse doit collecter des données auparavant (c'est par exemple le cas des tests A/B). Dans cette situation, une date d'analyse est planifiée sur la carte et une personne assignée.

Une fois l'analyse faite, la carte est considérée comme terminée. Elle est déplacée dans le **Live** du mois en cours. Nous appliquons également le scénario prévu en cas de succès ou d'échec de l'objectif, qui était finalement notre hypothèse au sens du [Lean Startup](https://fr.wikipedia.org/wiki/Lean_Startup). 

Ainsi, que ce soit un succès ou un échec, **nous avons appris quelque chose** une fois qu'une carte passe en Live. Nous avons validé ou invalidé une hypothèse, ce qui nous éclaire sur la suite. 

Nous faisons un bilan mensuel sur les cartes mises en live = ce que nous avons appris. 

## Lessons learned & Anecdotes

En vrac, voici quelques trucs que nous avons appris ou mis en place et qui nous servent beaucoup.

### Rester simple

Je ne vais pas rabâcher le [principe KISS](https://fr.wikipedia.org/wiki/Principe_KISS), mais c'est vraiment essentiel à garder en tête.

Dans notre cas par exemple, je me suis rendu compte que plus je créais de boards pour séparer le travail avec des workflows particuliers à chaque board ([à la manière de UserVoice](https://community.uservoice.com/blog/trello-google-docs-product-management/) par exemple), moins c'était efficace. Il faut que l'essentiel soit à portée de main, sous les yeux, pour rester focus.

Sinon ? Ce ne sera pas adopté, pas utilisé dans la pratique par l'équipe… parce que ce n'est pas pratique pour l'équipe.

### Concernant les estimations des cartes…

… pour nous c'est une perte de temps.

Il y a moult débats sur la question et je n'entrerai pas ici dans le détail.

Mais **en ce qui nous concerne**, Kanban nous a permis d'arriver aujourd'hui avec une « ligne de production » efficace et rapide. Avec nos indicateurs, nous sommes capables de connaître notre vitesse moyenne de production. En homogénéisant au mieux la taille des cartes qui arrivent, et en nous concentrant sur l'essentiel, nous intégrons en continu les changements dans le jeu. 

Si une carte est urgente, il suffit de la placer en haut du backlog et elle sera naturellement intégrée en production dans un délai approximativement connu, fiable et raisonnable (8 jours calendaires actuellement, en moyenne).

Si cela est plus urgent encore et que cela ne peut pas attendre, alors un label rouge fera passer cette carte en priorité avant le reste (c'est la fast-line). Mais ce genre d'urgence est rare une fois que l'on a une équipe de production capable d'intégrer au mieux, le plus vite possible.

### Management visuel

« Visualiser » est l'un des piliers centraux de Kanban en particulier et d'une manière générale au sein des pratiques Agiles.

Trello s'intègre parfaitement pour cela avec des [power-ups tels que GitHub](http://blog.trello.com/github-and-trello-integrate-your-commits/), ou avec son API.

En ce qui nous concerne par exemple, nous changeons la couleur du background en fonction de l'état de notre système d'intégration continue.
 
Quand c'est vert, tout va pour le mieux dans le meilleur des mondes !

Quand c'est orange, c'est qu'un déploiement est en cours :

<div class="illustration">
  <img alt="In deployment" src="/assets/img/kanban/overview-deployment.png">
</div>

Une fois le déploiement terminé, ça redevient vert. Mais si le déploiement échoue, le background devient rouge et tout le monde le voit :

<div class="illustration">
  <img alt="Deployment failed" src="/assets/img/kanban/overview-failure.png">
  Un déploiement a raté, il va falloir regarder ça.
</div>

### Visualisation Kanban & Trello

Pour connaître le nombre de cartes de chaque liste en permanence, j'applique un filtre sur `*` afin de ne masquer aucune carte.

Soit dit en passant, je ne sais pas pourquoi le nombre de cartes d'une liste ne s'affiche **que** lorsqu'un filtre est activé.

J'utilise également [une extension Chrome](https://chrome.google.com/webstore/detail/kanban-wip-for-trello/oekefjibcnongmmmmkdiofgeppfkmdii) pour coloriser le background des listes en fonction du nombre de cartes. Si la limite de WIP est atteinte, c'est jaune. Si on dépasse, c'est rouge. Ce n'est pas indispensable, mais c'est pas mal pour comprendre l'état du flow de visu.

<p class="islet">
  Existe également une extension Chrome qui semble faire tout cela : <a href="https://chrome.google.com/webstore/detail/cardcounter-for-trello/miejdnaildjcmahbhmfngfdoficmkdhi">CardCounter for Trello</a>, mais je ne l'ai pas encore testé donc je ne sais pas ce que ça vaut.
</p>

Une autre extension assez pratique : [Card color titles](https://chrome.google.com/webstore/detail/card-color-titles-for-tre/hpmobkglehhleflhaefmfajhbdnjmgim) qui affiche les titres des labels directement sur les cartes.

Enfin, [Ollert](https://ollertapp.com/boards) est un outil de visualisation assez complet qui vous permettra, notamment, de tracer le Cumulative Flow Diagram de votre tableau sur une période donnée.

### Board « Calendar »

Pour finir, une petite anecdote sur une board que nous avions appelé « Calendar ».

Elle répondait à la problématique suivante : que faire quand une tâche doit être réalisée à un moment donné, pas avant, pas après. Autrement dit, **une tâche qui ne passe pas dans un flow**.

Nous avions alors mis en place une board *TODO > Doing > Done* avec le power-up calendar activé. Chaque carte était attribuée à quelqu'un et était planifiée à une date précise. Ce qui répondait parfaitement au besoin.

Finalement, il y a eu de moins en moins de cartes de ce genre à mesure que l'équipe s'est rôdée avec Kanban et que l'organisation a évolué jusqu'à son état actuel. Chaque cas *« unique, qui ne peut pas fonctionner avec un système Kanban »* (souvent, des tâches marketing / business d'ailleurs) a finalement trouvé sa place dans le flow à mesure que la philosophie Kanban a été intégrée.

Et finalement, j'ai pu fermer cette board devenue inutile… À la demande de l'équipe !
