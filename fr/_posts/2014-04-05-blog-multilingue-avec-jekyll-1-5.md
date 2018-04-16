---
layout: post
robots: index,follow
published: true
comments: true

tags: [jekyll, i18n]

title: Un blog multilingue avec Jekyll 1.5
description: Retour sur la réalisation d'un blog multilingue avec Jekyll, après upgrade à la v1.5.1.
---

## <span class="icon-info"></span> Note sur la compatibilité

Ce qui suit se base sur l'utilisation de Jekyll `v1.5.1`.

Ce post fait suite à [celui de Mai 2013]({% post_url 2013-05-29-faire-blog-multilingue-avec-jekyll %}) où je vous faisais mon retour d'expérience sur la création d'un blog en plusieurs langue. Depuis Jekyll a (sérieusement) monté en versions et voici les correctifs à apporter en ce sens.


## Petit rappels sur Jekyll

Après bientôt une année d'utilisation (quoiqu'ayant écrit peu d'articles ces derniers mois), voilà ce que je retiens de Jekyll :

- c'est la solution la plus simple pour réaliser un site web front-end avec le confort de la compilation (templates, plugins, etc.). Bien entendu, le fait que GitHub le prenne en charge nativement joue beaucoup en ce sens.
- il bénéficie des avantages et inconvénients de Ruby on Rails (la beauté du langage, la prise de tête de la montée en versions)
- écrire ses articles en Markdown, c'est vraiment pratique
- si le fonctionnement standard ne nous convient pas, libre à nous de le surcharger avec nos propres plugins

En revanche, si vous élaborez vous-même vos plugins, il vous faudra compiler tout d'abord votre site pour envoyer la version statique sur GitHub.


## Speaking Français, ze retour

Pour rappel, voici à quoi ressemble l'architecture de mon blog :

{% highlight text %}
.
|-- _data/          # Stock de variables et configuration
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

Lorsqu'il est lancé, Jekyll génère le site statique final dans le dossier `_site/`. C'est cette version qui est envoyée (et servie) sur GitHub.

<p class="islet">
    <strong>Note</strong> - J'ai retiré de <code>_config.yml</code> les variables qui dépendent de la langue et que je réutilise dans les templates.<br><br>
    Elles sont désormais isolées proprement dans le fichier <code>_data/locales.yml</code>.
</p>

Naturellement, mettre à jour Jekyll de la `v0.12` à la `v1.5` a nécessité quelques arrangements dans le fichier `config.yml`, histoire de retirer ce qui était deprecié et ajouter ce qui manquait.

Egalement, il a fallu toucher aux plugins…


## <span class="icon-gift"></span> Les plugins, ce qui a changé

#### 1. Pagination par catégorie

C'est LE plugin qu'il a fallu modifier, le fonctionnement de la pagination ayant radicalement changé avec Jekyll.

N'ayant rien trouvé de convaincant, j'ai ré-écrit mon propre plugin [category_pagination.rb](https://gist.github.com/nicoespeon/9964343).

Ajoutez-le simplement à votre dossier `_plugins/`, puis configurez votre `config.yml` en fonction du comportement attendu :

- `paginate_per_category: true` si vous souhaitez activer le plugin
- `default_category: "en"` *(optionnel)* si vous souhaitez que la pagination à la racine du projet ne prenne pas en compte tous les posts, mais uniquement ceux d'une catégorie

Le plugin fonctionne très simplement :

1. si je cherche à paginer à l'intérieur d'une catégorie (aka dossier),
2. la pagination ne considèrera que les posts de cette catégorie,
3. je peux définir une catégorie par défaut pour les fichiers qui se trouvent à la racine si je le souhaite (sinon, ça pagine tout).

Je vous laisse jeter un oeil à [fr/index.html](https://github.com/nicoespeon/nicoespeon.github.io/blob/develop/fr/index.html) si besoin.

<p class="islet">
    <strong>Note</strong> - C'est un premier jet qui peut aussi servir de pagination par catégorie de manière assez simpliste et orientée. N'hésitez pas à proposer des améliorations =)
</p>


#### 2. Filtre i18n

[i18n_filter.rb](https://github.com/nicoespeon/nicoespeon.github.io/blob/develop/_plugins/i18n_filter.rb) customise le traitement de `page.date` en fonction de la langue.

J'ai du ajouter un fichier [\_locales/fr.yml](https://github.com/nicoespeon/nicoespeon.github.io/blob/develop/_locales/fr.yml) afin de créer la fonction `localize`. Elle fonctionne de la même manière que `date` mais renvoie le format français de la date.


## Et voilà !

Rien d'autre n'a vraiment changé, juste ces correctifs à apporter et le tour est joué. Si vous avez des suggestions, remarques ou soucis avec tout ça, faîtes-le moi savoir.

Plop !
