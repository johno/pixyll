---
layout: post
title: Emacs Vs Vim... FIGHT!
date: 2019-04-3
summary: If Emacs and Vim had a fight to the death, who would win?
categories: productivity vim emacs tooling
---

[Disclaimer]: I am in no way an expert at either of these tools, I have had a fair amount of experience with both, to the point where I have a sound opinion on both.

![Cover photo](/images/2019-04-03Cover.png)

For those of you who are unaware, there has been a heated debate (war) going on between supporters of Vim and supporters of Emacs for years now, these are not the only contenders, there are supporters of [Nano](https://www.nano-editor.org/) who pitch in on the debate too and many more, but these are the biggest runners in my opinion.

Possibly, there may be a few of you out there (sadists) who still like to use [ed](https://www.gnu.org/software/ed/manual/ed_manual.html#). And for those of you who don’t, I challenge you to use it for a day without throwing your keyboard.

And if you ever meet someone who tells you Vim and Emacs are a step backward then issue the same challenge to them.

## Vim

This tool is an extremely powerful text editor in the corrected hands, and an extremely effective random character generator in the wrong hands (it’s `:wq` to exit FYI).

### Background

[Vim](https://www.vim.org/) (Vi IMproved) as the title suggests, is an improvement of the text editor [Vi](http://ex-vi.sourceforge.net/), an editor designed for the Unix operating system. Initially released in 1991 it gained traction due to how light it was. It is popular among tech specialists as it is installed by default on most Unix based operating systems, and can be used through the command line.

![Vim start screen](/images/2019-04-03Vim.png)

### First Impressions

The first thought that entered my head when I saw Vim being used was ‘This looks complicated’ it seemed like some kind of arcane witchcraft that I didn’t understand. The next thought was ‘Holy moly this is efficient!’.

I picked Vim up first a couple of years back when pairing with a fellow dev, who swore by Vim, he would fly around files using all the shortcuts like it was breathing, faster than I would be able to use any graphical text editor.

<img style="float: left; margin-right: 20px;" src="/images/2019-04-03VimAdventures.jpg">

The most daunting part of this for me was how will I effectively edit text when I can’t remember the shortcuts, so he pointed me to [Vim Adventures](https://vim-adventures.com/) an online game where you can iteratively learn the shortcuts, I would recommend this for people who want to use Vim but need a few layers of complexity to be explained.

Once I had the hang of the basics, and at this point, I was editing files at about a tenth the speed I usually would be, but I was learning.

### Intuitiveness

To me, once I had a handle of the basic functionality, the controls were logical and made sense, you had your movement keys like `w` which will move you forward a word. You can repeat anything by prefixing a number so `2w` will move 2 words. And commands can take a movement key as a parameter, so `d` is to delete, therefore `d2w` will delete 2 words, intuitive, right? Once you learn these things you can start streamlining everything you do.

You can then string these together and process huge files using macros.

### Packages

<img style="float: left; margin-right: 20px;" src="/images/2019-04-03VimPackages.png">

Next, I was introduced to the packages that were available, largely I followed my Sensei’s configuration and mirrored the packages he had, one-by-one adding them and integrating them into my workflow. Starting with [NerdTree](https://github.com/scrooloose/nerdtree), a package to help you traverse a codebase, without something like this you will need to exit every time you want to switch file or memorize the relative path.

The packages are lightweight, and easy to install when you have a manager like [Vundle](https://github.com/VundleVim/Vundle.vim). It’s as simple as editing your `.vimrc` and running `:PluginInstall`. The selection is huge, from themes to [git integrations](https://github.com/tpope/vim-fugitive), and ways to [transform Vim into a .Net IDE](https://github.com/OmniSharp/omnisharp-vim). A good chunk of packages come from [Tim Pope](https://github.com/tpope) the developer of [Pathogen](https://github.com/tpope/vim-pathogen) another popular package manager for Vim, I would recommend looking at his repos and seeing what you could find useful.

### Pros:

* Plug ‘n play — You can easily pick up anyone’s instance of Vim and know how to use it, there’s a risk that they may have remapped a few things but largely you will be able to use it straight away.
* Lightweight — The base install for Vim as a package for Ubuntu is 2.8 MB (approx), which is tiny compared to Emacs which sits at 100MB (approx).
* Customizable — The large library of packages means that you can tailor your version to be exactly how you need it.

### Observations (could be seen as a Pro, could be seen as a Con):

* Requires building from scratch — The base installation has few features, for basic text editing, and you need to build on this yourself, which ultimately ends with you having an instance of Vim perfectly tailored to you.

### Cons:

* Steep learning curve — Basic text editing is hard at first, and unless you know how to use it at an advanced level, you are not going to be editing efficiently.

For those interested [here](https://gist.github.com/Joe-Davidson1802/eb1b8d92908d533e01d2a548199bd7d9) is my (slightly outdated) `.vimrc`.

## Emacs

Described as “An extensible, customizable, free/libre text editor — and more.” emphasis on the “and more” as Emacs truly is a versatile piece of software. Since extensions can easily be made using Lisp, there is a massive variety of packages available to you.

### Background

Emacs, the name coming from (Editor MACroS), is a text editor with different a different “mode” for every task. It is made to be fast and increase productivity with shortcuts and macros, all written in Lisp. Although Vim has support for tasks other than text editing, Emacs seems to have a bigger toolset for other operations.

<img style="float: left; margin-right: 20px;" src="/images/2019-04-03Emacs.png">

### First Impressions

I heard of Emacs through my research into Vim, I was already thoroughly sold on the idea of boosting productivity with Vim, and dismissed Emacs due to my strong bias. Though I still downloaded it and had a short play around with it, and immediately noticed how, out of the box, it had much more packaged with it (if that is a good thing is for you to decide). To me, this was frightening, as with Vim I knew how to use all the packages because I had installed them all and learned about them individually.

About 2 years of using Vim later I decided I would give it a proper chance, I heard that [Spacemacs](http://spacemacs.org/) was a good place to start, and was good for preventing [RSI](https://www.nhs.uk/conditions/repetitive-strain-injury-rsi/), it changes the focus from Alt to the Spacebar, which is less of a strain to reach. Learning of Emacs’ evil-mode (eVIl mode, like VIm) was another large factor in why I gave it a better chance (and use it now) because I could take the text editing advantages of Vim and combine it with the amazing features of Emacs.

### Intuitiveness

My previous experience with Vim was a major advantage so I can’t speak about learning Emacs from scratch, but there still was a learning curve, like how to manage packages using [MELPA](https://melpa.org/#/) and navigating files using [HELM](https://github.com/emacs-helm/helm) and [Dired](https://www.gnu.org/software/emacs/manual/html_node/emacs/Dired.html).

Learning to use Emacs seemed to be much easier, especially in the context of macros, as when you started invoking one you get hints on what key you can use next.

![Emacs Helm](/images/2019-04-03EmacsIntuitive.png)

And after navigating this a few times you can do the controls without looking, to me, this is an improvement on Vim as you don’t need to search up how to use certain packages. Also, there is a search command `Alt-x` or `SPC SPC` (for Spacemacs) which not only lets you search the commands available but shows you the keybind for using it next time.

![Emacs Helm](/images/2019-04-03EmacsSearch.png)

### Packages

There are many packages (layers) that are compatible with Emacs, Spacemacs has a [whole host of layers](https://github.com/syl20bnr/spacemacs/blob/master/layers/LAYERS.org), from music playing to source control. They can be installed very easily by editing the `.spacemacs` file accordingly, this will install a bunch of packages relating to the layer.

My most used layers are:

* [git](https://github.com/syl20bnr/spacemacs/tree/master/layers/%2Bsource-control/git): which installs magit, for VCS management
* [deft](https://github.com/syl20bnr/spacemacs/tree/master/layers/%2Btools/deft): for quick note taking (I have my deft folder in my Google Drive)
* [helm](https://github.com/syl20bnr/spacemacs/tree/c7a103a772d808101d7635ec10f292ab9202d9ee/layers/%2Bcompletion/helm/local): for finding files quickly

### Pros:

* Versatility — If you want a text editor where you can basically do text editing, and everything else as well then I would recommend Emacs, if you configured it correctly you wouldn’t actually need to leave Emacs.

* Macros — Possibly my favorite part of Emacs is the macros, that they are logical, and that you get a map of where you can go next.

### Observations (could be seen as a Pro, could be seen as a Con):

* Feature-rich by default — when you first install Emacs you will have quite a lot of tools at your fingertips without installing additional packages, especially if you opted with Spacemacs.
* Daunting at first — The sheer amount of capabilities leaves you thinking “Where do I start?”

### Cons:

* Steep learning curve — Although it was easier from me, with prior knowledge of Vim, I think it would still be difficult even with the amazing macro framework.

## Conclusion

To answer the question, in my most humble opinion is that Emacs comes out on top, just down to the fact that it can do the same as Vim and much more. I will most likely carry on using Emacs for this reason.

On the other hand, if I were to answer this with a more objective mindset, and be less opinionated, then I would have the (extremely annoying) answer of — it is up to you to decide. I think if you just want to edit files in a quick, streamlined, and custom way the Vim is ideal for you. But, if you want to replace as much of your current workflow as possible with a faster more elegant solution, then I would recommend Emacs, as from here you can edit your files, change music, keep a ledger of your finances… almost everything can be done from Emacs.