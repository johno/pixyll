---
layout: post
title: "Rapid Single-Page Application prototype with AngularJS & jsFiddle"
author: "Jose A. Dianes"
date: "12 October 2014"
comments: true
categories: development prototyping
tags: JavaScript AngularJS JSFiddle
---

Imagine we have just developed a brand new RESTful API, and we want to demostrate how easy is to use it and how quickly we can develop **Single-Page Web applications**. An elegant way of building a prototype aplication is by using **AngularJS** and **jsFiddle**.

#### AngularJS  

I find [AngularJS](https://angularjs.org/) a very sophisticated and well made application framework. Created by **Misko Hevery** and now maintained by Google and community, it is based in the solid [MVC architectural style](http://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller). It enriches the `html` directives and simplifies the connection of *models* with *views* and *controllers*. Its popularity nowadays is immense, and is becoming one of the frameworks of choice in the industry for developing [Single-page dynamic web applications](http://en.wikipedia.org/wiki/Single-page_application).  

There are lots of good documentation and tutorials both, in the AngularJS website and in Youtube. I find this [series of video tutorials](https://github.com/curran/screencasts/tree/gh-pages/introToAngular) very easy to follow. There you can find up to 50 examples code together with references to other tutorials and related frameworks.  

#### jsFiddle  

[jsFiddle](http://jsfiddle.net/) is a playground for web developers, an online editor for snippets build from HTML, CSS and JavaScript. It allows including other popluar JS libraries and additional external dependencies. You can also share your Fiddle, embedded it on a blog just like we are doing in this post (as an `<iframe>`), share it on the social networks, etc. Your code may be shared from GitHub and displayed as new Fiddle.  

And we can also sahre the isolated rendered result as a web application prototype.   

Although the documentation is not great, it is enought for solving those things that are not intuitive within the user interface, that are not many by the way.  

#### The PRIDE Archive web service  

The [PRIDE PRoteomics IDEntifications database](http://www.ebi.ac.uk/pride/archive/) is a centralized, standards compliant, public data repository for proteomics data, including protein and peptide identifications, post-translational modifications and supporting spectral evidence. There is also a [web service](http://www.ebi.ac.uk/pride/ws/archive/project/list?show=100&page=1&order=desc) that is publicly available.  

#### The SPA prototype  

Our prototype is pretty simple, including a small `html`, and a bit of `JavaScript`. We use [Bootstrap](http://getbootstrap.com/) to style things. First the `html`.  

<iframe
  style="width: 100%; height: 400px"
  src="http://jsfiddle.net/jadianes/vm4tm931/embedded/html/light">
</iframe>

The layout is pretty much a `<table/>` with the results and an `<input/>` text box where we can place the search terms. Things to mention here:  

* There is a `<div/>` elements tagged as the AngularJS application.  
* There is another `<div/>` inside the previous one, tagged as the AngularJS controller manipulated from withing the JavaScript section.  
* The results are listed in a table, filtered by an AngularJS expression using the search term, and referencing *model* entities withing the *projects* results.  

Following is the `JavaScript` section doing the AngularJS MVC magic.  

<iframe
  style="width: 100%; height: 400px"
  src="http://jsfiddle.net/jadianes/vm4tm931/embedded/js/light">
</iframe>

Basically, we get a reference to the AngularJS application and use it to add a controller associated with the `PrideSearchCtrl` element we referenced within the `<div/>` in the `html` part. The controller uses [JSONP](http://en.wikipedia.org/wiki/JSONP) to load data from the PRIDE Archive web service and assing this data the the Model object `projects`. We also set `publicationDate` as the default order-by field for the results. Important here to add the `?callback=JSON_CALLBACK` at the end of the `URL` for `JSONP` to [work properly](http://stackoverflow.com/questions/12066002/parsing-jsonp-http-jsonp-response-in-angular-js).  

The working prototype can be found [here](http://jsfiddle.net/jadianes/vm4tm931/embedded/result/).  




