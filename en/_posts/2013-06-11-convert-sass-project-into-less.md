---
layout: post
robots: index,follow
published: true
comments: true

tags: [less, sass]
icon: css

title: Convert a SASS project into LESS
description: Similarities, differences et equivalents between those two CSS preprocessors.
---

## Matters of taste

[LESS](http://lesscss.org/) and [SASS](http://sass-lang.com/) today are [the two most popular CSS preprocessors so far](http://css-tricks.com/poll-results-popularity-of-css-preprocessors/).

They are quite similar and give functionalities to CSS that every front-end developer ever dreamt: variables, functions, mathematical operations, selectors nesting, etc.

However, there are some differences:

- SASS is compiled with Ruby, it has two different syntaxes: `.sass` and `.scss`.<br>
The second one, closer to the CSS syntax, is the most used.
- LESS is compiled with Javascript, it has one syntax which is quite close to the CSS.

As a general rule, we can say that [SASS is more powerful than LESS](http://css-tricks.com/sass-vs-less/) because it notably has a bunch of additional functionalities. However, this is a matter of taste and LESS could suffice enough to please you and, in my opinion, is easier to use at first.

Personnally, **I use LESS instead of SASS** with my projects, mostfully because I get used to it.<br>
In the same time, I tend to use the inuit.css framework (instead of Bootstrap) on these projects. But inuit.css uses SASS!

Hopefully, I'm not the only one who likes LESS and [Peter Wilson](http://twitter.com/pwcc) has worked to create the LESS version of the framework. As I was keen on this idea, I joined the project we are maintaining today: [the official LESS port of inuit.css](https://github.com/peterwilsoncc/inuit.css).

It's all about **traducing the SASS framework into LESS**, which leads us to 3 options:

1. The SASS code is identical to the LESS one, so it's the same principle
2. The SASS code as an equivalent in LESS, so you need to find the alternative
3. The SASS code doesn't have any equivalent in LESS and you need to ruse - or ignore it -

Here is a broad overview of these options, as far as I know.


## What is identical in LESS

In such a case, it's dead easy: there is nothing to do.

Indeed, even though they are differents, SASS and LESS both share some basic concepts.

#### Nesting

One of the guiding principle of CSS preprocessors: selectors nesting.

Instead of creating huge selectors to specify inheritance, you just have to nest them like this:

{% highlight css %}
.islet {
    margin-top: 24px;

    p {
        color: #BADA55;
        font-weight: bold
    }
}
{% endhighlight %}

That will produce the following code, in both languages:

{% highlight css %}
.islet {
    margin-top: 24px;
}

.islet p {
    color: #BADA55;
    font-weight: bold
}
{% endhighlight %}

<p class="islet">
    <strong>Beware</strong> - Developers, whether they are experimented or not, often abuse of nesting which bloats their CSS for no valuable reason.<br><br>
    Keep in mind <a href="http://thesassway.com/beginner/the-inception-rule">the inception rule</a>: <strong>never go farther than 4 nested levels</strong>.
</p>

#### Comments and compilation

In addition to features they bring, preprocessors help you to produce code clear and organized while having a single compiled - and compressed - CSS file as the output for production.

In that spirit, SASS and LESS both have alternate comments that are not compiled into CSS. So this code:

{% highlight css %}
/**
 * The date/time
 */
.timeline__time {
    position: absolute;
    display: block;

    // The actual inner width is `25% - x`, `x` is the padding
    padding-right: 24px;
    width: 200px;
}
{% endhighlight %}

Will produce the following code:

{% highlight css %}
/**
 * The date/time
 */
.timeline__time {
    position: absolute;
    display: block;

    padding-right: 24px;
    width: 200px;
}
{% endhighlight %}

Which could be very helpful in case you want to add some code comments which would not be relevant for production code.

Please note that a compiled file for production should be compressed so it doesn't have CSS comments neither, excepted if you decide to preserve them. [YUI compressor](http://yui.github.io/yuicompressor/css.html) uses `/*! */` to preserve CSS comments for instance.

#### Imports

Preprocessors help you to import other files very easily with `@import`, which allows you to build a clear and modular architecture of your source files. Dare I say: CSS preprocessors are OOCSS best friends.

A best practice may be to create a `main.less` / `_main.scss` file which role is to import the source file you need to produce your final `main.css`:

{% highlight css %}
/**
 * Setup
 */
@import "inuit.css/defaults";
@import "vars";
@import "inuit.css/inuit";


/**
 * She’s all yours, cap’n... Begin importing your stuff here.
 */
@import "ui/base";
@import "ui/layout";

@import "ui/mod-block-list";
@import "ui/mod-helper";

/* etc. */
{% endhighlight %}

You'll note here that it's pointless to add the extension, whatever preprocessor you use.

<p class="islet">
    <strong>Beware</strong> - All likeness taken after, the <code>@import</code> command of preprocessors has nothing to do with CSS one. Indeed, preprocessors will import your files when you compile them to output a unique CSS file that will be used in production. But CSS import will load many files by the browser.<br><br>
    Please note that the use of <code>@import</code> is <a href="http://browserdiet.com/#prefer-link-over-import">not a very good CSS practice</a>, try to avoid it.
</p>


## What has an equivalent in LESS

In such a case, you mainly have to know the syntax and specificities of each language as fundamentals principles are the same. Let's see what you've got...

#### Variables

SASS and LESS both allow you to create variables, which is basically the Holy Grail in CSS!

The concept is very straight forward. The only difference here is that SASS uses `$` while LESS uses `@`.

{% highlight css %}
/* With SASS */
$color: #BADA55;

.header {
    color: $color;
}
{% endhighlight %}

{% highlight css %}
/* With LESS */
@color: #BADA55;

.header {
    color: @color;
}
{% endhighlight %}

And so the CSS output is:

{% highlight css %}
.header {
    color: #BADA55;
}
{% endhighlight %}

#### Mixins

SASS and LESS both allow you to create what we call **mixins**. That means that you could simply create groups of properties that can be quickly included wherever you want to.

Here again, the main difference is the syntax, not the concept:

{% highlight css %}
/* With SASS */
@mixin bordered {
    border-top: dotted 1px black;
    border-bottom: solid 2px black;
}

.header {
    @include bordered;
}
{% endhighlight %}

{% highlight css %}
/* With LESS */
.bordered() {
    border-top: dotted 1px black;
    border-bottom: solid 2px black;
}

.header {
    .bordered();
}
{% endhighlight %}

This will output:

{% highlight css %}
.header {
    border-top: dotted 1px black;
    border-bottom: solid 2px black;
}
{% endhighlight %}

You should know that mixins can do more and have parameters, default values, conditions, etc.

Without going further into details, you should know also that mixins can take a **variable number of arguments** into account.

However, while SASS deals perfectly with the different values you give to the parameters, you would have to escape those you pass to LESS if you don't want him to interpret the whole thing as a single big variable.

<p class="islet">Escaping in LESS would return the exactly given output thanks to <code>~"my string"</code>, which could be helpful for a bunch of tips.</p>

Technically, code is the following:

{% highlight css %}
/* With SASS */
@mixin box-shadow($shadows...) {
    -moz-box-shadow: $shadows;
    -webkit-box-shadow: $shadows;
    box-shadow: $shadows;
}

.shadows {
    @include box-shadow(0 4px 5px #666, 2px 6px 10px #999);
}
{% endhighlight %}

{% highlight css %}
/* With LESS */
.box-shadow(@shadows...) {
    -moz-box-shadow: @shadows;
    -webkit-box-shadow: @shadows;
    box-shadow: @shadows;
}

.shadows {
    .box-shadow(~"0 4px 5px #666, 2px 6px 10px #999");
}
{% endhighlight %}

And that would produce this CSS:

{% highlight css %}
.shadows {
    -moz-box-shadow: 0 4px 5px #666, 2px 6px 10px #999;
    -webkit-box-shadow: 0 4px 5px #666, 2px 6px 10px #999;
    box-shadow: 0 4px 5px #666, 2px 6px 10px #999;
}
{% endhighlight %}

Excepted some little specificities, mixins just work the same.

#### Operations

Every preprocessor has is bunch of mathematical operations which could be very useful to do some flexible styling with variables.

Syntaxes are very close and intuitive - just a matter of `+` and `-`, etc. A best practice is to isolate these operations into parenthesis so you avoid potential confusions and conflicts.

However, you should know that LESS is considering the first unit specified in the calculus, which could lead to some aberrations while SASS will properly output a warning instead of compiling something wrong:

{% highlight css %}
.container {
    width: 300px + 2em; // == 302px o_O
}
{% endhighlight %}

So in LESS you should better **not specify variables unit** so you don't have that kind of nasty surprises when you do operations. You just have to apply the unit at the very end and you're all set:

{% highlight text %}
@base-font-size: 16;
@base-spacing-unit: 24;

html {
    font-size: (@base-font-size/16)*1em;
    margin-bottom: @base-spacing-unit*1px;
}
{% endhighlight %}

Which will produce:

{% highlight css %}
html {
    font-size: 1em;
    margin-bottom: 24px;
}
{% endhighlight %}

#### Functions

Each preprocessor brings their own functions that allow you to do a bunch of very nice things with colors, maths, strings, etc.

You may have a look to each respective list to get an idea:

- [SASS functions](http://sass-lang.com/docs/yardoc/Sass/Script/Functions.html)
- [LESS functions](http://lesscss.org/#reference)

#### Interpolation

Sometimes you'll need to include some variables into stings and interprate them however. That's what we call interpolation and both SASS and LESS allow you to do that:

{% highlight css %}
/* With SASS */
$base-url: "../images";

.container {
    background-image: url("#{$base-url}/bg.png");
}
{% endhighlight %}

{% highlight css %}
/* With LESS */
@base-url: "../images";

.container {
    background-image: url("@{base-url}/bg.png");
}
{% endhighlight %}

Which will produce:

{% highlight css %}
.container {
    background-image: url("../images/bg.png");
}
{% endhighlight %}

The only difference is the syntax: `#{ $var }` with SASS and `@{ var }` with LESS.

You also can interpolate variables within selectors as we could see with loops - yep, I'm working on my transitions -.

#### Loops

Technically speaking, both preprocessors can implement loops which could be very useful.

However, SASS natively deals with the iteration logic, not LESS. In fact, you can use an alternative based on mixins to create the loop behavior with LESS.

With LESS, here is the deal:

1. Create a mixin with an `@index` parameter
2. The mixin will produce the content of the loop while `@index > 0`
3. At the end of the mixin, you decrease `@index`
4. You create an empty verion of the mixin to stop the loop when `@index = 0`

Which leads us to the following syntaxes for a loop:

{% highlight text %}
/* With SASS */
$index: 5;

@while $index > 0 {
    // Interpolate the class name
    .container-#{$index} {
        z-index: $index;
    }

    // Decrease the index
    $index: $index - 1;
}
{% endhighlight %}

{% highlight text %}
/* With LESS */
.loop (@index) when (@index > 0) {
    // Interpolate the class name
    .container-@{index} {
        z-index: @index;
    }

    // Decrease the index and start the loop again
    .loop (@index - 1);
}

// Stop the loop at 0
.loop (0) {}

// Start the loop
.loop (5);
{% endhighlight %}

Which will output, once compiled:

{% highlight css %}
.container-5 { z-index: 5; }
.container-4 { z-index: 4; }
.container-3 { z-index: 3; }
.container-2 { z-index: 2; }
.container-1 { z-index: 1; }
{% endhighlight %}

This technique is used by Bootstrap [to generate spans regarding the number of columns](https://github.com/twitter/bootstrap/blob/master/less/mixins.less#L577-L595).

#### Extend and silent classes

With SASS you can extend a class properties very easily to share a common style, the second class inherits style of the first one.

For instance, this:

{% highlight css %}
.error {
    border: 1px #f00;
    background-color: #fdd;
}

.serious-error {
    @extend .error;
    border-width: 3px;
}
{% endhighlight %}

Will give the following code:

{% highlight css %}
.error, .serious-error {
    border: 1px #f00;
    background-color: #fdd;
}

.serious-error {
    border-width: 3px;
}
{% endhighlight %}

SASS can create what we call *silent classes*: you just define classes that wouldn't be compiled until they are included somewhere with `@extend`.

So this code:

{% highlight css %}
a%error {
    color: red;
    font-weight: bold;
}

.notice {
    @extend %error;
}
{% endhighlight %}

Will output the following:

{% highlight css %}
a.notice {
    color: red;
    font-weight: bold;
}
{% endhighlight %}

With LESS, you'll generally use **mixins** to realize that kind of extensions. Just like a silent class, the mixin won't be compiled until it's included somewhere. So it comes with the same spirit, only the syntax changes:

{% highlight css %}
.error() {
    a& {
        color: red;
        font-weight: bold;
    }
}

.notice {
    .error();
}
{% endhighlight %}

That said, you'll note that SASS is extending smartly selectors - `.error, serious-error` in the previous example. With LESS, you'd need to do that by hand.

<p class="islet">
    <strong>Note</strong> - <a href="https://github.com/cloudhead/less.js/blob/master/CHANGELOG.md#140-beta-1--2">LESS v1.4</a> - which is currently in beta - will introduce <code>:extend()</code> that could handle selectors extension. The syntax would be closer to the CSS one, just like a pseudo-selector, which should produce something like that:
</p>

{% highlight css %}
.error {
    border: 1px #f00;
    background-color: #fdd;
}

.serious-error:extend(.error) {
    border-width: 3px;
}
{% endhighlight %}


#### `!default` variables

With SASS you can set a default value to variables at any time. The default value is used if the variable is not already defined somewhere.

{% highlight sass %}
$base-font-size:    14px;
$base-font-size:    16px !default;
$base-spacing-unit: 24px !default;

.container {
    font-size:        $base-font-size;
    margin-bottom:    $base-spacing-unit;
}
{% endhighlight %}

{% highlight css %}
.container {
    font-size: 16px;
    margin-bottom: 24px;
}
{% endhighlight %}

This technique is very useful because you can define defaults into the core of the module you're developing, so you allow users to override them if necessary **from the outside**.

Need a concrete example? I've got that: the framework core of inuit.css use a bunch of defaults so the developer can use the framework as a submodule: he can update it but he never has to touch it, never!

To override a variable, he just needs to define it in its own configuration file:

{% highlight text %}
.
|-- inuit.css/          # Framework core
|   |-- base/
|   |-- generic/
|   |-- objects/
|   |-- _defaults.scss  # Default variables
|   |-- _inuit.scss     # Setup file for inuit.css
|
|-- ui/
|-- _vars.scss          # Specific variables
|-- main.scss           # Setup file for the project
{% endhighlight %}

So he can override variables in `_vars.scss` and organize `main.scss` as follows:

{% highlight css %}
/**
 * Setup
 */
@import "vars";
@import "inuit.css/inuit";
{% endhighlight %}

Without touching anything from the inuit.css core he is able to configure it entirely.

**The fact is, you ain't gonna need this with LESS.**

Thanks [Chris Snyder](https://twitter.com/KB1RMA) for pointing this out!

For a long time I thought LESS didn't provide the ability to do the same, and I've had to find hacks to this problem.

Actually, variables work differently in LESS since the pre-processor uses [lazy loading](http://lesscss.org/features/#variables-feature-lazy-loading). That means variables can be used **before** being described.

Hence, you can perfectly override variables later in your codebase. Which is the equivalent of having default variables:

{% highlight css %}
@base-font-size:    14px;
@base-spacing-unit: 24px;

.container {
    font-size:        @base-font-size;
    margin-bottom:    @base-spacing-unit;
}

/* … later in your code */
@base-font-size:    16px;
{% endhighlight %}

Will produce the same result:

{% highlight css %}
.container {
    font-size: 16px;
    margin-bottom: 24px;
}
{% endhighlight %}

Hence, we could do the same with inuit.css and use proper (default) variables in the framework while giving the capacity to developers to override them after.

{% highlight css %}
/**
 * Setup
 */
@import "inuit.css/inuit";
@import "vars";
{% endhighlight %}


## What couldn't be reproduced in LESS

Here is a non-exhaustive list of what SASS is able to do and not LESS, without any real alternative but ingenious hacks.

#### Block of content within a mixin

If you are using SASS, you can pass a whole block of content into a mixin thanks to the `@content` variable. Concretely, this:

{% highlight text %}
@mixin apply-to-ie6-only {
    *html {
        @content;
    }
}

@include apply-to-ie6-only {
    #logo {
        background-image: url(/logo.gif);
    }
}
{% endhighlight %}

Will compile into:

{% highlight css %}
*html #logo {
    background-image: url(/logo.gif);
}
{% endhighlight %}

As far as I know, there is no possibility to do that in LESS - but I'd consider any suggestion!

#### Variable properties

With SASS you also can use interpolation to have variable properties. This is extremely useful to create powerful mixins like this:

{% highlight text %}
@mixin border-badass($side) {
    border-#{$side}: 1px #BADA55 solid;
}

.container {
    @include border-badass(left);
}
{% endhighlight %}

Will output:

{% highlight css %}
.container {
    border-left: 1px #BADA55 solid;
}
{% endhighlight %}

**However, you need to do a mixin per property in LESS**, which is very painfull. So you may need to get use of it...

...

... well, in fact, there IS a kind of *weird* hack that can produce the same result. I deny any responsibility for its weirdness, you are smart enough to decide whether or not it worth using it!

The thing is that browsers will ignore unknown CSS properties.

So let's say, `hack: 1;` would'n be very valid right? But it wouldn't be considered. If you keep that in mind and use LESS interpolation over properties values, you'd be able to imagine the following code:

{% highlight text %}
.border-badass(@side) {
    hack: 1 ~"; border-@{side}: 1px #BADA55 solid";
}

.container {
    .border-badass(left);
}
{% endhighlight %}

Which will output:

{% highlight css %}
.container {
    hack: 1;
    border-left: 1px #BADA55 solid;
}
{% endhighlight %}

Technically, it works.

I don't tell you to use it, but we can imagine that you automatically treat your compiled CSS so you delete every `hack:1;` for instance. We can also imagine that LESS will have this feature later.

So keep in mind: it's weird, but it works though...


## Final words

Here we are! That was my 50 cents about main similarities and differencies I experimented between SASS and LESS. To convert a SASS project into LESS isn't that difficult, but you need do take care of each language specificities.

From an objective point of view, SASS is more powerful than LESS and has real programming notions inside. However, its syntax and spirit is even more far from the original CSS compared to LESS, in my humble opinion.

It's much more **a question of habit and comfort**. What counts is that you're using a CSS preprocessor to simplify development and make your stylesheets easier to scale and maintain: the future you will thank the present you for that!

For those who would like to play with it online, here you go:

- [Sass-try](http://sass-lang.com/try.html), for SASS
- [Less2css](http://less2css.org/), for LESS

If you have any suggestion, spot any mistake or have some comments to do on this (long) post, please do.

Plop!
