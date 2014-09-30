---
layout: post
title: "Enterprise Integration vs Systems Distribution"
date: 2012-06-06 22:42:09 +0100
comments: true
categories: architecture
tags: architecture integration distribution
---
Recently, as a part of  my PhD defence, I had to discuss the concept of *Enterprise Integration*, and I decided that a good way of doing it was as a comparison with a more familiar concept, *system distribution*.  

So, a distributed software system is one which potentially runs over a network of computers. The parts of this software system are interdependent and interact in order to achieve a common goal. That is, its parts **are not intended to run independently**.  

In opposition to this, an *enterprise integration system*, is composed of independent applications, that **can run by themselves**, but that coordinate with each other in a loosely coupled way, in order to achieve **a common goal for an enterprise** (a group of organisations with some common goals).  

When building enterprise integration systems, we can use different mechanisms such as:

* Files, that provide a loosely coupled interaction mechanism but lacks of semantics andtimeliness. However, they are a very popular integration mechanism in sequential processing pipelines.
* A shared database, that improves operation semantics but represents a performance bottleneck (and is too slow for most of the integration scenarios).
* Remote procedure invocation, a very popular mechanism in distributed software systems that encapsulates data using operations, allowing peer-to-peer interaction and avoiding performance bottlenecks. However, it couples the parts of the system through the operation interfaces.
* Messaging, that is the prefered solution for enterprise integration systems because of its well defined semantics, its high performance, and its loosely coupled peer-to-peer interaction model.  

Popular messaging middlewares today are **JMS** (if you are using Java), **DDS**, or **AMQP**. A very interesting software engineering area (the one that my PhD was about) is dedicated to the different enterprise integration patters and its properties. And finally, two popular enterprise integration frameworks are **Apache Camel** and **Spring Integration**.  