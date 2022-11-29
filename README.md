# Pixyll

[pixyll.com](https://www.pixyll.com/)

![Pixyll screenshot](./screenshot.png)

Pixyll is a simple, beautiful theme for Jekyll that emphasizes content rather than aesthetic fluff. It's mobile _first_, fluidly responsive, and delightfully lightweight.

It's pretty minimal, but leverages large type and drastic contrast to make a statement, on all devices.

This Jekyll theme was crafted with <3 by [John Otander](https://johno.com/)
([@4lpine](https://twitter.com/4lpine)).

中文版 <https://github.com/ee0703/pixyll-zh-cn>.

## Getting Started

If you're completely new to Jekyll, I recommend checking out the documentation at <https://jekyllrb.com/> or there's a tutorial by [Smashing Magazine](https://www.smashingmagazine.com/2014/08/build-blog-jekyll-github-pages/).

```
$ git clone git@github.com:johno/pixyll.git
$ cd pixyll
$ gem install bundler # If you don't have bundler installed
$ bundle install
```

#### Verify your Jekyll version

It's important to also check your version of Jekyll since this project uses new `baseurl` features that are [only supported in 3.3+](https://jekyllrb.com/news/2016/10/06/jekyll-3-3-is-here/).

### Fork, then clone

Fork the repo, and then clone it so you've got the code locally.


### Modify the `_config.yml`

The `_config.yml` located in the root of the Pixyll directory contains all of the configuration details
for the Jekyll site. The defaults are:

```yml
# Site settings
title: Pixyll
email: your_email@example.com
author: John Otander
description: "A simple, beautiful theme for Jekyll that emphasizes content rather than aesthetic fluff."
baseurl: ""
url: "https://pixyll.com/"

# Build settings
markdown: kramdown
permalink: pretty
paginate: 3
```

### Jekyll Serve

Then, start the Jekyll Server. I always like to give the `--watch` option so it updates the generated HTML when I make changes.

```
$ jekyll serve --watch
```

Now you can navigate to `localhost:4000` in your browser to see the site.

### Using Github Pages

You can host your Jekyll site for free with Github Pages. [Click here](https://pages.github.com/) for more information.

#### A configuration tweak if you're using a gh-pages sub-folder

In addition to your github-username.github.io repo that maps to the root url, you can serve up sites by using a gh-pages branch for other repos so they're available at github-username.github.io/repo-name.

This will require you to modify the `_config.yml` like so:

```yml
# Site settings
title: Repo Name
email: your_email@example.com
author: John Otander
description: "Repo description"
baseurl: "/repo-name"
url: "https://github-username.github.io"

# Build settings
markdown: kramdown
permalink: pretty
paginate: 3
```

This will ensure that the the correct relative path is constructed for your assets and posts. Also, in order to run the project locally, you will need to specify the blank string for the baseurl: `$ jekyll serve --baseurl ''`.

##### If you don't want the header to link back to the root url

You will also need to tweak the header include `/{{ site.baseurl }}`:

```html
<header class="site-header px2 px-responsive">
  <div class="mt2 wrap">
    <div class="measure">
      <a href="{{ "/" | relative_url }}" class="site-title">{{ site.title }}</a>
      <nav class="site-nav">
        {% include navigation.html %}
      </nav>
    </div>
  </div>
</header>
```

A relevant Jekyll Github Issue: <https://github.com/jekyll/jekyll/issues/332>

### Contact Form

The contact form uses <https://formspree.io/>. It will require you to fill the form out and submit it once, before going live, to confirm your email.

More setup instructions and advanced options can be found at [https://formspree.io](https://formspree.io/)


### Disqus

To configure Disqus, set up a [Disqus site](https://disqus.com/admin/create/) with the same name as your site. Then, in `_config.yml`, edit the `disqus_shortname` value to enable Disqus.

### Customizing the CSS

All variables can be found in the `_sass/_variables.scss` file, toggle these as you'd like to change the look and feel of Pixyll.

### Page Animation

If you would like to add a [fade-in-down effect](https://animate.style/), you can add `animated: true` to your `_config.yml`.

### AnchorJS

[AnchorJS](https://github.com/bryanbraun/anchorjs): _A JavaScript utility for adding deep anchor links to existing page content. AnchorJS is lightweight, accessible, and has no dependencies._ You can turn it on by toggling `enable_anchorjs`. Because it offers many ways for customization, tweaks should be done in `_includes/footer.html`. Default settings after turning AnchorJS on are:

```html
<script>
    anchors.options.visible = 'always';
    anchors.add('article h2, article h3, article h4, article h5, article h6');
</script>
```

See [documentation](https://www.bryanbraun.com/anchorjs/#basic-usage) for more options.

### Put in a Pixyll Plug

If you want to give credit to the Pixyll theme with a link to <https://pixyll.com/> or my personal website <https://johno.com/> somewhere, that'd be awesome. No worries if you don't.

### Web analytics and search engines

You can measure visits to your website either by using [Google Analytics](https://www.google.com/analytics/) tracking embed or the more advanced [Google Tag Manager](https://www.google.com/analytics/tag-manager/) container.
* For Google Analytics set up the value for `google_analytics`, it should be something like `google_analytics: UA-XXXXXXXX-X` or `google_analytics: G-XXXXXXX` depending on whether you are using universal analytics or not.
* For Google Tag Manager set up the value for `google_tag_manager`, it should be something like: `google_tag_manager: GTM-XXXXX`.
* _Do not_ set both of above methods because this will cause conflicts and skew your reporting data.
* Remember that you need to properly configure the GTM container in its admin panel if you want it to work. More info is available in [GTM's docs](https://www.google.com/analytics/tag-manager/resources/).

Your website is, by default, set to be allowed for crawling and indexing by search engines. (Unless you made yourself a custom robots.txt file). You can use front matter settings on each page to control how search engines will it. Sometimes you may want to exclude a particular page from indexing or forbid Google to store a copy of your page in its cache. It is up to you. Use the `meta_robots` frontmatter key and assign values based on [this table](https://developers.google.com/webmasters/control-crawl-index/docs/robots_meta_tag?hl=en#valid-indexing--serving-directives). Some examples:

```yaml
# exclude page from index
meta_robots: noindex

# allow indexing, disallow caching
meta_robots: noarchive

# allow indexing, disallow crawling links
meta_robots: nofollow

# disallow indexing, follow links
meta_robots: noindex,follow
```

In order to get more information about your website's status in search engines, you can register it in [Google Search Console](https://search.google.com/search-console/about) and/or [Bing Webmaster Tools](https://www.bing.com/webmasters/about). Both these tools will ask you to authorize your website with them and there are couple of ways to do that. Pixyll supports verification via meta tags - just fill in values for `google_verification` and/or `bing_verification` in `_config.yml`, the verification strings and meta tags will then be added automatically.

If search engine optimization is your thing, you can also set up `meta_description` values for each page/post. By default Pixyll uses `summary` to populate the `<meta name="description" content="...">` tag and falls back to `description` from `_config.yml` if `summary` is not present in page/post's front matter. The `summary` is also used for generating Open Graph tags. Why would you want to use a dedicated variable for meta description? Because character limit to properly display this description in search results (as a snippet) is way smaller than in Open Graph. It is recommended to keep it at 155-160 characters, for more in-depth info read [this article](https://moz.com/blog/i-cant-drive-155-meta-descriptions-in-2015).

And lastly - if you happen to write in language other than English be sure to change `og_locale` in `_config.yml` to reflect it.

### Progressive Web App

Pixyll supports features of a progressive web app (PWA).  As a PWA, your site's home page can be installed as a shortcut or an app icon on a mobile device.  Also, certain assets are cached so the site can be accessed should the device be offline from the network.

Pixyll supports these features because it provides a Javascript file that acts as a *service worker* in the browser and has a JSON file with a *web manifest*.  By default, these are configured to the settings of Pixyll, but you should consider cutomizing them to your specific site:

1. Provide a different version of `splash-512x512.png` which is the loading screen for your offline app.
2. A `favicon-192x192.png` for the app icon (if you haven't already).
3. In `sw.js`, list any other files or pages you want to add to the list of cached artifacts.

For more information on PWAs:

- https://developer.mozilla.org/en-US/docs/Web/Progressive_web_apps
- https://web.dev/what-are-pwas/

### Enjoy

I hope you enjoy using Pixyll. If you encounter any issues, please feel free to let me know by creating an [issue](https://github.com/johno/pixyll/issues). I'd love to help.

## Upgrading Pixyll

Pixyll is always being improved by its users, so sometimes one may need to upgrade.

#### Ensure there's an upstream remote

If `git remote -v` doesn't have an upstream listed, you can do the following to add it:

```
git remote add upstream https://github.com/johno/pixyll.git
```

#### Pull in the latest changes

```
git pull upstream master
```

There may be merge conflicts, so be sure to fix the files that git lists if they occur. That's it!

## Thanks to the following

* [BASSCSS](https://basscss.com/)
* [Jekyll](https://jekyllrb.com/)
* [Refills](https://refills.bourbon.io/)
* [Solarized](https://ethanschoonover.com/solarized/)
* [Animate.css](https://animate.style/)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Forking

There is a [guide to forking Pixyll](https://pixyll.com/jekyll/pixyll/2019/01/26/guide-to-forking-pixyll/).
