---
layout: post
title: "dangers of inheritance in OO programming"
date: 2012-08-13 22:41:31 +0100
comments: true
categories: development
tags: development java
---
*Note: The following ideas are part of what is considered today good practices in the Java development community, and are very well explained in the book Effective Java (2nd Edition) by Joshua Bloch.*

In *object-oriented programming (OOP)*, inheritance is a way to reuse code of existing objects, or to establish a subtype from an existing object, or both, depending upon programming language support. In the Java programming language, two types of inheritance are possible. Implementation inheritance, where a child class inherits the (public and protected) interface of the parent class, together with the implementation of its methods, and Interface inheritance where the child class just inherits method definitions without any implementation of them. Implementation inheritance is a powerful way to achieve code reuse but, when used inappropriately, may produce fragile software.  

A first, not evident problem, is that **inheritance violates encapsulation**. Because a subclass may potentially reuse the code of its parent superclass, it is depending on its implementation details. This means that the subclass is not just using the superclass interface, but its internal details, violating the principles of encapsulation. In fact, if the superclass implementation changes, the subclass behaviour may potentially change. This is very dangerous when both classes are in different packages and not under the control of the same developer team. Additionally, overriding some parent class method that is reused inside of the own parent class (and therefore by the child class), can be catastrophic.  

If our goal is just to reuse some class implementation, is much safer to **use composition and method delegation instead of inheritance**. As a guide, we should use inheritance just when a class **is indeed a subtype of the parent class**. In this case, any changes in the implementation and behaviour of the superclass is accepted to be changed in the subclass.  

Finally, we have to have in mind that all the previous can be done by third parties using our OO software packages. Therefore, we should **document for inheritance or prohibit it**. That is, for each method that can be overridden by a subclass, we have to document invocation relationships with other methods or make it final. If not, other methods using the overridden one can stop working properly if the subclass changes its expected behaviour.  