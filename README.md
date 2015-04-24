# Meta Notes

[Meta Notes](http://metanot.es) is Junto Studio's blog for
 independent learners.

It runs on [Jekyll](http://jekyllrb.com/), uses [Github Pages](https://pages.github.com/) for hosting, and is a fork of of
 the [Pyxill](https://github.com/johnotander/pixyll/) theme.

The theme is pretty minimal, but leverages large type and
drastic contrast to make a statement, on all devices.

### Index

- [Getting Started with Jekyll](#getting-started-with-jekyll)
- [Contributing a new post](#contributing-a-new-post)

## Getting Started with Jekyll

If you're completely new to Jekyll, I recommend checking out the
documentation at <http://jekyllrb.com> or there's a tutorial by
[Smashing Magazine](http://www.smashingmagazine.com/2014/08/01/build-blog-jekyll-github-pages/).

### Installing Jekyll

If you don't have Jekyll already installed, you will need to go
ahead and do that.

```
$ gem install jekyll
```

#### Verify your Jekyll version

It's important to also check your version of Jekyll since this
project uses Native Sass which
is [only supported by 2.0+](http://jekyllrb.com/news/2014/05/06/jekyll-turns-2-0-0/).

```
$ jekyll -v
# This should be jekyll 2.0.0 or later
```

### Firing up the app

1. Clone the repo so you've got the code locally.
+ Switch to the gh-pages branch.
+ Run the server, as explained below.

### Jekyll Serve

Then, start the Jekyll Server. I always like to give the `--watch`
 option so it updates the generated HTML when I make changes.

```
$ jekyll serve --watch
```

Now you can navigate to `localhost:4000` in your browser to see the
 site.

### Why we use the gh-pages branch

Github pages automatically pushes live the content of the gh-pages branch.

We're keeping the master branch up-to-date with Pixyll's master branch.
This way, when they push new features, we can pull them into our master
 branch and rebase the gh-pages branch on top of it.

## Contributing a New Post

1. Make sure you're on the gh-pages branch.
2. Create your new-post branch (`git checkout -b my-new-post`)
3. Commit your changes (`git commit -am 'Add awesome post'`)
4. Push to the branch (`git push origin my-new-post`)
5. Create new Pull Request.
6. Wait for other's to give you feedback. Improve.
7. Merge Pull Request.

### The anatomy of a good post
- The **headline** consists of 6 to 12 words, where the first and last 3 have the biggest impact. It has fewer than 55 characters.
- Hook your readers with **storytelling**. Start your blog post with a personal anecdote or moment of transparency.
- **Subheads, subheads, subheads**. Use subheads to make your post **scannable**. Also use lists, blockquotes, short paragraphs, and visuals.
- Aim for **1500 words**.
- Have **clear CTAs**. Tweet this. Go here.

For a deeper read, check the
 [Perfect blog post research data](https://blog.bufferapp.com/perfect-blog-post-research-data)
by Buffer.
