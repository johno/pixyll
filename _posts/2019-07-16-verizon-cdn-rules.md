---
layout: post
title: Verizon Premium CDN Rules for Redirects 
date: 2019-07-15
image: /images/2019-07-15-verizon-cdn-rules/error.png
summary: |
 Part 2 of a post series that sets up some redirect rules using the
 Verizon Premium CDN
tags: azure website cdn
---
In [Part 1]({% post_url 2019-07-11-azure-blob-website %}) of this post we setup
a website using an Azure Storage Acct and configured the Verizon Premium CDN 
endpoint with SSL certificates to host our custom domain name.  In this post
we'll look at the configuration necessary to redirect http to https using the
Verizon tools provided via the Azure portal. 

## Problem
How do you redirect http to https so that users who enter
*http://www.domain.com* into their browsers are redirected to *https://www.domain.com*?

## Solution 
### Part 3 - Setup Redirect Rule in Verizon CDN
Currently, we have a working website that responds to requests at
https://www.azurepatterns.com that was created in [Part 1]({% post_url 2019-07-11-azure-blob-website %}) 
of this post.  However, if someone inadvertently types http:// before our URL
they are connected to the website without using SSL to encrypt traffic.  For this
![Insecure http protocol](/images/2019-07-16-verizon-cdn-rules/error.png){:
.align-left .shadow .outline}
website it's not a big deal but for most websites the appropriate action would
be to redirect the browser to the https version of the website.
The image shown illustrates the problem.  Most user's browsers will alert them to
the fact that SSL is not being use and this could lower confidence
in our website.

As I mentioned in Part 1 of this post the reason I chose the Verizon Premium CDN
option was that it is, currently, the only CDN option that allows user created redirect
rules. 

To access the Rules engine you will need to be logged into the [Azure
portal](https://portal.azure.com) and have access to the subscription that
manages the Resource group and Storage acct we used in Part 1.  From within the portal navigate to
the Resource Group that contains our website and find the resource of type CDN
profile that we created from Part 1 and select it.  You should now see a screen
similar to the following:
![Manage CDN](/images/2019-07-16-verizon-cdn-rules/manage-cdn.png){:full .box
.shadow}

This will open a new window that uses SSO to login to the Verizon configuration
portal.  From here we want to use the __HTTP Large__ option at the top of the
screen and select the __Rules Engine__.
![Rules Engine](/images/2019-07-16-verizon-cdn-rules/rules-eng.png){:full .box
.shadow}

It's now time to create our first rule.  Let's name the rule *HTTP to HTTPS* and
select the __Request Scheme__ option from the dropdown list.  This will populate
a dropdown list for http or https. In our case we want a rule that activates
when the protocol is http.  ![Rules
Engine](/images/2019-07-16-verizon-cdn-rules/new-rule.png){:full .box
.shadow}  
Next we'll select the __+__ sign next to __Features__ and select *URL
Redirect* option with a 301 to alert the browser that this is a permanent
redirect rule.
![Rules Engine](/images/2019-07-16-verizon-cdn-rules/redirect.png){:full .box
.shadow}
At this point we get a Source pattern and a Destination option.
we'll use the following values and then __Add__ our rule to the rules engine.

|--------+--------------------|
| Source | Destination        |
|--------|--------------------|
| (.\*)   | https://%{host}/$1 |
|========+====================|

And that's it... after we wait 4+ hours :(  Once the rule is enabled all users
will be redirected to https://www.azurepatterns.com and our non-SSL site will

So hopefully between this post and [Part 1]({% post_url 
2019-07-11-azure-blob-website %}) you won't waste as much time as I did trying
to get all this right.  If this has been helpful or you find any issues 
feel free to drop me a line and share your thoughts.

