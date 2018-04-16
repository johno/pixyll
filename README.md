# About this

This is [@nicoespeon](https://twitter.com/nicoespeon)'s blog uncompiled source code.

The website is built upon [Jekyll](https://github.com/mojombo/jekyll) and [inuit.css](http://inuitcss.com/) from the excellent [@csswizardry](https://twitter.com/csswizardry).

The `master` branch is the Jekyll compiled website so that Github can deliver it directly, thanks to the `.nojekyll` file. The `develop` branch is the source files, which would be compiled with Jekyll.

In fact, I wanted to build a both French and English blog. To do so, I needed few plugins. But Github is running Jekyll in `--safe` mode, which means **without plugin**. And so I should deploy the whole `_site/` on the `master branch to continue with Github hosting (and delete the source file in that branch).

---

*Ceci est le code source non-compilé du blog de [@nicoespeon](https://twitter.com/nicoespeon).*

*Le site est construit grâce à [Jekyll](https://github.com/mojombo/jekyll) et [inuit.css](http://inuitcss.com/) de l'excellent [@csswizardry](https://twitter.com/csswizardry).*

*La branche `master` est la version compilée par Jekyll afin que Github puisse la livrer directement, grâce au fichier `.nojekyll`. La branche `develop` contient les fichiers sources, compilés par Jekyll.*

*En fait je souhaitais créer un blog à la fois en Français et en Anglais. Pour ce faire j'avais besoin de quelques plugins. Mais Github lance Jekyll en mode `--safe`, donc __sans plugin__. C'est pourquoi je dois déployer le `_site/` complet sur la branche `master` pour continuer avec l'hébergement Github (en supprimant les fichiers sources de cette branche).*