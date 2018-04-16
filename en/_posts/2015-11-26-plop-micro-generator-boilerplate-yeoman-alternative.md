---
layout: post
robots: index,follow
published: true
comments: true

tags: [plop, yeoman, generator, node.js]
icon: console

title: Plop — a micro-generator to ease your daily life
description: Meet plop, a little node package which quickly bootstraps new files.
---

## What's plop?

[Plop](https://github.com/amwmedia/plop) is a little node package that will ease your life whenever you need to create a new controller / router / helper / …

> Hey, that's damn easy to create a new controller: copy-paste another controller code, delete specific lines you won't use. Tadaaa!

Well, now pop a bunch of legitimate questions:

- Which "other" controller do you speak about? The more recent? The "best" coded? Is there any reference controller around there?
- How can I get the previous point if I'm not — yet — an expert of the project codebase?
- How can I ensure I'm correct when I name the new file? When I delete lines I consider "useless"?
- Do I need to declare this new controller in some existing file? Which one? How?

Find a good file, open it, copy its content, create a new file, paste the content, delete useless lines… It's repetitive, error prone and doesn't have a lot of added value. And that could take some time. Most of all, that's frequent!

It would just be awesome to write `plop` in your terminal, answer 2 questions and BIM, you're all set!

<div class="illustration">
    <img alt="Plop behavior" title="Plop behavior" src="/assets/img/plop/plop-behavior.gif">
    Quick, neat. Still tempted whith the copy-paste option?
</div>

That's exactly what I'm talking about here.

## Setup

### Installation

As a node package, `npm install -g plop` and you're ready to play with plop.

You also can install it locally to the project, adding it to dependencies: `npm install --save-dev plop`.

Then add it to your `package.json` scripts so you can run it with `npm run plop`:

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

Voilà!

### Configuration

Plop uses a simple `plopfile.js`. 

Here's the standard configuration file I'd suggest you to put at the root of the project:

{% highlight javascript %}
module.exports = ( plop ) => {

  // Here we'll define our generators

};
{% endhighlight %}

Plop will also use templates that can either be inlined within the configuration file, or put in separate files. My suggestion is to put them into a `plop-templates/` folder, at the root of the project too.

### All inclusive FTW

As you'd guess: both generator and templates are embedded in the project, just like your tests or task runner (brunch, gulp, grunt…).

This has **tremendous advantages** over a [customized Yeoman generator](http://yeoman.io/authoring/):

- a single repo to maintain them all
- everything is embedded, no need for installing yeoman and a generator to use it
- update a template is dead easy, you don't a to publish a new version of your generator and make sure everyone is up-to-date before using it

In a nutshell, when a project-specific Yeoman generator may sound overkill, plop fits perfectly. Lightweight, close to source code, it will be **easier to adopt**, maintain and, at the end, **it will be used**.

## Our first generator

To declare a new generator, `plop` provides you `setGenerator`:

{% highlight javascript %}
{% raw %}
module.exports = ( plop ) => {

  // We declare a new generator called "module"
  plop.setGenerator( "module", {
  
    // Succintly describes what generator does.
    description: "Create a new module",
    
    // Get inputs from the user.
    // That's Inquirer.js doing the job behind the hood.
    prompts: [
      {
        type: "input",
        name: "name",
        message: "What is your module name?"
      }
    ],
    
    // List of actions to take.
    // Here we "add" new files from our templates.
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

The `prompts` part is delegated to [Inquirer.js](https://github.com/SBoudrias/Inquirer.js/).

You can just refer to [their documentation](https://github.com/SBoudrias/Inquirer.js/#objects) to learn whatever you can do — questions types, output filter, input validation…

You can imagine doing some not trivial stuff:

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

`validate` will ensure the given module name is not empty.

`filter` allow you to standardize the output: here module names should end with an `s` by convention. Even if I do it wrong and give `calendar` as the module name, I can be sure the `name` variable will be `calendars`.

### Actions

Now it knows everything it needs, plop will run every `actions` you configured. It can use every variables that inquirer did transmit.

Actions, just like templates, are parsed with [Handlebars](https://github.com/wycats/handlebars.js/). If you understand how it works, you know how to use plop.

{% raw %}
Therefore `{{name}}` is the answer given to the prompt, validated and filtered previously. You can drop it wherever needed, in the created file path and/or its template.
{% endraw %}

There are 2 types of actions that are supported yet:

- `"add"` that will create a new file into the given `path` — which is relative to `plopfile.js`
- `"modify"` that will modify the file located at given `path`. It will replace the RegExp you provided in `pattern` with the template you provide

Both actions can either use an inlined template via `template`, or retrieve it from the path you set via `templateFile`.

#### A concrete example

Let's imagine that kind of implementation:

{% highlight javascript %}
{% raw %}
const modulePath = "app/modules/{{camelCase name}}.js";

module.exports = ( plop ) => {

  plop.setGenerator( "model", {
  
    // …
    
    actions: [
        // Add a new model + tests boilerplate.
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
        
        // Modify the module file to inject created model.
        // This is basically RegExp replacement.
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

Then, let's say you have the `plop-templates/model.js` template:

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
Considering `{{name}}` is `calendars`, then plop will create the following `app/modules/calendars.model.js` file:
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

And will also transform your current `app/modules/calendars.js` module file:

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

To insert the reference to the created model:

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

With `"add"` and `"modify"` you can ease a lot of small repetitive things.

#### Adapt actions to given answers

[You can pass a function to `actions`](https://github.com/amwmedia/plop/pull/1). This function will take user's answers as a parameter and should return the array of actions to take.

This way you can **adapt actions to given answers**.

Let's consider this example of new module creation:

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
      // Add a new module, whatever happens.
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
         
      // If you wish a Model, then we add a Model.
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
      
      // Return the array of actions to take.
      return actions;
    }
      
  } );

};
{% endraw %}
{% endhighlight %}

Your generator can adapt to many different scenarios (e.g: a module with a Model, a Collection + Model, with a CollectionView or a CompositeView…).

### Helpers

A little note about templating helpers of plop: these are [those from Handlebars](http://handlebarsjs.com/expressions.html#helpers).

{% raw %}
You starts with a bunch of [helpers plop gives you](https://github.com/amwmedia/plop#baked-in-helpers). `camelCase`, for instance, just works this way: `{{camelCase name}}` with `name = "my awesome module"` gives `"myAwesomeModule"`.
{% endraw %}

You can define your own helpers within `plopfile.js` with `addHelper` :

{% highlight javascript %}
module.exports = ( plop ) => {

  plop.addHelper( "upperCase", ( text ) => text.toUpperCase() );
  
  // …
    
};
{% endhighlight %}

{% raw %}
We just created an `upperCase` helper we could use later in the `actions` and templates: `{{upperCase name}}`.
{% endraw %}

### Just use it

There you go, just type `npm run plop` — or simply `plop`, if you made it global — then follow the guide.

You can also directly call a specific generator with `npm run plop [generatorName]`.

Plop is fast and efficient to use, just like Yeoman. However, it's far more lightweight and easier to maintain. 

## My experience feedback in production

As of the time of writing, I use plop with my team on the [Vinoga](http://vinoga.com) project. Its features perfectly match our use cases. 

I did wrote a Yeoman generator for the project before. It was concretely unused by the team.

Definitely, plop is the kind of tool that saves you 10 minutes here and there, every single day. And running `plop module` in your console, how cool is that \o/
