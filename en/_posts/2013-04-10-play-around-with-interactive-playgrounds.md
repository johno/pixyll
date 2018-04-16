---
layout: post
robots: index,follow
published: true
comments: true

jsbin: true
codepen: true

tags: [dabblet, jsFiddle, JSBin, CodePen]
icon: lab

title: Play around with interactive playgrounds
description: JSBin, jsFiddle, dabblet, ... If that doesn't sound familiar to you, you may have a look here and discover what are these "playgrounds" about.
---

## What are we talking about?

An interactive playground is basically an online IDE which allows you to do some front-end development (HTML, CSS and JS most of the time) and visualize the result.

You can also save and share your code with most of them, which leads to a bunch of practical uses:

- **code debug**, as the environment allows you to reproduce a bug or non-desired effect and to isolate the root cause. That's why such tools are [specially appreciated by developers](http://css-tricks.com/seriously-just-make-a-jsfiddle/).

- **snippets creation**, which is very useful to answer a problem or question on [StackOverflow](http://stackoverflow.com/questions/210717/using-jquery-to-center-a-div-on-the-screen) for instance. You can also easily [create showcases](http://dabblet.com/gist/3350582/).

- **teaching concretely**, which is used by websites such [CodeSchool](http://www.codeschool.com) as they developed powerful live challenges to put into practice what you just learned.

This was a nice way to get into the swing. Now let me present you a non-exhaustive overview of web playground I know and like so far.


## JSBin

[JSBin](http://www.jsbin.com) may be one of the very first which became popular. It exists since 2008. It has the classic 4 panels to edit **HTML**, **CSS**, **Javascript** and the **output**. It also disposes of a **Console** panel which stands for a Javascript console after the code being interpreted. Significantly, modifications you made are instantly visible on the output.

Very elaborated, it can interpret Gist directly which is particularly nice for those who use it.

<p class="islet">
    <a href="https://gist.github.com/">Gist</a> is a quick and efficient way that Github proposes to share git versionned code snippets. JSBin can show you directly in your browser the code output so you can modify and save a new version of the Gist.
</p>

It finally has a bunch of nice features such as [JSHint](http://jshint.com/) (a Javascript linter) or the possibility to input the JS/CSS code at a particular place in the HTML with `%code%`/`%css`.

<p class="visuallyhidden--palm">
    <a class="jsbin-embed" href="http://jsbin.com/uduvaf/5/embed?live">Integrated JSBin example</a>
</p>

#### Strengths

- No need to sign in to use it
- Real-time visualisation
- [Gists integration](http://www.youtube.com/watch?feature=player_embedded&v=_GtjaW4Ma3c)
- A lot of functionalities (JSHint, Ajax, templates, ZenCoding, ...)
- Dabblets can be integrated directly into websites, and modified from there


## jsFiddle

[jsFiddle](http://jsfiddle.net) works more or less with the same principles, witha bit different UI.

Features are mostfully the same but jsFiddle allows you also to code in [SASS](http://sass-lang.com/) instead of CSS, and [CoffeeScript](http://coffeescript.org/) instead of Javascript. That could be an argument for preprocessors aficionados.

Bonus point: HTML is reduced to the strict minimum, there is no need to specify the `<head>` part, nor the doctype. Your code will directly be injected into the `<body>`. You can still configure all of this on the different sections of the sidebar.

<p class="islet">
    <a href="https://twitter.com/csswizardry">Harry Roberts</a> currently uses jsFiddle as a showcase of <a href="http://jsfiddle.net/user/inuitcss/fiddles/"><em>inuit.css</em></a> features, so you can have a quick overview of the framework capacities before you decide to download it.
</p>

<p class="visuallyhidden--palm">
    <iframe width="100%" height="300" src="http://jsfiddle.net/espeon/stVTF/embedded/" allowfullscreen="allowfullscreen" frameborder="0">Integrated jsFiddle example</iframe>
</p>

#### Strengths

- No need to sign in to use it
- Gists integration
- A lot of functionalities (TidyUp, JSHint, Ajax, ZenCoding, ...)
- Possibility to use CSS/JS preprocessors
- Fiddles can be integrated directly into websites, but not modified from there


## CodePen

[Codepen](http://codepen.io) is another popular example of interactive playgrounds. It comes with a different styling approach and a well-established business model. Indeed, CodePen has [a PRO version](http://codepen.io/pro/) which allows you for instance to give a real-time class or to code all together with collegues, simultaneously, in live.

CodePen offers a bunch of interesting features, preprocessors use including. You should note that if you login with your Github account, your Pens will automatically be converted as Gists in your account. And, by the way, did I say that modification are visible in real-time?

<p class="islet">
    On the flip side, <strong>you must be connected if you want to integrate Pens into websites</strong>, which doesn't mean you have to create a CodePen account if you already have a Github one. A lot of CodePen features go far further projects I mentioned before, but they are PRO-features (<em>business is business</em>, which is really understandable here).
</p>

<div class="visuallyhidden--palm">
    <pre class="codepen" data-height="300" data-type="result" data-href="geycm" data-user="nicoespeon" data-safe="true"><a href="http://codepen.io/nicoespeon/pen/geycm">Integrated CodePen example</a></pre>
</div>

#### Strengths

- No need to sign in to use it
- Real-time visualisation
- Save Pens as Gists
- A lot of functionalities (JSHint, Ajax, ZenCoding, ...) and more with a PRO account
- Possibility to use CSS/JS/HTML preprocessors
- Pens can be integrated directly into websites, but not modified from there


## dabblet

[dabblet](http://dabblet.com/) is a bit different of its kind. Indeed, **this one is CSS focused** and not Javascript (you already have JSBin and jsFiddle for that dudes).

<p class="islet">
    <a href="https://twitter.com/LeaVerou">Léa Verou</a>'s idea was to give an alternative which doesn't bother with HTTP request each time you do/code something in the editor. If that makes sense for Javascript, there is no need for these request when you just want to play arount with HTML/CSS.
</p>

Under his nicely designed UI, dabblet also offers a bunch of features such as real-time visualisation, inline previewers which are definitely useful to visualize CSS properties (lengths, colors, effects, ...) and the native use of [-prefix-free](http://leaverou.github.com/prefixfree/), the ultimate luxury for any CSS developer. You can use CSS3 properties without thinking about prefixes issues as it deals with it when necessary.

<p class="islet">
    You might note that, under requests pressure, dabblet is experimenting the possibility to integrate Javascript. But there are good reasons to bet that it will just be an add-on and not the cutting edge of the platform.
</p>

<p class="visuallyhidden--palm">
    <iframe width="100%" height="400" src="http://dabblet.com/gist/5360845" allowfullscreen="allowfullscreen" frameborder="0">Intergrated dabblet example</iframe>
</p>

#### Strengths

- No need to sign in to use it
- Real-time visualisation
- Total synchronisation with Gists
- Inline previewers and massive use of -prefix-free for CSS development
- Dabblets can be integrated directly into websites, and modified from there


## The problem is choice

There's tons to give enough environments to please anyone. Each developer can choose the solution which fits the most its needs, the one he likes and seduced him the most. Just like IDE, you can give each of them a try and decide by yourself which tool is the best for you.

- I personnaly used **jsFiddle** a lot until then...

- ... I keep an eye on **JSBin**, but I never felt the need to change for it yet...
- ... **CodePen** doesn't fit my needs, even though I find it cool...
- ... and **dabblet** is my coup de coeur I recently discovered. It's not as mature as the others but already has remarkables assets which justify the try.
