---
layout: post
robots: index,follow
published: true
comments: true

tags: [jekyll]

title: Faire son blog avec Jekyll
description: Pourquoi et comment créer son blog avec Jekyll plutôt qu'un bon vieux Wordpress des familles.
---

## Kesako Jekyll ?

[Jekyll](https://github.com/mojombo/jekyll) est un générateur de sites statiques, pensé pour les blogs, développé en *Ruby*, simple à utiliser. Basiquement, une fois que vous avez construit vos templates `.html`, il ne vous reste qu'à rédiger vos articles sous le format qui vous sied le mieux (le *Markdown* me convient tout à fait) et basta, le serveur fait le reste !

C'est [Tom Preston Werner](http://tom.preston-werner.com/), le co-fondateur de Github, qui l'a créé.
D'ailleurs (et surtout), c'est ce qu'utilise [Github Pages](http://pages.github.com/) pour générer vos pages. Basiquement, il suffit de pusher le code sur Github pour l'avoir en ligne (c'est magico-magique).

Le principe de fonctionnement est assez simple, l'architecture rapide à prendre en main. C'est vraiment pensé pour que vous vous concentriez sur le contenu plutôt que le contenant (tout en laissant le plaisir de créer ses templates de A à Z, bien que Github propose également de faire ça à votre place).

## Jekyll plutôt que Wordpress

Quand j'ai finalement voulu créer mon blog, plusieurs options sont venues à moi. Les plus valides étant un site *Wordpress* (ce CMS vaut vraiment le détour) ou bien en passant par *Jekyll*.

Bien que le second ne soit pas aussi populaire que le premier, c'est vers cette solution que je me suis tourné pour les raisons suivantes :

- **Je n'ai pas besoin de base de données** et je ne voulais pas m'encombrer avec de la mise en place (ou de la maintenance) de BDD. Sérieusement, j'ai juste besoin de front-end. C'est du contenu statique, rien d'autre. Pas de brèche de sécurité back-end. Ma seule dépendance c'est mon hébergeur : Github (et encore, ce n'est qu'un dépôt Git comme un autre).
- **Je veux que mon blog se mette à jour dès que je push sur Github**. J'aurais évidemment pu faire un hook pour déployer cela ailleurs, mais cette solution me libère de cette contrainte.
- **Je n'ai besoin de rien à part ce que Jekyll propose**. Il est pensé pour les blogs. Il y a des templates, de la pagination, un peu de logique si besoin, de la configuration et c'est tout.
- **J'aime suivre les nouvelles tendances** et Jekyll fait partie de ces projets innovants et solides qui voient le jour au rythme de l'évolution du web.

Bien entendu il y a beaucoup du fait que, étant développeur, je n'avais pas envie d'utiliser un CMS *prêt-à-porter* pour mon propre blog.

[Wordpress](http://www.wordpress-fr.net/) est un excellent CMS (que je recommande chaudement) qui est facile à prendre en main, dispose d'[une excellente communauté française](http://www.wordpress-fr.net/support/) et qui convient tout à fait à tout blog ou autre site vitrine pour quiconque ne souhaite pas s'embêter avec du code.

Mais en ce qui me concerne, **je veux être au coeur du code**. Je veux développer dans mon IDE. Mais je veux que ce soit simple. Que ça aille droit au but. C'est ce que fait Jekyll.

## Mise en place et configuration

La prise en main de Jekyll n'est pas très complexe, mais vous ne trouverez pas beaucoup de ressources en français (hé, *what did you expect?*). Voici les étapes telles qu'elles sont décrites :

1. [Installez](https://github.com/mojombo/jekyll/wiki/install) le gem (oui, c'est du Ruby).
2. Jetez un coup d'oeil au [fonctionnement](https://github.com/mojombo/jekyll/wiki/usage) et à la [configuration](https://github.com/mojombo/jekyll/wiki/configuration)
3. Créez la structure de base de votre site (vos templates).
4. Créez vos posts ([ou importez-les depuis votre précédente plateforme](https://github.com/mojombo/jekyll/wiki/Blog-Migrations))
5. Lancez votre site en local pour voir le rendu
6. [Déployez](https://github.com/mojombo/jekyll/wiki/Deployment) le tout

#### Structure de Jekyll

{% highlight text %}
.
|-- _includes/      # Bouts de codes à inclure ailleurs
|-- _layouts/       # Vos templates
|   |-- default.html
|   |-- post.html
|-- _plugins/       # Plugins (optionnel)
|-- _posts/         # Vos posts
|   |-- 2013-04-07-faire-son-blog-avec-jekyll.md
|
|-- index.html      # Fichiers html
|-- about.html
|-- (...)
|-- _config.yml     # Fichier de configuration
{% endhighlight %}

Jekyll compile l'ensemble dans un dossier `_site/` contenant votre site statique final.

<p class="islet">
    <code>$ jekyll --server</code> dans un terminal lancera le serveur. L'URL par défaut est donc <code>http://localhost:4000/</code>, ce qui peut être modifié dans la configuration.<br><br>
    <code>$ jekyll --no-server --no-auto</code> compilera simplement le code source sans lancer le serveur (ça peut servir, dans le cadre d'un script de déploiement par exemple).
</p>

#### Créer un post

Basiquement, le code source de mes posts se présente ainsi :

{% highlight text %}
---
layout: post
robots: index,follow
published: true

tags: [jekyll]

title: Faire son blog avec Jekyll
description: Pourquoi et comment créer son blog avec Jekyll plutôt qu'un bon vieux Wordpress des familles.
---

## Kesako Jekyll ?

[Jekyll](https://github.com/mojombo/jekyll) est un générateur de sites statiques, pensé pour les blogs, développé en *Ruby*, simple à utiliser.
{% endhighlight %}

Cette [entête YAML](https://github.com/mojombo/jekyll/wiki/YAML-Front-Matter) permet de configurer mes posts de manière à ce que Jekyll les interprète intelligemment. Ainsi je définis notamment le layout, l'état de publication de l'article, son titre et sa description... Jekyll fait le reste. La suite, c'est du *Markdown*.

## L'hébergement

En ce qui me concerne, j'ai choisi d'héberger mon site directement sur Github. [Github Pages](https://help.github.com/categories/20/articles) permet d'héberger son site statique gratuitement et facilement.

Il suffit de créer un dépôt `username.github.io` (dans mon cas [nicoespeon.github.io](https://github.com/nicoespeon/nicoespeon.github.io)).
Le contenu de la branche `master` est utilisé pour le site statique.
Le site est disponible par l'URL `http://username.github.io`.

Il est également possible d'acheter un nom de domaine (sur OVH ou Gandhi par exemple) et de faire [une redirection DNS](https://help.github.com/articles/setting-up-a-custom-domain-with-pages) :

1. Créez un fichier `CNAME` à la racine du projet, contenant votre nom de domaine (`nicoespeon.com` par exemple)
2. Faîtes pointer **A** vers l'IP de Github `204.232.175.78` (dans les *Zones DNS* chez OVH).
3. Attendez quelques heures le temps que ça se synchronise
4. Dégustez tant que c'est chaud

## Le mot de la fin

C'est tout pour cette petite introduction à l'utilisation de Jekyll. Si l'anglais ne vous rebutte pas, vous trouverez votre bonheur sur Google. Je vous suggère notamment [cet article de Harry Roberts](http://csswizardry.com/2012/12/a-new-css-wizardry/) et [celui-ci de Hugo Giraudel](http://hugogiraudel.com/2013/02/21/jekyll/) (c'est un français !) qui m'ont inspiré et conforté dans mon choix.