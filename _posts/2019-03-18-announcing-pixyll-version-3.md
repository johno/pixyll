---
layout: post
title: Announcing Pixyll version 3.0
date: 2019-03-18 23:03
summary:    Now, Pixyll is easier to use with Jekyll
categories: jekyll pixyll
---

It's easier to use Pixyll as your Jekyll theme.

Pixyll is now available as a gem-based theme as version 3.0.

With a gem-based theme, you no longer need to fork the git repository.

The following will explain using the gem-based theme.  Although if you prefer, you can continue to do so.

Pixyll users who used a Git fork, can keep their fork and can get a sense of the breaking changes in 3.0 and also how to resolve them in the section on [existing Pixyll sites](#existing-pixyll-sites) and by reviewing the changes in the [release notes for 3.0](https://github.com/johno/pixyll/releases/tag/v3.0.0).

We'll start by outlining how existing Jekyll users enable Pixyll as their theme.

## Existing Jekyll sites

If you have an existing Jekyll site, you can move your Jekyll site to Pixyll in the following steps:

1. Add the Pixyll gem to your `Gemfile`.
2. Set the theme to `pixyll` in your `_config.yml` file.
3. Add jekyll-paginate to the plugins section of your `_config.yml` file.
4. Configure how many posts to list per page by adding a value for `paginate` (e.g. `4`) in your `_config.yml` file.
5. Change the layout in your `index.md` to be `home`.
6. Rename your `index.md` to `index.html`.
7. Modify your `contact.html` to use the `contact` layout.
8. Change your blog posts to use the `post` layout.
9. Change any other pages on your Jekyll to use the `page` layout.

That's a lot of steps.  They are nearly the same as those for starting a new site, so you can walk through each task, one-at-a-time, in the next section.

If you have a pre-existing Pixyll-based site, then you can also follow the next steps and a few additional steps for [existing Pixyll sites](#existing-pixyll-sites) at the end.

## New sites

Before starting a new Jekyll site, you need to have [Bundler](https://bundler.io) and [Jekyll](https://jekyllrb.com) installed.[^1]

```sh
gem install --no-document bundler # If you don't have bundler installed
gem install --no-document jekyll
```

You can use Jekyll to create a skeleton site for you:

```sh
jekyll new my-pixyll-site
```

You should change in to the new site's directory, and have Bundler download and manage the dependencies for your Jekyll site.

```sh
cd my-pixyll-site
bundle install
```

### 1. Add Pixyll to your Gemfile

You'll want to add Pixyll to your Gemfile:

```ruby
gem "pixyll", "~> 3.0"
```

The default theme for Jekyll is Minima, so you can remove the entry `gem "minima"`.

Then run the Bundler "install" command so Bundler will both download and manage the dependencies for Pixyll:

```sh
bundle install
```

The `~> 3.0` means that Bundler will set Pixyll to automatically update to any 3.0 version.  This would include Pixyll versions 3.0.1, 3.1.2 and 3.9.9 (These new versions don't exist, today).

We promise not to introduce breaking changes in 3.0, per [Semantic Versioning](https://semver.org/), but Pixyll is provided "as is" without warranty.  We can't guarantee that there won't be breaking changes with upgrading.

You can pin your version of Pixyll by keeping a `Gemfile.lock` file or by [changing the version specification](https://bundler.io/v1.17/gemfile.html) in your `Gemfile`.  When you have a `Gemfile.lock`, you can manually run `bundle update pixyll` to upgrade Pixyll to the latest 3.0 version.

### 2. Add Pixyll to your Gemfile

Edit your `_config.yml` to use Pixyll as your theme:

```yml
theme: pixyll
```

There should already be an entry there 

### 3. Add jekyll-paginate to plugins

Add `jekyll-paginate` to the "plugins" section of your  your `_config.yml`:

```yml
plugins:
  - jekyll-paginate
```

If you already have an entry for `github-pages` in your `Gemfile`, then you don't need to add the `jekyll-paginate` gem.

If you happen to not have the `github-pages` gem, then you need to add the `jekyll-paginate` gem.

```ruby
group :jekyll_plugins do
  gem "jekyll-paginate", "~> 1.1.0"
end
```

```yml
gem "pixyll", "~> 3.0"
```

### 4. Configure posts per page

Set the number of posts to list per page by adding `paginate` in your `_config.yml` file.  A good default is 4 posts per page:

```yml
paginate: 4
 ```

### 5. Use the home layout

Set the layout for your `index.md` to be the `home` layout:

```yml
layout: home
```

> Existing Pixyll users can remove the body of the page below the preamble.

### 6. Rename your index file

Because the Jekyll paginate plugin only works from an HTML file, you need to rename your `index.md` to `index.html`:

```sh
git mv index.md index.html
```

### 7. Use the contact layout

In order to use the contact page that ships with the Pixyll theme and get future fixes and improves, you should modify the `contact.html` in the root directory:

```yml
---
layout: contact
title: Say Hello
permalink: /contact/
tags: contact
---
```

> For existing Pixyll users, you'll need to remove the body of the page below the preamble.

Add the contact page to the site navigation in the header:

```yml
header_pages:
 - about.md
 - contact.html
```

### 8. Use the post layout

Set the layout for all your blog posts to be `post`:

```yml
layout: post
```

### 9. Use the page layout

For any other pages on your Jekyll site that aren't the home page or a blog post, set the layout those other pages to be `page`:

```yml
layout: page
```

## Existing Pixyll sites

If you had an existing site using Pixyll, you have some additional steps.

You can try pull in the latest changes, but risks causing "git problems" for you.  If you want you can just try to do the steps from the section above, in particular see (1), (2), (5), (7) from above.

Once you have done the steps from above, then you can migrate your existing Pixyll site with the following steps:

10. Remove the includes and layout templates.
11. The icons have moved to `assets/img`.
12. Rename the `pixyll.scss` file to `main.scss`.
13. Remove the `_sass` directory.
14. Add jekyll-sitemap to your `Gemfile`.
15. Add a `Rakefile`.

A detailed description of each of these tasks is below.

### 10. Remove the templates

The layout and include templates are bundled in the gem for the Pixyll theme.  You should remove the old ones:

```sh
git rm _layouts/center.html
git rm _layouts/default.html
git rm _layouts/page.html
git rm _layouts/post.html
git rm _includes/ajaxify_content_form.html
git rm _includes/footer.html
git rm _includes/head.html
git rm _includes/header.html
git rm _includes/navigation.html
git rm _includes/pagination.html
git rm _includes/post_footer.html
git rm _includes/share_buttons.html
git rm _includes/social_links.html
```

If you want to cutomize Pixyll, you can pull one or more of the layout or template files from the Pixyll git repoistory or follow the instructions at [Overriding theme defaults](https://jekyllrb.com/docs/themes/#overriding-theme-defaults) from the Jekyll theme 

### 10. Move your icons

The Pixyll theme provides default browser icons (also known as "favicons") and expects them to be in the `/assets/img` subdirectory.

They used to be in the root directory.  If you had customized your icons, you need to move them to the new location:

```sh
mkdir assets assets/img
git mv apple-touch-icon-57x57.png   assets/img/apple-touch-icon-57x57.png
git mv apple-touch-icon-114x114.png assets/img/apple-touch-icon-114x114.png
git mv apple-touch-icon-72x72.png   assets/img/apple-touch-icon-72x72.png
git mv apple-touch-icon-144x144.png assets/img/apple-touch-icon-144x144.png
git mv apple-touch-icon-60x60.png   assets/img/apple-touch-icon-60x60.png
git mv apple-touch-icon-120x120.png assets/img/apple-touch-icon-120x120.png
git mv apple-touch-icon-76x76.png   assets/img/apple-touch-icon-76x76.png
git mv apple-touch-icon-152x152.png assets/img/apple-touch-icon-152x152.png
git mv apple-touch-icon-180x180.png assets/img/apple-touch-icon-180x180.png
git mv favicon-192x192.png          assets/img/favicon-192x192.png
git mv favicon-160x160.png          assets/img/favicon-160x160.png
git mv favicon-96x96.png            assets/img/favicon-96x96.png
git mv favicon-16x16.png            assets/img/favicon-16x16.png
git mv favicon-32x32.png            assets/img/favicon-32x32.png
git mv favicon.ico                  assets/img/favicon.ico
```

### 11. Rename pixyll.scss (optional)

If you customized `pixyll.scss` or any of the [Sass](https://sass-lang.com/) `.scss` files, then you need to move it to the `assets` directory and rename it `main.scss`:

```sh
mkdir assets assets/css
git mv css/pixyll.scss assets/css/main.scss
```

If you haven't made any modifications to the main stylesheet file, then you might not get the style changes in the gem-based Pixyll theme.  So you should just delete your  `css/pixyll.scss` file:

```sh

```

### 12. Remove Sass files (optional)

If you customized any of the [Sass](https://sass-lang.com/) `.scss` files, then you'll want to keep your Sass files.

If you haven't made any modifications to the stylesheets, then you won't get the style changes in the gem-based Pixyll theme.  You should just delete your copies of the `_sass` subdirectory:

```sh
git rm -r _sass/
```

### 13. Add jekyll-sitemap to your Gemfile (optional)

Pixyll 2.0 enabled the Jekyll plugin `jekyll-sitemap` in the `_config.yml`.

```yml
plugins:
  - jekyll-sitemap
```

It produces a `sitemap.xml` file to your site in support of the [Sitemaps.org](https://sitemaps.org) standard for search engines.  If you're using Pixyll as a gem-based theme, you will be missing this gem.  To add it back, put the following line in your `Gemfile`:

```ruby
group :jekyll_plugins do
  gem "jekyll-sitemap", "~> 1.2.0"
end
```

Then run the Bundler "install" command so Bundler will download the dependency:

```sh
bundle install
```

### 14. Add a Rakefile (optional)

In order to use the `Rakefile` that ships with the Pixyll theme and get future fixes and improvements, you should createa `Rakefile` at the root directory of your site:

```ruby
spec = Gem::Specification.find_by_name 'pixyll'
rakefile = "#{spec.gem_dir}/Rakefile"
load rakefile
```

The rake tasks help you with routine tasks for your Jekyll site.

    $ rake list
    Tasks: draft, post, preview, undraft
    (type rake -T for more detail)

Add a new post:

    $ rake 'post[Hello\, world]'
    Creating new post: _posts/2019-02-08-hello-world.md

Add a new draft:

    $ rake 'draft[Hello\, world]'
    Creating new draft: _drafts/hello-world.md

Publish a draft:

    $ rake undraft[hello-world.md]
    Original date of draft: 2019-02-08 04:28
    Moving _drafts/hello-world.md to _posts/2019-02-08-hello-world.md...done.
    Modifying date for post to '2019-02-08 04:29'...done.

## GitHub pages

If you use [GitHub pages](https://pages.github.com/) to publish your Jekyll-based site, you can continue to use Pixyll by forking the repo, but you can now use Pixyll as [a theme on GitHub pages](https://github.blog/2017-11-29-use-any-theme-with-github-pages/).

```yml
remote_theme: johno/pixyll
```

You will need to follow all the Pixyll 3.0 changes, see above, to use Pixyll as your theme on GitHub pages.

---
[^1]: This presumes you installed [Ruby](https://ruby-lang.org), already.
