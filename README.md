> March, 2016: If you're on an old version of Jekyll Now and run into a) build warnings or b) syntax highlighting issues caused by [Jekyll 3 and GitHub Pages updates](https://github.com/blog/2100-github-pages-now-faster-and-simpler-with-jekyll-3-0), just :sparkles:[update your _config.yml](https://github.com/barryclark/jekyll-now/pull/445/files):sparkles: and you'll be set!

# Jekyll Now

**Jekyll** is a static site generator that's perfect for GitHub hosted blogs ([Jekyll Repository](https://github.com/jekyll/jekyll))

**Jekyll Now** makes it easier to create your Jekyll blog, by eliminating a lot of the up front setup.

- You don't need to touch the command line
- You don't need to install/configure ruby, rvm/rbenv, ruby gems :relaxed:
- You don't need to install runtime dependencies like markdown processors, Pygments, etc
- If you're on Windows, this will make setting up Jekyll a lot easier
- It's easy to try out, you can just delete your forked repository if you don't like it

In a few minutes you'll be set up with a minimal, responsive blog like the one below giving you more time to spend on writing epic blog posts!

![Jekyll Now Theme Screenshot](/images/jekyll-now-theme-screenshot.jpg "Jekyll Now Theme Screenshot")

## Quick Start

### Step 1) Fork Jekyll Now to your User Repository

Fork this repo, then rename the repository to yourgithubusername.github.io.

Your Jekyll blog will often be viewable immediately at <https://yourgithubusername.github.io> (if it's not, you can often force it to build by completing step 2)

![Step 1](/images/step1.gif "Step 1")

### Step 2) Customize and view your site

Enter your site name, description, avatar and many other options by editing the _config.yml file. You can easily turn on Google Analytics tracking, Disqus commenting and social icons here too.

Making a change to _config.yml (or any file in your repository) will force GitHub Pages to rebuild your site with jekyll. Your rebuilt site will be viewable a few seconds later at <https://yourgithubusername.github.io> - if not, give it ten minutes as GitHub suggests and it'll appear soon

> There are 3 different ways that you can make changes to your blog's files:

