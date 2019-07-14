---
layout: post
title: Azure Storage for Your Website
date: 2019-07-11
summary: | 
 Use Azure Storage and Verizon CDN to create a custom website using your own 
 domain name for a few cents a month.  In this article we will also look at how to setup
 https for the website and redirect base domain name requests to index.hml.
 Seems like a piece of cake... until you actually try it in Azure.
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

### Part 1 - Getting the Basic Website Configuration Setup
The first thing we need to do is secure the domain name we want to use with
Azure.  This can be done through any number of domain registrars.  I happen to
use [Porkbun](https://porkbun.com) because of their low cost and user friendly
user interface, and besides who doesn't want to do business with a company
called Porkbun... right?

In this post I'm going to be using the name __azurepatterns.com__ as an example.
This is a recent purchase of mine and you may actually be reading this article
from that domain name but for now let's just a basic site up and working with
it.  Also noteworthy is the fact that I'm on a Mac so I'll be using unix
commands versus Powershell or CMD.

Once we've got a name it's time to do some work at the registrar before we get
started in Azure.  One thing to note about the Azure Commercial Cloud is that
it assigns a domain name to your storage account by default during creation.
This domain's name is blob.core.windows.net.  This means that whatever name you
select for your storage account will get a domain name like yourstoragename.blob.core.windows.net 
automactially and since it will be accessible from the Internet it will need to be 
a unique name across all of Azure Cloud.


Okay, so the first thing we need to do is create a CNAME at the registrar that
will point to the new storage account but at this point we don't know if our
name is available in blob.core.windows.net.  We'll use __dig__ and find out:

```terminal

>>> dig azurepatterns.blob.core.windows.net

; <<>> DiG 9.10.6 <<>> azurepatterns.blob.core.windows.net
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NXDOMAIN, id: 44342
;; flags: qr rd ra; QUERY: 1, ANSWER: 0, AUTHORITY: 0, ADDITIONAL: 0

;; QUESTION SECTION:
;azurepatterns.blob.core.windows.net. IN        A

;; Query time: 36 msec
;; SERVER: 192.168.88.1#53(192.168.88.1)
;; WHEN: Sat Jul 13 15:49:16 EDT 2019
;; MSG SIZE  rcvd: 53

```
Our results indicate that the name is available and a storage account can be
created with that name.  The next step is to stop by our domain registrar
to create a CNAME that will map __www.azurepatterns.com__ to __azurepatterns.blob.core.windows.net__.  
Once this is complete and you've given it a few minutes to propagate you can create 
the storage account in Azure using the __az__ CLI tool.

```terminal
>> az storage account create -n azurepatterns --custom-domain www.azurepatterns.com -l eastus -g azure-patterns --kind StorageV2

>> az storage blob service-properties update --account-name azurepatterns --static-website --404-document error.html --index-document index.html 

```

The previous commands created a storage account, assigned our custom domain to
it and also set up a special $web container in blob storage for our website.  At
this point you might think that you have an accessible website at
www.azurepatterns.com, at least I did, but that is not the case.  Sadly, if you
visit that URL you'll be given the following message...

```xml
<Error>
    <Code>
    InvalidQueryParameterValue
    </Code>
    <Message>
    Value for one of the query parameters specified in the request URI is invalid.
    RequestId:3561301b-101e-0049-61e3-395f41000000 Time:2019-07-14T01:29:35.6019427Z
    </Message>
    <QueryParameterName>
    comp
    </QueryParameterName>
    <QueryParameterValue/>
    <Reason/>
    </Error>
    ```

    So let's take a look and see what the storage account provides for endpoints.

    ```terminal
    >> az storage account show -n azurepatterns -o json --query primaryEndpoints
{
    "blob": "https://azurepatterns.blob.core.windows.net/",
        "dfs": "https://azurepatterns.dfs.core.windows.net/",
        "file": "https://azurepatterns.file.core.windows.net/",
        "queue": "https://azurepatterns.queue.core.windows.net/",
        "table": "https://azurepatterns.table.core.windows.net/",
        "web": "https://azurepatterns.z13.web.core.windows.net/"
}
```
Hmmm, so based on this it looks like
__https://azurepatterns.z13.web.core.windows.net__ may actually be the endpoint
for the website, and if we point a browser at that address sure enough that's
where our website is.  

### Part 2 - Mapping the Website to our Custom Domain
So we could go back to our domain registrar and edit the CNAME to point to the
working URL but even if we do that we'll have a custom domain that doesn't have
a valid SSL cert so everytime a new browser visits our site it will get a
warning that the cert doesn't match out website name.  We need to deploy an SSL
cert for our custom domain and this functionality is a part of Azure CDN.  There
are multiple types of CDNs you can use in Azure but the only one that allows us
to create Rules for redirecting requests is the Verizon Premium type.

```terminal

>> az cdn profile create -g azure-patterns -n azurepatternscdn --sku Premium_Verizon

Location    Name              ProvisioningState       ResourceGroup   ResourceState
-----------------------------------------------------------------------------------
EastUs      azurepatternscdn  Succeeded               azure-patterns  Active

```

