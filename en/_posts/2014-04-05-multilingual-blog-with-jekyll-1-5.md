---
layout: post
robots: index,follow
published: true
comments: true

tags: [jekyll, i18n]

title: Multilingual blog with Jekyll 1.5
description: What changed with Jekyll v1.5.1 if you want to build a multilingual blog.
---

## <span class="icon-info"></span> Note on compatibility

This post considers you're using Jekyll `v1.5.1`.

It's an extension to [my previous post from April 2013]({% post_url 2013-04-07-building-a-multinlingual-jekyll-blog %}) in which I explained how I managed to build this English-French blog. There have been a bunch of new versions of Jekyll since. I'll explain here how to change the previous implementation accordingly.


## Few reminders about Jekyll

After almost one year using it - even though I didn't write that much post these months - here is what I could take from Jekyll:

- this is the simplest solution to build a front-end website with the ease of compilation (templates, plugins, etc.). The fact that GitHub takes in charge the compilation helps that point of view, for sure
- it takes advantages and inconveniences from Ruby on Rails - the beauty of the language, the nightmare of the version upgrade
- writing posts in Markdown is a no-brainer
- if standard behavior doesn't fit our needs, we could also override it with our own plugins

Keep in mind that if you're using plugins, you should compile the website by yourself before sending the static version to GitHub.


## Speaking Français, ze retour

As a reminder, here is my blog architecture:

{% highlight text %}
.
|-- _data/          # Variables and configuration
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

Jekyll compile sources and will output them into `_site/` folder. This version is sent to GitHub.

<p class="islet">
    <strong>Note</strong> - I removed from <code>_config.yml</code> language-dependent variables that I can use in my templates..<br><br>
    They are now properly isolated into the <code>_data/locales.yml</code> file.
</p>

For sure, upgrading Jekyll from  `v0.12` to `v1.5` leads to some modifications of the `config.yml` file in order to remove what was deprecated and add what was necessary.

Then come plugins…


## <span class="icon-gift"></span> Plugins, what has changed here

#### 1. Per-category pagination

This is THE plugin that needed to be changed as Jekyll pagination workflow changed completely.

I didn't find anything convincing enough, so I wrote my own [category_pagination.rb](https://gist.github.com/nicoespeon/9964343) plugin.

Just add it to your `_plugins/` folder, then configure your `config.yml` regarding your needs:

- `paginate_per_category: true` if you wish to activate the plugin
- `default_category: "en"` *(optional)* if you wish the root pagination to be the one of a specific category

The plugin is pretty straightforward:

1. if I want to paginate a category (aka folder),
2. pagination will only consider posts from this category,
3. I can define a default category for files that are at the root of the project (otherwise I'd paginate everything).

You can have a look to the [fr/index.html](https://github.com/nicoespeon/nicoespeon.github.io/blob/develop/fr/index.html) page.

<p class="islet">
    <strong>Note</strong> - This is a first draw that could be used as a simple - and opiniated - per-category pagination. Don't hesitate to suggest improvements =)
</p>

#### 2. I18n filter

[i18n_filter.rb](https://github.com/nicoespeon/nicoespeon.github.io/blob/develop/_plugins/i18n_filter.rb) customize the treatment of `page.date` variable, regarding the language.

I've had to add a [\_locales/fr.yml](https://github.com/nicoespeon/nicoespeon.github.io/blob/develop/_locales/fr.yml) file in order to create the `localize` function. It works just like the `date` method, but output the french format for the date.


## Et voilà!

Nothing has really changed, just few corrections to set and it's done. If you have any suggestion, remark or issue with that, just drop me a line.

Plop !
