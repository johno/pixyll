---
layout: post
robots: index,follow
published: true
comments: true

tags: [git, workflow, management, github]
icon: github-3

title: Which git workflow for my project?
description: A little look around git-flow, GitHub flow and which one to choose regarding your needs.
---

## TL;DR

One of the greatest strenght of git is the simplicity of its branching system.<br>
If you're in charge of a project, you may have wondered: which workflow could I set up to efficiently deal with my project and keep it simple thanks to this cool branching system?

As usual: some people already wondered the same and have found possible solutions to your problem.

The *git-flow* is the most popular with no doubt.<br>
It's a standard branching model that seems to adapt to any project, not that complex to deal with even though there are some specificities to understand.

<p class="islet">If versioning has a meaning for you project, <a href="#the_gitflow">this workflow</a> is for you.</p>

There is a relevant alternative that is far easier: the *Github flow*.<br>
This model has 6 simple rules and doesn't have to consider every subtleties the previous one does.

<p class="islet">If versioning doesn't have a particular meaning for you project de sens and you would like to use an easy workflow, <a href="#the_github_flow">this workflow</a> is for you.</p>


## The git-flow

This workflow has been published the 5th of January, 2010 by [Vincent Driessen](https://twitter.com/nvie) as a successful branching model for git. It covers most of the standard needs for a classical development project.

### How it works

The *git-flow* has the following branching model:

<div class="illustration">
    <img alt="The famous gitflow" title="The famous gitflow" src="/assets/img/git/git-flow-branching-model.jpg">
    The illustrated git-flow model
</div>

We have first the primary branches, fixed and unchanging:

- `master` is the main branch where everything is stable. Each commit is a stable version of the project - a *release* - which could be deployed in production and tagged accordingly (*vX.Y.Z*).

- `develop` is the main branch where development is made. There will be prepared changes for the next release in `master`.

Then come the secondary branches which are flexible over time:

- `feature` starts from `develop` and merge into `develop`.

  When you're working on a specific feature, you create a **feature/xxx** branch. Then, when it's over, you merge it back into `develop` to add the stable feature to the scope for the next release.

- `release` starts from `develop` and merge into `master` or `develop`.

  When `develop` is reflecting the desired state of the future release - every features from the scope have been merged -, you create a **release/xxx** branch. Doing so, you can prepare the next release, correct eventual bugs and continue the development in parallel.

  Once the release is ready - stable - you merge the branch back into `master`, but also into `develop` to update it with modifications you made.

- `hotfix` starts from `master` and merge into `master` or `develop` / `release`.

  When you want to quickly resolve a critical bug in production, you create a **hotfix/xxx** branch. It's kind of a non-planned release.

  When the hotfix is developed, you merge it back into `master` with the according version number, and into `develop` as well - or the according `release` branch, if so - to update it with modifications you made.

### Useful links

You might have a look at [the original post](http://nvie.com/posts/a-successful-git-branching-model/) to go deeper into details.

To make it simple when using the terminal, the author also created [a git extension](https://github.com/nvie/gitflow) that easily implement the *git-flow* for you.

By the way, if you use *SourceTree* you may know that this workflow is [natively implemented](https://www.atlassian.com/git/workflows#!workflow-gitflow).

<p class="islet">If you are a <strong>Windows</strong> or <strong>Mac</strong> user and you're searching for a good graphic client for git/mercurial, I warmly recommend you to <a href="http://www.sourcetreeapp.com/">try SourceTree</a>!</p>


## The GitHub flow

[Scott Chacon](https://twitter.com/chacon) shared this workflow in a blog post the 31th of August, 2011. It's kind of a lightwight version of the previous one which, with a lot of common sense.

You'll notice that I kept the reference to GitHub because of the Scott's blog post, but Atlassian - Bitbucket - presented it as the [*feature branch* workflow](https://www.atlassian.com/git/workflows#!workflow-feature-branch) for instance.

### How it works

I have taken the liberty to illustrate the *GitHub flow* as follows:

<div class="illustration">
    <img alt="The GitHub flow" title="The GitHub flow" src="/assets/img/git/github-flow-branching-model.jpg">
    The illustrated GitHub flow model
</div>

You'll notice that there is only a single `master` branch - no `develop` - and a bunch of features. This model is **extremely simple** and this is precisely the goal. The learning curve est low, developers can quickly master this workflow which is perfectly relevant in some cases.

This workflow follows 6 basic rules:

#### 1. Everything that is in `master` could be deployed in production

**The absolute rule**, same as the *git-flow* by the way. This is the only meaningful branch of the project and it should stay stable in any circumstance so you can base your work upon and deploy it in production at anytime.

#### 2. Create descriptive features branchs from `master`

When you want to develop a feature or a hotfix, for instance, you just create your branch from `master` with an explicit name that describe your work: `bug-grunt-tests`, `infrastructure-ssl` or `module-game-workers` are examples from a project I currently work on, for example.

#### 3. Regularly push to `origin`

In contrary of the *git-flow* where developer doesn't have to push its local `feature` branch to the main repo, you have to regularly do that here.

Indeed, as far as you're not on `master`, the stability of the branch doesn't really matter. Doing so allows you to *communicate* and share your work with the whole team.

#### 4. Open a pull-request at anytime

If your project is hosted on GitHub or Bitbucket, you should know that they both propose an incredibly interesting feature for code review: pull-requests.

It's dead easy then, from any branch, to make a diff with `master` and open a pull-request at anytime: either you think you're done or stuck on something, the pull-request allows you to ask someone else to have a look on what you did. Then, it's possible to comment code, add modifications and visualize precisely what you're about to merge into `master`.

#### 5. Only merge after a pull-request review

This is much more and advice than an absolute rule. It's a best practice that you can use to be sure that the first rule is less likely to be broken, still: a developer should not merge its own branch into `master` when he thinks he is done. Another one should review his pull-request and confirm that the branch is stable.

<p class="islet">Doing so, if `master` becomes a mess because of this merge, you know who gave his agreement... 0:-)</p>

From here you can:

- merge the branch back into `master`, directly from the pull-request
- delete the merge branch, which became useless, on the server

If you are not synchronized anymore with `master` because you spend a long time working on your branch, **you can't merge directly the pull-request** because there would be conflicts. You just need to merge `master` into your branch before, so you can fix conflicts and update your feature before merging it back into `master`.

#### 6. Immediately deploy after you merge into `master`

Once pull-request is valid, your branch is merged into `master` so it means the whole thing is deployed to production, or will be soon.

Doing so, you'll stress on the necessity to keep `master` stable: developers don't want to break everything because of its modifications were deployed, so they're more likely to pay attention about his code stability before merge.

### Few comments

This kind of workflow perfectly fits for projects that doesn't have *release* nor *versions*.

You do continuous integration into `master` and you deploy the stable project to production, sometimes several times a day. You'll probably never rollback on `master`.

Thus, you'll very unlikely add series of big bugs. If problems appears, they're quickly fixed on the go. There is no difference between a big feature and a small hotfix in terms of process. No matters what kind of change you have to do, the workflow still the same and keeps easy to use.

### Useful links

Here again, you might have a look to [the original post](http://scottchacon.com/2011/08/31/github-flow.html) to go further into explanations.

Technically, GitHub is doing his best so you can deal with this entire workflow [directly from your browser](https://github.com/blog/1557-github-flow-in-the-browser). Bitbucket is doing a great job also.

If you ever need, there is also [a git extension](https://github.com/github-flow/github-flow) which helps you to implement the workflow. But I guess you can handle it by yourself, in the browser.


## Final words

To choose the best workflow depends on the nature and needs of your project. It's up to you to consider which of these examples fit more or less with your reality, and adapt a workflow to your needs if so.

These are workflows I typically use so far. If you have other tracks, ideas or comments, please share.
