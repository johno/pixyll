---
layout: post
robots: index,follow
published: true
comments: true

tags: [inuit.css, framework]
icon: css

title: Tired of Bootstrap? Discover inuit.css!
description: inuit.css is a a powerful, scalable, BEM, OOCSS framework which doesn't impose you a design.
---

## Is inuit.css built for you?

To make it easy, you could find this framework interesting in theses cases:

- You need to quickly setup a decent CSS architecture
- You discover/know about *Object Oriented* advantages and like its scalability and reusability
- You should implement a specific design which doesn't fit well with the "default" elements of others frameworks
- You like the framework concept but, as a developer, you like to get your hand dirty into code

However, this framework may not be a good choice for you in such a situation:

- You are searching for a CSS framework which takes care of elements design

Personally, I used a lot [Bootstrap](http://twitter.github.io/bootstrap/). But, working on projects where design has been imposed, I faced the issue of being overriding the default design of the framework. You should most of the time cancel defaults effects, change color, size, ... It works, but you are bloating your CSS with useless code because you defined and redefined the same properties of same elements. It could have been better.

Thus, when you want to produce an optimal CSS and you appreciate [OOCSS](http://coding.smashingmagazine.com/2011/12/12/an-introduction-to-object-oriented-css-oocss/) values, you realized that, under some circumstances, Bootstrap is not always the ideal solution.

I finally found by chance [inuit.css](http://inuitcss.com). As I'm a curious guy, I gave it a try. I love it!

As an overview, I'd suggest you to play around with [inuit.css fiddles](http://jsfiddle.net/user/inuitcss/fiddles/)!


## Philosophy

inuit.css was created [in April 2011](http://csswizardry.com/2011/06/what-is-inuit-css/) by [Harry Roberts](http://csswizardry.com/about/).

This guy made the assumption that a CSS framework should bring some kind of logic and guideline to the developer, without impose any specific design. As this dude isn't that bad in term of CSS best practices, he made them a framework.

<p class="islet">inuit.css is a powerful, scalable, Sass-based, BEM, OOCSS framework.</p>

**inuit.css is developed in [Sass](http://sass-lang.com/)**. Sass is a *CSS preprocessor*, some kind of improved CSS language which allows you to do a bunch of nice stuff that vanilla CSS can't do (nested selectors, loops, conditions, etc.). The preprocessor code should be compiled to produce the final CSS file which would be used for the browser. Sass files just make the development a piece of cake.

**inuit.css use the [BEM](http://bem.info/method/definitions/) naming convention**. This is a very opiniated choice of its creator which can ba, as every best practice, questionable (or at least debated). It can hurts your feelings, mostly because it looks ugly the very first time you see it, but it's really worthy. I'd suggest you to read [Harry Roberts' post about that](http://csswizardry.com/2013/01/mindbemding-getting-your-head-round-bem-syntax/) as he explained it very well.

**inuit.css is an OOCSS framework**. I mean that every component of the framework is an independent, combinable and reusable object. Futhermore, the framework takes advantages from that philosophy which means that you can extend it without any hassle. I'll probably write a post about OOCSS principles. Until then I can suggest you to have a look at [Nicole Sullivan's slides on this topic](http://fr.slideshare.net/stubbornella/the-cascade-grids-headings-and-selectors-from-an-oocss-perspective-ajax-experience-2009).


## Installation

<p class="islet"><strong>Pre-requisite</strong> - have <a href="http://sass-lang.com/tutorial.html">Sass installed</a> in order to compile the code.</p>

At present, **inuit.css** has reached **v5.0**, which considerably change the way you implement it regarding older versions.

The idea was to [make it a module](http://inuitcss.com/2013/03/inuit-css-v5.0/) so you can update the core without disturb the project in which it's implemented. All project specific configurations have been exported outside of the core, so you have no trouble in upgrading this one.

#### Method 1 - With Git

For a new project, just clone the repo as follow:

{% highlight console %}
$ git clone --recursive git@github.com:csswizardry/inuit.css-web-template.git your-project-folder
$ cd your-project-folder
$ ./go
{% endhighlight %}

[The `go` script](https://github.com/csswizardry/inuit.css-web-template/blob/master/go) install the las version of `inuit.css`.

<p class="islet">
    <strong>Tip</strong> - If you want to install the framework in an existing project:
</p>

{% highlight console %}
$ git submodule add git://github.com/csswizardry/inuit.css.git your-project-folder/inuit.css
{% endhighlight %}

<p class="islet">
    Then you'll need to organize your architecture regarding your needs, with the inpiration of the <code>css/</code> folder from the <a href="https://github.com/csswizardry/inuit.css-web-template/tree/master/css">web template</a>.
</p>

In order to update the framework core, you just need to update the git submodule:

{% highlight console %}
$ git submodule update
{% endhighlight %}

#### Method 2 - Without Git

Downloas the [web template](https://github.com/csswizardry/inuit.css-web-template/) and then [the framework core](https://github.com/csswizardry/inuit.css). Place the core under the `css/` folder of the web template. Then copy all of these in `your-project-folder`.

In order to update the framework core, you just need to replace the `inuit.css` folder with the most recent version.


## Architecture and working

Ideally, create a `ui/` folder beside the `inuit.css/` one to put every file which deals with the **design** of your project.

{% highlight text %}
.
|-- inuit.css/         # Framework core - do not touch
|   |-- generic/       # Standards elements (clearfix, reset)
|   |-- base/          # Base elements (tables, forms, ...)
|   |-- objects/       # Modular elements (grid, nav, ...)
|   |-- _defaults.scss # Defaults variables
|   |-- _inuit.scss    # Main setup file of the core
|
|-- ui/                # Folder containing your Sass files
|-- _vars.scss         # Project specific variables
|-- _style.scss        # Main setup file of your project
|-- watch              # Script which watch for changes
{% endhighlight%}

The `inuit.css/` folder contains the framework core. The trick is **not to touche anything under**. Doing so, the framework can be updated without hassle nor risk for specific configuration override, which was not the cas in previous versions of inuit.css. As the framework doesn't impact the design of elements, considering `inuit.css/` as a module you can update sounds relevant.

The `ui/` folder ideally contains your own style files. It's up to you: your rules, your code of conduct.

The `_vars.scss` file should only contain the framework variables you'd like to override. You can find the list of existing variables in `inuit.css/_defaults.scss`. The suggested process is the following:

1. copy the default variable in `_vars.scss`
2. change `$var: defaultvalue!default;` for `$var: newvalue;`
3. that's it

You'll also find in this file that you can activate or deactivate any of the `objects/` components of the framework, regarding your needs.

The `_style.scss` file imports Sass files for the CSS compilation. It's the great architect. It's up to you to add files you'll eventually create under `ui/`.

The `watch` script allows Sass to watch for changes in order to do the compilation automatically. It's not necessary, it depends on your personal workflow... It's up to you (always)! You can customize it. It basically launch the following command:

{% highlight console %}
$ sass --watch style.scss:style.min.css --style compressed
{% endhighlight %}

But wait, you don't have to remember this! Just execute the file and you're done:

{% highlight console %}
$ ./watch
{% endhighlight %}

At the end, you'll have a unique, compressed and optimized CSS file you just need to load from your HTML:

{% highlight html %}
<link rel="stylesheet" href="/your-css-folder/style.min.css">
{% endhighlight %}


## LESS version? Yes sir!

For those who, just like me, use [LESS](http://lesscss.org/) instead of Sass: [a LESS port for inuit.css](https://github.com/peterwilsoncc/inuit.css) exists and is maintained by [Peter Wilson](http://twitter.com/pwcc) and myself.

<p class="islet">
    Indeed, LESS is a relevant alternative to Sass, even though Sass is more powerful. This preprocessor is easier to adopt at a first sight, IMHO. Futhermore, it works with Javascript, not Ruby.
</p>

The only problem is that **it's not necessarily up-to-date** as inuit.css is already `v5.0` and the LESS port still correspond to the `v4.3.7`.

<p class="islet">
    <strong>Edit 4/15</strong> - Version is now up-to-date with <code>v4.5</code> and <code>v5.0.0</code> is coming!
</p>

<p class="islet">
    <strong>Edit 5/23</strong> - The current version is now <code>v5.0.0</code> coming with the <a href="https://github.com/nicoespeon/inuit.css-web-template">web template</a> and <a href="https://github.com/peterwilsoncc/inuit.css">framework core</a> (same principle, in LESS).
</p>

---

For those who'd eventually have some questions about the framework, don't hesitate to put comments below.

If you're curious and want to discover what is *fuckingood* CSS, give it a try!
