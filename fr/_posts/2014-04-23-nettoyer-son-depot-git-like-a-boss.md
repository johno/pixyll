---
layout: post
robots: index,follow
published: true
comments: true

gitgraph: true
script: 2014-04-23-git-like-a-boss

tags: [git]
icon: github-3

title: Nettoyer son dépôt git, like a boss
description: Ou comment rebase proprement son dépôt pour retirer ce qui n'aurait jamais du y être commit, tout en conservant l'historique (si si, c'est possible).
---

## Le contexte

Un dépôt git, à l'image du projet qu'il contient, peut avoir une vie longue et tumultueuse au cours de laquelle les conventions évoluent avec nos connaissances et notre maîtrise du schmilblick.

Aussi, il se peut que ce jour arrive où vous contempliez votre projet et réalisiez qu'en fait non, ce n'était pas une si bonne idée que de versionner ces *librairies externes / fichiers compilés / vidéos et autres assets / &lt;votre boulette ici&gt;*.

Pour ma part, j'ai pas mal enchaîné les boulettes avec le temps :

- une fois, j'ai réalisé un peu tard que versionner un paquet de fichiers audio dans un projet l'alourdissait de manière indécente. 5 minutes pour faire un `git clone`, c'est un peu *ouate-ze-foque*.
- il n'y a pas si longtemps encore, j'ai même réussit à versionner l'ensemble du dossier `vendor/` d'un projet s'en m'en rendre compte. Et vlan les jolies stats GitHub du projet ; difficile de suivre son activité quand on a un pic de 20.000 modifications la première semaine.

Or c'est dans ce genre de cas qu'on réalise que :

- il est inutile de revert le(s) commit(s) fautif(s), ça ne supprimera pas les modifications indexées dans l'historique
- le projet n'est plus tout jeune, ça nous ferait mal de rebase les commits des 3 derniers mois et perdre l'auteur / la date de ceux-ci en les ré-écrivant
- et même que parfois on a commit ses fichiers fautifs par-ci par-là au milieu d'autres modifications d'un beau commit

Un dernier cas de figure ? Suffit d'imaginer Bernard qui, s'en trop le vouloir, a commit par erreur des informations un peu confidentielles dans un fichier de conf d'environnement qui n'aurait jamais du être versionné (sisi, ça arrive).

Bref, c'est dans ce genre de situation qu'on se résigne ou que l'on retourne l'Internet en quête de la commande git magique. Et ça tombe plutôt bien, parce-que c'est celle-là même que je vais vous proposer (enfin celle que je connais).

## Magic happens here

Admettons par exemple que je souhaite **supprimer tous les MP3s versionnés par erreur** dans l'ensemble de mon projet.
 Et ce, **sans changer les auteurs des commits**, **ni même les dates**, mais en supprimant tout de même toute trace de ces fichiers (histoire de réduire considérablement la taille de mon dépôt, par exemple).

Et donc pour cela, j'ouvre mon terminal et je lance l'incantation suivante :

{% highlight bash %}
git filter-branch -f --tree-filter "rm -rf *.mp3" --prune-empty -- --all
{% endhighlight %}

Ce qui me permet donc, en partant de ce genre d'historique :

<div><!-- This div is a bit nasty but necessary for Jekyll/Markdown to correctly compile the canvas -->
  <canvas id="dirty-repo"></canvas>
</div>

De me retrouver avec un dépôt propre comme un sous neuf :

<div><!-- This div is a bit nasty but necessary for Jekyll/Markdown to correctly compile the canvas -->
  <canvas id="clean-repo"></canvas>
</div>

Les dates de commit sont conservées, les auteurs aussi, ce qui ne serait pas le cas avec un rebase classique. Toutefois, l'historique est **bel et bien ré-écrit** : les SHA1 des commits qui ont été modifiés sont différents.

## C'est sorcellerie !?

Voyons un peu ce que ce que cache cette loooongue commande magico-magique.

### `git filter-branch`

La commande `filter-branch` de git permet de ré-écrire un grand nombre de commits de manière scriptable. Autrement
dit, c'est ce qui va permettre de ré-écrire complètement l'historique en fonction des paramètres que nous allons
passer ensuite.

### `-f`

L'option `-f` permet de forcer le démarrage de `git filter-branch` si jamais il y a déjà un dossier temporaire `refs/original/` pré-existant. Git s'en sert pour faire une sauvegarde de l'historique avant de partir à l'aventure.

Le `-f` n'est donc pas obligatoire mais si le backup ne peut pas être créé, git vous dira de relancer la commande avec cette option.

### `--tree-filter "<shell command>"`

Cette option va vous permettre de passer en revue chacun de vos commits et d'y exécuter la commande que vous aurez passé en paramètre.

Pour ma part, j'ai utilisé `rm -rf *.mp3` pour m'assurer de bien supprimer l'ensemble des fichiers MP3s qui pouvaient être versionnés. Dans un tel cas, il faut s'assurer de forcer la commande (d'où le `-rf`) car le nettoyage s'arrête s'il y a une erreur à base de *fichier-mp3-non-trouvé-dans-ce-commit*.

<p class="islet"><strong>Note</strong> - Au cas où vous ne voudriez pas vraiment supprimer les fichiers mais juste les retirer de l'historique git, préférez l'utilisation de la commande <code>--index-filter "git rm -rf --cached --ignore-unmatch *.mp3"</code> à la place.</p>

### `--prune-empty`

On s'assure de bien supprimer les commits qui seraient éventuellement vides, une fois l'historique nettoyé.

### `-- --all`

Le premier `--` permet de distinguer `--all` comme une options supplémentaire, et non pas un paramètre de `--prune-empty`. Et donc cela permet de dire à git de réaliser son opération sur toutes les branches de l'historique.

## Le mot de la fin

Si vous travaillez à plusieurs sur le projet, n'oubliez pas que **ré-écrire l'historique, c'est pas anodin** (et ce,
peu importe la méthode). Du coup, si vous êtes amené à faire ce genre de manipulation pour le bien du dépôt,
le plus simple reste pour les autres de re-cloner le nouveau dépôt tout propre, tout simplement.

Et si vous craigniez que votre manipulation ne fonctionne pas comme prévu, clonez simplement le dépôt quelque part avant de faire votre tambouille et vous pourrez toujours le récupérer si jamais ça ne se passe pas bien.

<p class="islet"><strong>Note</strong> - Une bonne idée serait de faire ce genre d'opérations dans un branche à part. Si le résultat est convaincant, alors il n'y aura plus qu'à faire un reset hard de `master` sur cette branche.</p>

Voilà, en espérant que ça puisse vous dépanner... mais que vous n'ayez pas à vous en servir trop souvent !
