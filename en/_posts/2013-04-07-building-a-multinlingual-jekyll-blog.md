---
layout: post
robots: index,follow
published: true
comments: true

tags: [jekyll,i18n]

title: Building a multilanguage Jekyll blog
description: As a first post, what about sharing the way I managed to build this blog? Having a both english and french Jekyll website is not that hard, but you have to care about some crucial points.
---

## <span class="icon-info"></span> Note on compatibility

Which follows consider the use of Jekyll `v0.12.1`.

Looking for Jekyll `v1.5`? Go have a look [to the one of April 2014]({% post_url 2014-04-05-multilingual-blog-with-jekyll-1-5 %}).

Please note that some major changes happened in Jekyll `v1.0.0` which made some of the following tricks not working anymore (I'm thinking about plugins). I'll write a new post when upgrade my own Jekyll to v1.0+.

If you wish, you can still install the old Jekyll version with the following command:

{% highlight bash %}
# Install the old version of jekyll
$ sudo gem install jekyll --version 0.12.1

# Uninstall your current version if you dowloaded it
$ sudo gem uninstall jekyll --version <your current version>
{% endhighlight %}


## Why Jekyll?
I won't write a n-th post about the reason of choosing Jekyll as the static site generator for my blog. There are already [plenty of them](https://www.google.fr/search?q=moving+blog+to+jekyll).

I'll just sum it up with the following bullet-points :

- **I don't need to deal with a database**. I just want to Keep It Simple (Stupid) and front-end will just do it well.
- **I want to have my website updated when I push it to Github**. I could have done some hook to deal with that but I don't have to, thanks to [Github Pages](https://help.github.com/categories/20/articles).
- **I love keeping myself up-to-date with new trends**. And the Jekyll approach just sounds good to me.

I could recommend you [the post from Harry Roberts](http://csswizardry.com/2012/12/a-new-css-wizardry/) and [the one from Hugo Giraudel](http://hugogiraudel.com/2013/02/21/jekyll) which comforted me in my choice.

## What about multilingual?
The thing is, Jekyll is not actually build to support multinlingual blogs. The [Liquid `date` filter](http://liquid.rubyforge.org/classes/Liquid/StandardFilters.html#M000012) will display the english version of the date.
Futhermore, if you want to distinguish posts by their language, then you have to create a category per language. But the Jekyll `.paginator` is not build to deal with categories, which is kind of a problem.

Nevertheless, I wanted to create my blog both in French and English for few reasons :

1. **Most of the nicest websites treating about front-end development are in English**, which is fine but I would like to see few of them written in my native language for other French developers who may not be fluent in English (even if they should be).
2. **I'm French and proud to be**. Although I love English, there's no reason for me not to write some posts in my native language too.
3. **This is a challenge** and I love challenges... as every developer does, right?

*So here's the strategy.*
English is the default language, at the root level.
Each language represents a category, which could be done thanks to the folders architecture.
The French part should be under the `/fr` base url, which is fine with the previous statements.
English posts should only display into `/index.html`, French posts should only display into `/fr/index.html` (and the pagination should be done accordingly).
It should Keep It Simple (Stupid).

Let's build the architecture for the source files:

{% highlight text %}
.
|-- _includes/      # Partials included in other files
|-- _layouts/       # Templates of the website
|-- _plugins/       # Plugins to override Jekyll workflow
|-- assets/         # LESS/CSS, JS, images, ...
|-- fr/             # French category
|   |-- _posts/     # French posts
|   |-- index.html  # French html files
|   |-- about.html
|   |-- (...)
|
|-- en/             # English category
|   |-- _posts/     # English posts
|
|-- index.html      # Default html files (EN)
|-- about.html
|-- (...)
|-- _config.yml     # Jekyll configuration file
{% endhighlight %}

When launched, Jekyll generates the static final website into the `_site/` folder.

<p class="islet">
    I use the <code>_config.yml</code> file to put some locale variables I could use in the main templates.<br><br>
    This is definitely <strong>not the cleanest solution</strong> in my humble opinion, but it's quite easy to deal with and it works fine for the moment. It may change in the future in a smarter way to handle this.
</p>

## Plugins on the road
In order to solve the mentioned problems, I used 2 plugins to override the regular Jekyll workflow.

#### 1. Pagination per category
[category_pagination.rb](https://github.com/nicoespeon/nicoespeon.github.io/blob/develop/_plugins/category_pagination.rb) has the paginator only considers posts of the current category in order to distinguish the two languages.

I modified the original plugin to have the default category, at root level, set as the *English* one instead of displaying all of the `site.posts`.

#### 2. i18n Filter
[i18n_filter.rb](https://github.com/nicoespeon/nicoespeon.github.io/blob/develop/_plugins/i18n_filter.rb) customizes the `page.date` treatment accordingly to the locale.

I've had to add the [\_locales/fr.yml](https://github.com/nicoespeon/nicoespeon.github.io/blob/develop/_locales/fr.yml) file to create the `localize` function. It performs just as the `date` does, but it displays the French format for the date.

## The Github thing

Plugins are set up, templates are built, design has been completed, the git workflow is ready and so is the remote repository on Github. *Let's push!*

[The DNS redirection for my custom domain](https://help.github.com/articles/setting-up-a-custom-domain-with-pages) just works fine but... wait. It doesn't play as expected.
Damn it! I just notice that Github is running Jekyll in `--safe` mode, which means that plugins are disabled. And so are my category pagination and my i18n filter.

**For every problem, a solution**, with Google being your best friend. [I found inspiration](http://charliepark.org/jekyll-with-plugins/) to redesign my personal workflow in that way.

*Let's have a look to my branching model.*
The `master` branch correspond to the compiled website (the one generated into `_site/` directory) so that Github can deliver it directly as a static website, thanks to the `.nojekyll` file.
The `develop` branch correspond to the source files, as I would like to keep them tracked and open-sourced. They would be compiled with Jekyll in order to proceed to deployment.
There's no more merge from `develop` into `master` as there's only deployments from now. I just work on `develop` and, when I'm ready, I deploy the whole site with a new commit on `master`.

<p class="islet">
    Of course I already pushed the first commits when I realized I was wrong. But instead of recreating the whole repo and rebase my git history, I decided to deal with it with just few commits to correct the situation. There's no shame in doing mistakes after all.
</p>

I just create a [Makefile](https://github.com/nicoespeon/nicoespeon.github.io/blob/develop/Makefile) in order to do all that stuff with a `make deploy` command. And voilà!

## And here we go

Here we are, it just works perfectly and I'm now ready to go with a both English and French, Jekyll-flavored, Github-hosted blog *\o/*

There is still enhancements I should take care of -such as deploying a Google Analytics and a comments system- but I'm satisfied with the result. The challenge is taken up and the journey has begun. **Let's transform these posts into a monster.**
