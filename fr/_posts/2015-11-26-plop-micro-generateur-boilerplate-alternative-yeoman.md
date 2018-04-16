---
layout: post
robots: index,follow
published: true
comments: true

tags: [plop, yeoman, générateur, node.js]
icon: console

title: Plop — un micro-générateur pour se simplifier la vie au quotidien
description: Découvrez plop, un petit paquet node qui permet de bootstrap rapidement de nouveaux fichiers.
---

## Vidéo & Slides

J’ai présenté ce talk le 21 décembre 2015 au [meetup Node.js Paris Chapitre 3 / Conférence 2](http://www.meetup.com/fr-FR/Nodejs-Paris/events/227335326/).

<iframe width="560" height="315" src="https://www.youtube.com/embed/1GyoY6V-0ss?rel=0" frameborder="0" allowfullscreen></iframe>

<iframe src="http://slides.com/nicoespeon/plop-alternative-yeoman/embed" width="576" height="420" scrolling="no" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>

## Kezako plop ?

[Plop](https://github.com/amwmedia/plop) c'est un petit paquet node qui permet de se simplifier la vie quand on veut créer un nouveau controller / router / helper / …

> Bah créer un nouveau controller c'est facile : je copie-colle le code d'un autre controller et je supprime les lignes dont je ne me sers pas. Tadaaa !

Certes, mais viennent un certain nombre de questions légitimes :

- Quel "autre" controller ? Le plus récent ? Le "mieux" codé ? Y a-t-il un controller de référence ?
- Si je ne suis pas (encore) un expert du projet en question, comment répondre au point précédent ?
- Comment m'assurer que je ne me trompe pas en nommant le nouveau fichier ? En supprimant les lignes qui sont "inutiles", selon moi ?
- Est-ce-que je dois déclarer ce nouveau controller quelque part dans un fichier existant ? Lequel ? Comment ?

Trouver un bon fichier, l'ouvrir, copier son contenu, créer un nouveau fichier, coller le contenu, supprimer les lignes inutiles… C'est répétitif, propice aux erreurs et ça n'a pas beaucoup de valeur ajoutée. En plus, ça peut prendre un peu de temps. Surtout, c'est fréquent !

Ce serait vachement mieux à la place d'écrire `plop` dans son terminal, répondre à 2 questions et BIM, c'est fait !

<div class="illustration">
    <img alt="Comportement de Plop" title="Comportement de Plop" src="/assets/img/plop/plop-behavior.gif">
    Simple et efficace. Toujours tenté(e) par l'option copier-coller ?
</div>

C'est exactement ce que nous allons voir ici.

## Setup

### Installation

Plop étant un paquet node, `npm install -g plop` et vous pouvez commencer à jouer.

On peut aussi l'installer localement sur le projet en le rajoutant aux dépendances : `npm install --save-dev plop`.

Puis ajoutez-le aux scripts de votre `package.json` pour pouvoir le lancer avec `npm run plop` :

{% highlight json %}
{
  "name": "your-awesome-project",
  "description": "This is an awesome project, isn't it?",
  
  "dependencies": {},
  "devDependencies": {
    "plop": "1.0.1"
  },
  
  "scripts": {
    "plop": "plop"
  }
}
{% endhighlight %}

Voilà !

### Configuration

Plop se base sur un `plopfile.js`. 

C'est le fichier de configuration standard, que je vous suggère de placer à la racine du projet :

{% highlight javascript %}
module.exports = ( plop ) => {

  // C'est ici qu'on va configurer nos générateurs

};
{% endhighlight %}

Plop va également se baser sur des templates qui peuvent soit être inlined dans le fichier de configuration, soit placés dans des fichiers séparés. Je vous suggère de les placer dans un dossier `plop-templates/`, à la racine du projet également.

### All inclusive FTW

Comme vous l'aurez compris : le générateur et les templates sont embarqués dans le projet, à l'instar des tests ou du task runner (brunch, gulp, grunt…).

Cela a **des avantages considérables** sur un [générateur Yeoman personnalisé](http://yeoman.io/authoring/) :

- un seul dépôt à maintenir
- tout est déjà embarqué dans le projet, nul besoin d'installer yeoman et ledit générateur pour pouvoir s'en servir
- mettre à jour un template est trivial, pas besoin de publier une nouvelle version du générateur et s'assurer que tout est à jour avant de l'utiliser

Finalement, là où un développer un générateur Yeoman spécifique au projet est overkill, plop est parfaitement adapté. Léger, près du code source, il sera **plus facilement adopté**, maintenu et, en fin de compte, **utilisé**.

## Notre premier générateur

Pour déclarer un générateur, `plop` nous fournit la méthode `setGenerator` :

{% highlight javascript %}
{% raw %}
module.exports = ( plop ) => {

  // On déclare un nouveau générateur appelé "module"
  plop.setGenerator( "module", {
  
    // Décrit succintement ce que fait le générateur 
    // pour s'y retrouver.
    description: "Create a new module",
    
    // Récupère les inputs de l'utilisateur.
    // C'est Inquirer.js qui fait le job ici.
    prompts: [
      {
        type: "input",
        name: "name",
        message: "What is your module name?"
      }
    ],
    
    // Liste des actions à faire.
    // Ici, on "add" de nouveaux fichiers à partir 
    // de nos templates.
    actions: [
      {
        type: "add",
        path: "app/modules/{{camelCase name}}.js",
        templateFile: "plop-templates/module.js"
      },
      {
        type: "add",
        path: "app/tests/{{camelCase name}}.tests.js",
        templateFile: "plop-templates/module.tests.js"
      }
    ]
    
  } );

};
{% endraw %}
{% endhighlight %}

### Prompts

La partie `prompts` est directement déléguée à [Inquirer.js](https://github.com/SBoudrias/Inquirer.js/).

Vous pouvez donc vous référez à [leur documentation](https://github.com/SBoudrias/Inquirer.js/#objects) pour découvrir tout ce que vous pouvez faire (type des questions, filtre d'output, validation d'input…).

On peut ainsi imaginer des choses un peu plus complexes : 

{% highlight javascript %}
import {trimRight, isEmpty} from "lodash";

const ensurePlural = ( text ) => trimRight( text, "s" ) + "s";

const isNotEmptyFor = ( name ) => {
  return ( value ) => {
    if ( isEmpty( value ) ) return name + " is required";
    return true;
  }
}

module.exports = ( plop ) => {

  plop.setGenerator( "module", {
  
    // …
    
    prompts: [
      {
        type: "input",
        name: "name",
        message: "What is your module name?",
        validate: isNotEmptyFor( "name" ),
        filter: ensurePlural
      }
    ],
    
    // …
    
  } );

};
{% endhighlight %}

`validate` va s'assurer que le nom donné pour le module n'est pas vide.

`filter` me permet de formaliser l'output : tous les noms des modules doivent se terminer par un `s`. Ainsi, si par inadvertance je nomme mon module `calendar`, je suis assuré que la variable `name` vaudra `calendars` pour la suite.

### Actions

Une fois qu'il sait tout, plop va réaliser l'ensemble des `actions` qu'on lui demande. Il dispose à ce moment là des variables que lui fournit inquirer.

Les actions, comme les templates, sont parsées avec [Handlebars](https://github.com/wycats/handlebars.js/). Si vous avez compris son fonctionnement, vous savez déjà utiliser plop.

{% raw %}
Ainsi `{{name}}` correspond à la réponse donnée au prompt, validée et filtrée au préalable. Il me suffit de la placer où bon me semble, dans le chemin du fichier créé et/ou son template.
{% endraw %}

Il faut savoir qu'il y a 2 types d'actions supportés pour le moment :

- `"add"` qui va créer un nouveau fichier au niveau du `path` indiqué (relatif à `plopfile.js`)
- `"modify"` qui va modifier le fichier situé au niveau du `path`. Il va remplacer la RegExp définie dans `pattern` par le template

Pour les 2 actions on peut soit utiliser un template inline via `template`, soit spécifier le chemin du template à utiliser via `templateFile`.

#### Un exemple concret

Ça peut donner quelque chose du genre :

{% highlight javascript %}
{% raw %}
const modulePath = "app/modules/{{camelCase name}}.js";

module.exports = ( plop ) => {

  plop.setGenerator( "model", {
  
    // …
    
    actions: [
        // Ajoute un nouveau model + boilerplate de tests.
        {
          type: "add",
          path: "app/modules/{{camelCase name}}.model.js",
          templateFile: "plop-templates/model.js"
        },
        {
          type: "add",
          path: "app/tests/{{camelCase name}}.model.tests.js",
          templateFile: "plop-templates/model.tests.js"
        },
        
        // Modifie le module pour y injecter le model créé.
        // Tout fonctionne avec un replace de RegExp.
        {
          type: "modify",
          path: modulePath,
          pattern: /(\/\/ IMPORT MODULE FILES)/g,
          template: "$1\nimport Model from \"./{{camelCase name}}.model\";"
        },
        {
          type: "modify",
          path: modulePath,
          pattern: /(const namespace = "\w+";)/g,
          template: "$1\n\nModel = Model.extend( { namespace: namespace } );"
        }
    ]
    
  } );

};
{% endraw %}
{% endhighlight %}

À partir du template `plop-templates/model.js` :

{% highlight javascript %}
{% raw %}
/**
 * TODO - Describe what your model does.
 *
 * @class         {{pascalCase name}}.Model
 * @module        {{pascalCase name}}
 * @constructor
 */
import {Model} from "backbone";

export default Model.extend( {

  initialize() {
    // Executed on model initialization
  }

} );
{% endraw %}
{% endhighlight %}

{% raw %}
Si `{{name}}` vaut `calendars`, alors plop va créer le fichier `app/modules/calendars.model.js` suivant :
{% endraw %}

{% highlight javascript %}
/**
 * TODO - Describe what your model does.
 *
 * @class         Calendars.Model
 * @module        Calendars
 * @constructor
 */
import {Model} from "backbone";

export default Model.extend( {

  initialize() {
    // Executed on model initialization
  }

} );
{% endhighlight %}

Et va transformer notre `app/modules/calendars.js` actuel :

{% highlight javascript %}
import Module from "core/module";
import _ from "lodash";

// IMPORT MODULE FILES

const namespace = "calendars";

export default Module.extend( {

  initialize() {
    _.defaults( this.options, { isDisplayed: true } );
  },

  onStart() {
    this.ready();
  },

  onReady() {
    // Do something when module is considered as ready
  }

} );
{% endhighlight %}

Pour y insérer le model créé :

{% highlight javascript %}
import Module from "core/module";
import _ from "lodash";

// IMPORT MODULE FILES
import Model from "./calendars.model";

const namespace = "calendars";

Model = Model.extend( { namespace: namespace } );

export default Module.extend( {

  initialize() {
    _.defaults( this.options, { isDisplayed: true } );
  },

  onStart() {
    this.ready();
  },

  onReady() {
    // Do something when module is considered as ready
  }

} );
{% endhighlight %}

Avec `"add"` et `"modify"` il est possible de faire un paquet de petites choses répétitives plus simplement.

#### Adapter les actions en fonction des réponses données

[Vous pouvez également passer une fonction à `actions`](https://github.com/amwmedia/plop/pull/1). Cette fonction prend en paramètre les réponses de l'utilisateur et doit retourner le tableau des actions à effectuer.

L'intérêt c'est de pouvoir **adapter les actions en fonction des réponses données**.

Prenons l'exemple de la création d'un nouveau module :

{% highlight javascript %}
{% raw %}
module.exports = ( plop ) => {

  plop.setGenerator( "module", {
      
    prompts: [
      {
        type: "input",
        name: "name",
        message: "What is the name of your module?",
        validate: isNotEmptyFor( "name" ),
        filter: ensurePlural
      },
      {
        type: "list",
        name: "dataConfig",
        message: "Tell me about the data, what do you need?",
        default: "none",
        choices: [
         { name: "Nothing", value: "none" },
         { name: "A Model", value: "model" }
        ]
      }
    ],
    
    actions: ( data ) => {
      // Ajoute un nouveau module quoiqu'il en soit.
      let actions = [
       {
         type: "add",
         path: "app/modules/{{camelCase name}}/{{camelCase name}}.js",
         templateFile: "plop-templates/module.js"
       },
       {
         type: "add",
         path: "app/modules/{{camelCase name}}/tests/{{camelCase name}}.tests.js",
         templateFile: "plop-templates/module.tests.js"
       }
      ];
         
      // Si l'on souhaite un modèle, alors on en ajoute un
      // dans la foulée.
      if ( data.dataConfig === "model" ) {
       actions = actions.concat( [
        {
          type: "add",
          path: "app/modules/{{camelCase name}}.model.js",
          templateFile: "plop-templates/model.js"
        },
        {
          type: "add",
          path: "app/tests/{{camelCase name}}.model.tests.js",
          templateFile: "plop-templates/model.tests.js"
        },
       ] );
      }
      
      // Retourne le tableau des actions à réaliser.
      return actions;
    }
      
  } );

};
{% endraw %}
{% endhighlight %}

Le générateur peut donc s'adapter aux réponses que l'on donne et prendre en compte un certain nombre de scénarios (un module avec un Model, une Collection + Model, avec une CollectionView ou bien une CompositeView…).

### Helpers

Un petit point sur les helpers de templating de plop : ce sont [ceux de Handlebars](http://handlebarsjs.com/expressions.html#helpers).

{% raw %}
Il y a déjà un certain nombre de [helpers fournis par plop](https://github.com/amwmedia/plop#baked-in-helpers). `camelCase`, par exemple, fonctionne ainsi : `{{camelCase name}}` avec `name = "my awesome module"` donne `"myAwesomeModule"`.
{% endraw %}

Vous pouvez définir vos propres helpers dans le `plopfile.js` avec `addHelper` :

{% highlight javascript %}
module.exports = ( plop ) => {

  plop.addHelper( "upperCase", ( text ) => text.toUpperCase() );
  
  // …
    
};
{% endhighlight %}

{% raw %}
On vient de créer un helper `upperCase` que l'on pourra utiliser dans les `actions` et les templates : `{{upperCase name}}`.
{% endraw %}

### Just use it

Et c'est tout, il ne reste plus qu'à lancer `npm run plop` (ou `plop`, si vous l'avez installé globalement) et se laisser guider.

On peut aussi directement appeler un générateur avec `npm run plop [generatorName]`.

À l'usage plop est rapide et efficace tout comme Yeoman. Par contre, il est bien plus léger et simple à maintenir.

## Retour d'expérience en production

À l'heure actuelle, j'utilise plop avec mon équipe sur le projet [Vinoga](http://vinoga.com). Ses fonctionnalités conviennent parfaitement à nos use cases. 

J'avais développé un générateur Yeoman auparavant, largement inutilisé par l'équipe en pratique.

Vraiment, plop est le genre d'outil qui nous fait gagner 10 minutes par-ci par-là au quotidien. Et lancer `plop module` dans sa console, c'est plutôt cool \o/
