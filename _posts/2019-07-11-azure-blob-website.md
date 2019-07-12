---
layout: post
title: Azure Storage for Your Website
date: 2019-07-11
summary: Use Azure Storage and Verizon CDN to create a custom website using your own domain name for "basically" nothing
categories: azure storage website
---

## Problem
How do you create a website using Azure Blob Storage and link it to a custom
domain name.  Additionally, the website should redirect http to https
and example.com to www.example.com.  It should also render index.html by
default.  

All these things seem very basic but as it turned out was not all that
straightforward.  Hopefully this post can help others who are struggling with
the same use cases.

## HowTo


