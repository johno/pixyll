---
layout: post
robots: index,follow
published: true
comments: true

tags: [jekyll, i18n]

title: Faire un blog multilingue avec Jekyll
description: Un petit état des lieux des choses à savoir et des astuces que je peux vous donner pour réaliser un blog multilingue avec Jekyll.
---

## <span class="icon-info"></span> Note sur la compatibilité

Ce qui suit se base sur l'utilisation de Jekyll `v0.12.1`.

Pour Jekyll `v1.5`, allez jeter un oeil à [celui d'Avril 2014]({% post_url 2014-04-05-blog-multilingue-avec-jekyll-1-5 %}).

Veuillez noter que des changements majeurs sont survenus lors du passage à la `v1.0.0`, rendant certaines de ces astuces non compatibles (je pense surtout aux plugins). Je rédigerai un nouvel article lorsque je mettrais à jour mon propre Jekyll à une version v1.0+.

Si vous le souhaitez, vous pouvez toujours installer une ancienne version de Jekyll avec la commande suivante :

{% highlight bash %}
# Installe l'ancienne version de jekyll
$ sudo gem install jekyll --version 0.12.1

# Désinstalle la version actuelle si vous l'avez téléchargée
$ sudo gem uninstall jekyll --version <your current version>
{% endhighlight %}


## Petit retour sur Jekyll

J'ai commencé ce blog avec [un article présentant Jekyll]({% post_url 2013-04-07-faire-son-blog-avec-jekyll %}) et ce qui m'avait amené à ce choix.

Pour résumer l'intérêt de ce "générateur de site dynamique" par rapport à un CMS tout prêt tel que Wordpress, j'avais avancé les points suivants :

- **Pas besoin/envie de m'embêter avec une BDD**. Restons simple et faisons du front-end.

- **Pouvoir mettre mon site à jour quand je push sur Github**. J'aurais évidemment pu mettre en place des hooks pour reproduire le même comportement sur un serveur, mais c'est totalement inutile grâce à Jekyll et [Github Pages](https://help.github.com/categories/20/articles).

- **Suivre les dernières tendances en matière de développement web**. L'expérience Jekyll me paraissait donc tentante, j'ai succombé.

Simplement, Jekyll est adapté pour du blogging... mais du blogging en anglais (et voui). Par défaut, il n'est donc pas vraiment optimisé pour le français et encore moins pour créer un blog multilingue.

Bien entendu, c'est tout à fait possible si l'on sait ruser et mettre un peu les mains dans le cambouis. Je me propose donc ici de vous expliquer les quelques étapes dont vous aurez besoin si vous souhaitez pouvoir blogger dans 2 langues, ou plus.


## Do you parler Français ?

Le meilleur exemple de la nature *english oriented* de Jekyll est certainement [le filtre Liquid `date`](http://liquid.rubyforge.org/classes/Liquid/StandardFilters.html#M000012). Ce dernier permet de retourner très simplement la date de publication d'un post, par exemple, mais dans le format anglais ! Certes, si vous vous contentez des chiffres ça passera sans problème. En revanche ça risque de faire tâche d'avoir des `19 April, 2013` qui trainent un peu partout sur votre blog francophone.

Le deuxième soucis majeur se pose lorsque vous souhaitez **distinguer les articles en fonction de leur langue**, pour proposer 2 pages d'index différentes par exemple. La bonne idée qui vous vient, c'est naturellement de créer une catégorie par langue. Mais le `paginator` Jekyll, qui vous permet d'afficher le listing paginé des posts de votre site, n'a pas été créé pour gérer les catégories. Cela pose un léger soucis puisque vous allez vous retrouver à choisir entre :

1. Tous les posts d'une catégorie, listés sur une seule page
2. Un listing de X posts par page, toutes catégories (langues) confondues

Bref, autant d'obstacles qui pimentent un peu le challenge. Voyons comment s'en sortir malgré tout.

#### Parlons stratégie

Prenons le problème à l'envers, et définissons ce que nous souhaitons obtenir pour commencer :

- Nous voulons que l'anglais soit la langue par défaut, à la racine de projet.
- Chaque langue représente une catégorie, ce qui peut être aisément retranscrit avec l'architecture des dossiers.
- La partie française doit être accessible à partir de l'URL de base `/fr` (ce qui se goupille pas trop mal avec les précédentes considérations).
- Les articles en anglais doivent être listés uniquement sur `index.html`
- Les articles en français doivent être listés uniquement sur `index.html/fr`
- La pagination doit gérer la distinction anglais/français.
- Ca doit rester simple !

Élaborons donc l'architecture de nos fichiers source d'après ce que nous venons de dire :

{% highlight text %}
.
|-- _includes/      # Bouts de codes inclus ailleurs
|-- _layouts/       # Templates du site
|-- _plugins/       # Plugins pour surcharger de Jekyll
|-- assets/         # LESS/CSS, JS, images, ...
|-- fr/             # Categorie FR
|   |-- _posts/     # Articles en français
|   |-- index.html  # Pages html en français
|   |-- about.html
|   |-- (...)
|
|-- en/             # Catégorie EN
|   |-- _posts/     # Articles en anglais
|
|-- index.html      # Pages html par défaut (EN)
|-- about.html
|-- (...)
|-- _config.yml     # Fichier de configuration de Jekyll
{% endhighlight %}

Lorsqu'il est lancé, Jekyll génère le site statique final dans le dossier `_site/`.

<p class="islet">
    <strong>Note</strong> - Personnellement, j'utilise le fichier <code>_config.yml</code> pour y mettre des variables qui dépendent de la langue et que je réutilise dans les templates.<br><br>
    Ce n'est pas <strong>la solution la plus propre</strong> selon moi, mais c'est assez facile à mettre en place et cela fonctionne plutôt bien pour le moment (tant qu'il n'y en a pas trop). Cela changera à l'avenir lorsque je me serais penché sur une manière plus élégante pour faire ça.
</p>


## <span class="icon-gift"></span> Les plugins en renfort

Pour résoudre les problèmes que nous avons soulevé plus tôt, j'ai mis en place 2 petits plugins qui vont surcharger le workflow classique de Jekyll pour le plier à notre volonté (c'est qui l'patron ?).

#### 1. Pagination par categorie

[category_pagination.rb](https://github.com/nicoespeon/nicoespeon.github.io/blob/develop/_plugins/category_pagination.rb) modifie le fonctionnement du `paginator` afin de prendre seulement en compte les articles qui correspondent à la catégorie spécifiée, et ainsi pouvoir distinguer les deux.

J'ai modifié le plugin original afin de définir l'anglais comme catégorie par défaut à la racine au lien d'afficher tous les `site.posts`.

#### 2. Filtre i18n

[i18n_filter.rb](https://github.com/nicoespeon/nicoespeon.github.io/blob/develop/_plugins/i18n_filter.rb) customise le traitement de `page.date` en fonction de la langue.

J'ai du ajouter un fichier [\_locales/fr.yml](https://github.com/nicoespeon/nicoespeon.github.io/blob/develop/_locales/fr.yml) afin de créer la fonction `localize`. Elle fonctionne de la même manière que `date` mais renvoie le format français de la date.


## Le point Github

Les plugins sont installés, les templates sont élaborés, le design est mis en place, le git flow est prêt ainsi que le dépôt sur Github... *Pushons joyeusement !*

Je constate que [la redirection DNS de mon domaine perso](https://help.github.com/articles/setting-up-a-custom-domain-with-pages) fonctionne à merveille mais... erf. Le résultat n'est vraiment pas celui attendu !

Yep, pour ceux qui l'auraient remarqué tout comme moi à ce moment là, Github lance Jekyll en mode `--safe`, ce qui veut dire que **les plugins sont désactivés**.

Au revoir pagination par catégorie et filtre i18n.

#### A chaque problème, sa solution ...

... et Google votre meilleur ami.

[J'ai pu trouver l'inspiration](http://charliepark.org/jekyll-with-plugins/) pour redéfinir mon workflow git et contourner ce nouveau problème en ce qui me concerne. C'est ce que je vous propose très concrètement ci-dessous.

#### Un petit retour sur le workflow et les branches

Nous allons considérer que notre workflow comporte 2 branches distinctes :

1. La branche `master`, qui correspond au site final compilé. Il est généré par Jekyll dans le dossier `_site/` lors de la compilation et Github peut très bien héberger directement un site statique avec l'ajout [d'un fichier `.nojekyll`](https://github.com/nicoespeon/nicoespeon.github.io/blob/master/.nojekyll).

2. La branche `develop`, qui correspond aux fichiers sources puisque nous avons besoin de les versionner. Ces fichiers seront compilés par Jekyll lors du déploiement, afin de commiter le rendu sur la branche `master`.

Il n'y a pas de merge de `develop` dans `master` avec ce workflow. Il s'agit de deux branches évoluant en parallèle avec une version source du code pour l'une, et compilée pour l'autre.

Le déploiement consiste à compiler le code source de la branche de développement (`develop`) et à venir committer ces changements sur la branche de production (`master`).

#### Deux branches parallèles WTF ?

Bien que cela sorte de la vision classique des branchements aka *"tout le modèle de branches part d'un ancêtre commun"*, Git permet également de créer de nouvelles branches n'ayant pas d'ancêtre commun avec le commit sur lequel nous nous trouvons. Un peu comme un nouveau projet dans le projet.

C'est ce que l'on appelle **des branches orphelines**.

Pour créer une telle branche, c'est très simple :

{% highlight console %}
$ git checkout --orphan <new branch>
{% endhighlight %}

Dans notre cas, considérons donc que notre branche initiale (par défaut) soit `develop`. Il s'agit donc de créer une branche `master` depuis cette branche afin d'y versionner la version compilée de notre site :

{% highlight console %}
$ git checkout --orphan master
{% endhighlight %}

Il suffit donc de considérer cette branche comme une version alternative de votre code.

Supprimez tout ce qui n'a rien à y faire (les fichiers sources) et faîtes en sorte d'y versionner le code final, compilé (celui qui se trouve normalement dans le répertoire `_site/` du code source).

<p class="islet">
    En ce qui me concerne, j'avais déjà pushé les premiers commits quand je me suis rendu compte de mon erreur. Mon workflow initial se basait sur des merge de <code>develop</code> dans <code>master</code>.<br><br>
    Mais plutôt que de recréer l'ensemble du dépôt et de rebaser tout ça, j'ai décidé de conserver cet historique en corrigeant le tir avec quelques commits. Il n'y a pas à rougir de faire des erreurs après tout, c'est ainsi qu'on apprend.
</p>

#### Déployer comme un prince

L'idée de base à présent, c'est de travailler sur vos fichiers sources dans `develop`. Puis, il faut que vous compiliez votre code, que vous changiez de branche, supprimiez ce qui n'a rien à faire là et ne conserviez que le code du site compilé final. La manière de procéder pour en arriver là est à votre entière disposition, tout dépend de votre façon de fonctionner.

Pour ma part, j'ai 2 solutions à vous proposer pour vous permettre de déployer tout ça plus facilement (= sans avoir à vous taper le process à la main) :

1. Vous vous faîtes un petit script de build qui vous permet de faire tout ça en une ligne de commande. C'est le cas de [mon Makefile](https://github.com/nicoespeon/nicoespeon.github.io/blob/develop/Makefile) qui me permet de déployer en lançant un simple `make deploy` dans mon terminal. Libre à moi de pusher ensuite.

2. Vous pouvez aller jeter un oeil à [git publish](https://github.com/prost87/git-publish-pages) qui est un script que vous pouvez rajouter à Git et qui vous permettra de déployer des sites Jekyll avec ce workflow justement (quand on vous dit que d'autres y ont pensé avant vous).


## Et voilà !

Nous y voilà, cela devrait fonctionner parfaitement à présent. Avec ces petits conseils vous devriez être en mesure de faire votre blog Jekyll, hébergé sur Github et multilingue *\o/*

Comme d'habitude, nhésitez pas à émettre commentaires, suggestions, remarques et autres questions qui vous trotteraient dans la tête, si besoin, ci-dessous.

Plop !
