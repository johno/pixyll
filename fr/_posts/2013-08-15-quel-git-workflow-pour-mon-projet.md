---
layout: post
robots: index,follow
published: true
comments: true

tags: [git, workflow, management, github]
icon: github-3

title: Quel git workflow pour mon projet ?
description: Un petit tour d'horizon sur le git-flow, le GitHub flow et comment choisir le plus adapté à son projet.
---

## TL;DR

L'une des grandes forces de git réside dans la simplicité de son système de branches.<br>
Si vous êtes en charge d'un projet, peut-être vous êtes-vous déjà posé la question : quel workflow mettre en place pour gérer efficacement mon projet, sans me compliquer la vie avec ce sympathique système de branches ?

Et forcèment : à ce problème, certains s'y sont déjà penchés et ont apporté leurs solutions.

Le *git-flow* est probablement le plus connu, voire le seul d'ailleurs.<br>
Il s'agit d'un modèle de branches standard qui semble s'adapter à n'importe quel projet, pas trop complexe à prendre en main, avec quelques subtilités cependant.

<p class="islet">Si la notion de versions a un sens pour votre projet, <a href="#le_gitflow">c'est ce workflow</a> qui peut vous intéresser.</p>

Il existe une alternative pertinente qui a l'avantage d'être bien plus simple : le *GitHub flow*.<br>
Le modèle tient en 6 règles simples qui n'ont pas besoin de prendre en compte les subtilités du workflow précédent.

<p class="islet">Si la notion de versions n'a pas spécialement de sens pour votre projet et que vous souhaitez mettre en place un workflow simplifié, <a href="#le_github_flow">c'est ce workflow</a> qui peut vous intéresser.</p>


## Le git-flow

Ce workflow a été présenté le 5 Janvier 2010 par [Vincent Driessen](https://twitter.com/nvie) comme un workflow de branchements git efficace. Il couvre l'ensemble des besoins standards d'un projet de développement classique.

### Le principe

Le *git-flow* présente le système de branches suivant :

<div class="illustration">
    <img alt="Le célèbre git flow" title="Le célèbre git flow" src="/assets/img/git/git-flow-branching-model.jpg">
    Le modèle git-flow illustré
</div>

On distingue les branches principales, fixes et immuables :

- `master` est la branche où tout est stable. Chaque commit correspond à une version stable du projet (*release*) qui peut être déployée en production et taguée en conséquence (*vX.Y.Z*).

- `develop` est la branche sur laquelle s'effectue le développement proprement dit. On y prépare les changements en vue de la prochaine release dans `master`.

Puis les branches secondaires qui se font et se défont avec le temps :

- `feature` part de `develop` et se merge dans `develop`.

  On crée une branche **feature/xxx** lorsque l'on travaille sur une fonctionnalité en particulier. Lorsqu'elle est terminée, on la merge dans `develop` pour ajouter la feature stable dans le scope de la prochaine release.

- `release` part de `develop` et se merge dans `master` et `develop`.

  On crée une branche **release/xxx** à partir de `develop` lorsque celle-ci reflète l'état désiré de la release (l'ensemble des fonctionnalités du scope ont été mergées). Ainsi, on peut préparer la prochaine release tranquillement, corriger d'éventuels bugs et poursuivre le développement en parallèle.

  Une fois que la release est prête (stable) on merge alors la branche dans `master`, mais aussi dans `develop` pour mettre à jour les modifications apportées.

- `hotfix` part de `master` et se merge dans `master` et `develop` / `release`.

  On crée une branche **hotfix/xxx** lorsque l'on veut résoudre un bug critique en production rapidement. C'est un peu comme une release non planifiée.

  Lorsque le correctif est développé, on le merge dans `master` avec le numéro de version qui convient, ainsi que dans `develop` (ou la branche `release` en cours, le cas échéant) pour mettre à jour les modifications apportées.

### Liens utiles