> 1. Edit files within your new username.github.io repository in the browser at GitHub.com (shown below).
> 2. Use a third party GitHub content editor, like [Prose by Development Seed](http://prose.io). It's optimized for use with Jekyll making markdown editing, writing drafts, and uploading images really easy.
> 3. Clone down your repository and make updates locally, then push them to your GitHub repository.

![_config.yml](/images/config.png "_config.yml")

### Step 3) Publish your first blog post

Edit `/_posts/2014-3-3-Hello-World.md` to publish your first blog post. This [Markdown Cheatsheet](http://www.jekyllnow.com/Markdown-Style-Guide/) might come in handy.

![First Post](/images/first-post.png "First Post")

> You can add additional posts in the browser on GitHub.com too! Just hit the + icon in `/_posts/` to create new content. Just make sure to include the [front-matter](http://jekyllrb.com/docs/frontmatter/) block at the top of each new blog post and make sure the post's filename is in this format: year-month-day-title.md

## Local Development

1. Install Jekyll and plug-ins in one fell swoop. `gem install github-pages` This mirrors the plug-ins used by GitHub Pages on your local machine including Jekyll, Sass, etc.
2. Clone down your fork `git clone https://github.com/yourusername/yourusername.github.io.git`
3. Serve the site and watch for markup/sass changes `jekyll serve`
4. View your website at http://127.0.0.1:4000/
5. Commit any changes and push everything to the master branch of your GitHub user repository. GitHub Pages will then rebuild and serve your website.

## Moar!

I've created a more detailed walkthrough, [**Build A Blog With Jekyll And GitHub Pages**](http://www.smashingmagazine.com/2014/08/01/build-blog-jekyll-github-pages/) over at the Smashing Magazine website. Check it out if you'd like a more detailed walkthrough and some background on Jekyll. :metal:

It covers:

- A more detailed walkthrough of setting up your Jekyll blog
- Common issues that you might encounter while using Jekyll
- Importing from Wordpress, using your own domain name, and blogging in your favorite editor
- Theming in Jekyll, with Liquid templating examples
- A quick look at Jekyll 2.0’s new features, including Sass/Coffeescript support and Collections

## Jekyll Now Features

✓ Command-line free _fork-first workflow_, using GitHub.com to create, customize and post to your blog  
✓ Fully responsive and mobile optimized base theme (**[Theme Demo](http://jekyllnow.com)**)  
✓ Sass/Coffeescript support using Jekyll 2.0  
✓ Free hosting on your GitHub Pages user site  
✓ Markdown blogging  
✓ Syntax highlighting  
✓ Disqus commenting  
✓ Google Analytics integration  
✓ SVG social icons for your footer  
✓ 3 http requests, including your avatar  

✘ No installing dependencies
✘ No need to set up local development  
✘ No configuring plugins  
✘ No need to spend time on theming  
✘ More time to code other things ... wait ✓!  

## Questions?

[Open an Issue](https://github.com/barryclark/jekyll-now/issues/new) and let's chat!

## Other forkable themes

You can use the [Quick Start](https://github.com/barryclark/jekyll-now#quick-start) workflow with other themes that are set up to be forked too! Here are some of my favorites:

- [Hyde](https://github.com/poole/hyde) by MDO
- [Lanyon](https://github.com/poole/lanyon) by MDO
- [mojombo.github.io](https://github.com/mojombo/mojombo.github.io) by Tom Preston-Werner
- [Left](https://github.com/holman/left) by Zach Holman
- [Minimal Mistakes](https://github.com/mmistakes/minimal-mistakes) by Michael Rose
- [Skinny Bones](https://github.com/mmistakes/skinny-bones-jekyll) by Michael Rose

## Credits

- [Jekyll](https://github.com/jekyll/jekyll) - Thanks to its creators, contributors and maintainers.
- [SVG icons](https://github.com/neilorangepeel/Free-Social-Icons) - Thanks, Neil Orange Peel. They're beautiful.
- [Solarized Light Pygments](https://gist.github.com/edwardhotchkiss/2005058) - Thanks, Edward.
- [Joel Glovier](http://joelglovier.com/writing/) - Great Jekyll articles. I used Joel's feed.xml in this repository.
- [David Furnes](https://github.com/dfurnes), [Jon Uy](https://github.com/jonuy), [Luke Patton](https://github.com/lkpttn) - Thanks for the design/code reviews.
- [Bart Kiers](https://github.com/bkiers), [Florian Simon](https://github.com/vermluh), [Henry Stanley](https://github.com/henryaj), [Hun Jae Lee](https://github.com/hunjaelee), [Javier Cejudo](https://github.com/javiercejudo), [Peter Etelej](https://github.com/etelej), [Ben Abbott](https://github.com/jaminscript), [Ray Nicholus](https://github.com/rnicholus), [Erin Grand](https://github.com/eringrand), [Léo Colombaro](https://github.com/LeoColomb), [Dean Attali](https://github.com/daattali), [Clayton Errington](https://github.com/cjerrington), [Colton Fitzgerald](https://github.com/coltonfitzgerald), [Trace Mayer](https://github.com/sunnankar) - Thanks for your [fantastic contributions](https://github.com/barryclark/jekyll-now/commits/master) to the project!

## Contributing

Issues and Pull Requests are greatly appreciated. If you've never contributed to an open source project before I'm more than happy to walk you through how to create a pull request.

You can start by [opening an issue](https://github.com/barryclark/jekyll-now/issues/new) describing the problem that you're looking to resolve and we'll go from there.

I want to keep Jekyll Now as minimal as possible. Every line of code should be one that's useful to 90% of the people using it. Please bear that in mind when submitting feature requests. If it's not something that most people will use, it probably won't get merged. :guardsman:
