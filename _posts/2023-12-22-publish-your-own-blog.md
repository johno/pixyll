---
layout:     post
title:      Publish a blog like mine within minutes for free
date:       2023-12-22 16:00:00
summary:    Spend your time writting good posts and let others work on the infrastructure
categories: jekyll pixyll
---

Welcome to my very first blog. To show that I believe in knowledge sharing and I am not planning to keep any secrets, I will start by showing you how to publish your own blog like this one with zero knowledge and no money. For the first steps you will only need Git and a GitHub account. Eventually you might want to have jekyll installed, but the core stuff can be achieved without it.

I know absolutely nothing about web design and to be honest I am not willing to learn. That is way too far up the development stack! But I wanted to have my own blog and share information with others. I just needed a fast solution with some quality (not just plain HTML), but keeping in mind that in the end I just need my text to be online. If that is also your case, let's get on with it. Just follow these steps and in a few minutes you will have your own blog online.

### Fork a decent repository

The goal is to avoid that you reinvent the wheel if you don't want to. Please close any tutorial that shows you how to program a blog from a scratch and stick with me. You might have noticed that many blogs look rather similar: they are just forks of the themes that look good and that is exactly what you need. This blog is simply a fork of [pixyll](https://github.com/johno/pixyll) with a couple of minimal customizations. If this theme suits your needs, fork the repo and if it does not, search for another one and fork it. Now let's talk about the fork name.

### GitHub Pages for free

GitHub offers free hosting for pages of your repositories. The trick is that your URL will contain 'github.io' in it unless you have a custom domain. But if you can live with that, let's go on.

The name of the fork will be *your_github_user_name.github.io* where *your_github_user_name* is **obviously** your user name on GitHub. The URL of your blog will be *https://your_github_user_name.github.io/*. Pretty simple, right? If you choose another name, your URL will end up being the one I told you + */the_name_you_chose/*.

Two examples: if your username is 'foo' and you name the fork *foo.github.io*, your URL will be *https://foo.github.io/*. If you name it 'bar', your URL will be *https://foo.github.io/bar/*.

If you want to have a look at the GitHub Pages configuration (you might change the brach used to deploy your blog), go to your repo, click on Settings and then on Pages. The fields are self-explainatory.

Believe it or not, you are almost done.

### Clone the repo and customize it

Yep, you have reached the last step. Actually your blog is already available and you only need to remove the defaults from the template and add your own name, title and posts.

Clone the repo wherever you like with *git clone 'the URL to clone your repo'*. You will get the URL to clone your repo from the 'Code' tab of the repo, just clicking on the green 'Code' button and then copying the URL.

If you have a look at your boilerplate blog, you will see that there is already some basic structure and a couple of posts that you can recycle rather easily. The most general information is in a file named ***_config.yml***. The fields in it are self-explainatory, so you only need to write basic stuff like your name and email address. If you want to have social-media icons, the (surprise!) *show_social_icons* must be set to true. In general, true menas that you want to activate a given property, whereas false means... that you don't. Enter your social usernames for the social networks you want to include.

For example: linkedin_username: javiercarrascocruz adds a LinkedIn symbol with a link to my LinkedIn account.

### Write your own posts and bio

You will have some smaple posts in the ***_post*** directory. You can either add your own files to the directory or even faster, edit one of the existing files your own titles and text. Just don't forget to update the date. For your second post you can just copy your first one and use it as a template.

Similarly, you can customize the 'About me' section by editing the ***about.md*** file and adding your own bio. When you think you are done, commit your changes and push them. Shortly after your blog will be updated.

Now you are good to go. Of course, you can customize many other things and get as deep as you want, but having a nice-looking blog in a few minutes is pretty cool, right?

Enjoy your personal blog and stay tuned.