Je vous suggère de jeter un oeil [sur l'article original](http://nvie.com/posts/a-successful-git-branching-model/) pour en apprendre plus sur la question.

Pour vous simplifier la vie dans le terminal, sachez que l'auteur a également mis au point [une extension git](https://github.com/nvie/gitflow) pour implémenter simplement le *git-flow*.

Enfin, pour les utilisateurs de *SourceTree*, sachez que ce workflow est [nativement implémenté](https://www.atlassian.com/git/workflows#!workflow-gitflow).

<p class="islet">Si vous êtes sous <strong>Windows</strong> ou <strong>Mac</strong> et que vous cherchez un bon client graphique pour git/mercurial, je vous recommande chaudement <a href="http://www.sourcetreeapp.com/">d'essayer SourceTree</a> d'ailleurs !</p>


## Le GitHub flow

[Scott Chacon](https://twitter.com/chacon) l'a présenté dans un post le 31 Août 2011. Il s'agit d'une version allégée du précédent et découle, en quelque sorte, du bon sens.

A noter que je garde ici la référence à GitHub par rapport au superbe post de Scott mais Atlassian (Bitbucket) le présente, par exemple, comme [le workflow *feature branch*](https://www.atlassian.com/git/workflows#!workflow-feature-branch).

### Le principe

Je me suis permis d'illustrer le *GitHub flow* de la manière suivante :

<div class="illustration">
    <img alt="Le GitHub flow" title="Le GitHub flow" src="/assets/img/git/github-flow-branching-model.jpg">
    Le modèle GitHub flow illustré
</div>

Vous constaterez qu'il n'y a qu'une seule branche `master` (pas de `develop` ici) et des features à gogo. Il est frappant de constater que le modèle est **extrêmement simple** et c'est le but. La courbe d'apprentissage est faible, les développeurs prennent rapidement en main ce workflow qui s'avère parfaitement adapté dans certains cas de figures.

Ce workflow se base donc sur 6 règles essentielles :

#### 1. Tout ce qui est dans `master` peut être déployé en production

**La règle** absolue, commune au *git-flow* d'ailleurs. C'est la seule branche consistante du projet et elle doit rester stable pour pouvoir se baser dessus et être déployée en production.

#### 2. Créer des branches explicites depuis `master` (features)

Lorsqu'on souhaite travailler sur quelque chose (une fonctionnalité, un hotfix, etc.), on crée une branche depuis `master` avec un nom explicite, si possible : `bug-grunt-tests`, `infrastructure-ssl` ou `module-game-workers` sont des exemples tirés d'un projet sur lequel je travaille actuellement par exemple.

#### 3. Pousser sur `origin` régulièrement

Contrairement au *git-flow*, où le développeur ne va pas forcément pousser sa branche `feature` locale sur le dépôt central, il s'agit ici de pousser les branches régulièrement.

En effet, tant que nous ne sommes pas sur `master` il importe peu que la branche soit stable. En contrepartie, cela permet de *communiquer* avec l'équipe.

#### 4. Ouvrir une pull-request à tout moment

Si votre projet est hébergé sur GitHub ou Bitbucket, sachez que les deux proposent une fonctionnalité extrêmement intéressante pour la revue de code : les pull-request.

Il est très facile, depuis une branche, de faire un diff avec `master` et d'ouvrir une pull-request à n'importe quel moment : que l'on pense avoir terminé ou que l'on soit coincé, la pull-request permet de demander une revue du code. Il est alors possible de commenter le code, d'apporter des modifications et de visualiser ce que l'on s'apprête à fusionner dans `master`.

#### 5. Fusionner seulement après une pull-request review

Il s'agit plus d'un conseil que d'une règle absolue. Mais c'est la bonne pratique à mettre en place pour s'assurer que la première règle est respectée : un développeur ne doit pas fusionner sa branche dans `master` lorsqu'il pense que c'est bon, un autre doit venir faire une revue du code et confirmer la stabilité de la branche.

<p class="islet">Ainsi, si le merge vient mettre la pagaille sur `master`, on sait sur qui taper... 0:-)</p>

Vous pouvez alors :

- fusionner la branche dans `master`, directement depuis la pull-request
- supprimer la branche, devenue inutile, sur le serveur

Si cela fait un moment que vous travaillez sur votre branche et que vous n'êtes plus synchro avec `master`, **vous ne pourrez pas fusionner directement depuis la pull-request** car il y aura des conflits. Il vous suffit de faire un merge de `master` dans votre branche et règler les potentiels conflits pour la mettre à jour.

#### 6. Déployer immédiatement après merge dans `master`

Une fois que la pull-request est validée, la branche est mergée dans `master` ce qui signifie que le tout est déployé en production (ou va être déployé sous peu).

C'est également une façon d'accentuer la pression sur la nécessaire stabilité de `master` : le développeur ne souhaite généralement pas que le déploiement de ses modifications ne casse tout, il fera donc d'autant plus attention à la stabilité de son code avant de fusionner.

### Quelques remarques

Ce genre de workflow s'adapte parfaitement à un projet pour lequel il n'y a pas vraiment de *releases*, ni de *versions*.

On intègre en continue dans `master` les fonctionnalités et on déploie, parfois plusieurs fois par jour, le projet stable. On revient assez rarement (jamais) en arrière sur `master`.

Ainsi, il est difficile d'ajouter une série de gros bugs. Si des problèmes apparaissent, ils sont rapidement résolus dans la foulée. Il n'y a pas de différence entre une grosse feature et un petit hotfix avec ce process. Peu importe la nature du changement à effectuer, le workflow est toujours le même (et donc très simple à prendre en main).

### Liens utiles

Je vous suggère là encore de jeter un oeil [sur l'article original](http://scottchacon.com/2011/08/31/github-flow.html) pour en apprendre plus sur la question.

Techniquement, GitHub a fait en sorte de vous permettre de gérer ce workflow entièrement, [directement depuis le navigateur](https://github.com/blog/1557-github-flow-in-the-browser). Bitbucket se débrouille pas mal non plus.

Si vous en ressentez le besoin, il y a également [une extension git](https://github.com/github-flow/github-flow) pour implémenter le workflow. Mais dans l'ensemble, il se manie assez bien dans le navigateur.


## Le mot de la fin

Choisir son workflow dépend de la nature et des besoins de son projet. A vous de voir si ces exemples s'adaptent plus ou moins à votre réalité, quitte à faire quelques adaptations si nécessaire.

Voici donc pour les workflows que j'utilise, n'hésitez pas à partager d'autres pistes, d'autres idées.
