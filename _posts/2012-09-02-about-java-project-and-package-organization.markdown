---
layout: post
title: "about Java project and package organization"
date: 2008-09-02 22:41:11 +0100
comments: true
categories: development
tags: development, Java
---
There is a heated debate about what is the most appropriate organization and 
naming convention of Java packages and projects and, by extension, software 
modules. The two approaches are *‘by abstraction layer’* (e.g. model, controller, 
view, etc) or *‘by feature’* (e.g. account). I find that, at least at an inside-tier 
level (e.g. application level), the later approach makes more sense. That is, a tier 
will be contained in a project (e.g. web-service or core) where packages are 
organized by features. Inside of these packages I reproduce the different 
abstraction layers in sub-packages if needed.  

Here are some benefits of by features at top level:  

* Having the project features represented at the top level, helps understanding application domain and the business logic. This is the part of the system that is different for every project. Architectures tend to follow styles and patterns, and are easy to recognize or even guess just considering the kind of system we are developing or just having a look at the sub-packages inside of each feature. Layers are a poor organization because are identical in most projects. They add little information.
* While a software system evolves, less changes are made to its architecture and more features are added. If we organize modules by feature, a new feature (or a change to an existing one) will add a new package to the system. This is easy to do and allows development teams to work independently in a single unit. If we organize by abstraction layers, developers will need to work in multiple packages.
* If we aork in an Agile environment, development teams tend to work vertically or ‘by feature’, in order to complete functionality in each sprint. This makes more valuable a ‘by feature’ separation that allows parties to work in individual modules. In a ‘by layer’ top separation of packages, the parties need to be working in potentially multiple packages or projects.  

However, organizing packages by layer makes easier to reuse or substitute software layers. Reusable interfaces and abstract classes should be imported from independen projects (representing the layers) and then, when used in a project, inserted into the feature module and organised in different sub-packages for different implementations.  