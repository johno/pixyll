---
layout: post
title: Azure Storage for Your Website
date: 2019-07-11
summary: |
 Part 1 of a series to setup an Azure storage account to host a static
 website
tags: azure storage website
---
Use Azure Storage and Verizon CDN to create a custom website using your own 
domain name for a few cents a month.  In this article we will also look at how to setup
https for the website and redirect domain name requests to index.html.
Seems like a piece of cake... until you actually try it.

## Problem
How do you create a website using Azure Blob Storage and link it to a custom
domain name using https.  Additionally, the website should redirect http to https
and example.com to www.example.com.  It should also render index.html by
default.  

All these things seem very basic but as it turned out was not all that
straightforward.  Hopefully this post can help others who are struggling with
the same use cases.  And if your *TL;DR* then you can skip to the [Happy
Ending](#ending).

## Solution 

### Part 1 - Getting the Basic Website Configuration Setup
The first thing we need to do is secure the domain name we want to use with
Azure.  This can be done through any number of domain registrars.  I happen to
use [Porkbun](https://porkbun.com) because of their low cost and user friendly
user interface, and besides who doesn't want to do business with a company
called Porkbun... right?

In this post we'll setup a website for  __azurepatterns.com__ as an example. Also 
noteworthy is the fact that I'm on a Mac so I'll be using Unix commands versus Powershell or CMD.

Once we've got a name it's time to do some work at the registrar before we get
started in Azure.  One thing to note about the Azure Commercial Cloud is that
it assigns a domain name to your storage account by default during creation.
This domain's name is __blob.core.windows.net__.  This means that whatever name you
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
>> az group create -n azurepatterns -l eastus

>> az storage account create --name azurepatterns \
    --custom-domain web.azurepatterns.com 
    --location eastus \
    --resourcegroup azurepatterns \
    --kind StorageV2


>> az storage blob service-properties update \
    --account-name azurepatterns \
    --static-website \
    --404-document error.html \
    --index-document index.html 

```

The previous commands created a storage account, assigned our custom domain to
it and also set up a special $web container in blob storage for our website.
You can go ahead and add some basic content to this blob container such as an
index.html file and an error.html file.  These will be useful for testing as we
continue to setup our website.  

At this point you might think that you have an accessible website at
www.azurepatterns.com, at least I did the first time through, but that was sadly not the case.  If you
visit the URL http://web.azurepatterns.com you'll first be given an error message about the site
being insecure due to SSL naming issues and then once you've accepted the risk
you'll be given the following message...

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
My first headscratcher... so after fumbling through loads of bad or incomplete documentation.  I
finally stumbled across a [bug
report](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-https-custom-domain-cdn)
that led me to the
[solution](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-https-custom-domain-cdn).
Apparently the URL generated for our web blob container does not allow anonymous
read access.  That makes sense unfortunately it wasn't obvious and took some
time to figure out given the unhelpful error message :(

So let's take a look and see what the storage account provides for endpoints.

```terminal
>> az storage account show --name azurepatterns \
    --output json \
    --query primaryEndpoints

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
>> az cdn profile create --resource-group azurepatterns \
    --name azurepatternscdn \
    --sku Premium_Verizon

Location    Name              ProvisioningState       ResourceGroup   ResourceState
-----------------------------------------------------------------------------------
EastUs      azurepatternscdn  Succeeded               azure-patterns  Active

```
At this point we've provisioned the CDN but now need to create an endpoint to
manage within the CDN.  We'll create an endpoint named azurepatterns and let it
know we are pointing it at www.azurepatterns.com.  This will create an endpoint
within the CDN called azurepatterns.azureedge.net

Back at our registrar we will need to create a new CNAME record for our CDN
endpoint __www.azurepatterns.com__ that points to
__azurepatterns.azureedge.net__, our CDN endpoint.

Once this is done and propagated we can connect the dots and let our CDN know
that www.azurepatterns.com is a custom domain that it is managing. 

```terminal
>> az cdn endpoint create --name azurepatterns \
    --profile-name azurepatternscdn \
    --origin azurepatterns.z13.web.core.windows.net \
    --resource-group azurepatterns \
    --origin-host-header azurepatterns.z13.web.core.windows.net 

>> az cdn custom-domain create --endpoint-name azurepatterns \
    --hostname www.azurepatterns.com \
    --name www \
    --profile-name azurepatternscdn \
    --resource-group azurepatterns

```

Now all that's left is too make sure we have SSL certificates for our domain
propagated across the CDN.  For this we are back to our __az cdn__ command and
we'll use the __enable-https__ subcommand.  One thing that tripped me up when
first trying the enable-https subcommand is the __-n name__ option.  I was
expecting the name would be www.azurepatterns.com but it actually turned out to
be __www__ instead.

```terminal
>> az cdn custom-domain enable-https \
    --endpoint-name azurepatterns \
    --name www \
    --profile-name azurepatternscdn 
    --resource-group azurepatterns

```
__NOTE:__  This last command is not one where you go grab a coffee and when you
get back you are all set.  This command will take up to 8 hours to complete
since SSL certificates for your domain are being generated, the domain name is
being verified and then the content and configuration is being propagated throughout the Verizon network. In fact I would wait a good 12-16 hoursbecause even after Azure reports that the certs are deployed it can still take a few hours before they are really available.

We are 90% there and have completed all that we can do from the command line to
get our site up and running.  At this point you should have a working site at
https://www.yourdomain.com, however we still need to connect yourdomain.com to
www.yourdomain.com and redirect traffic from http://www.yourdomain.com to
https://www.yourdomain.com.  

Setting up yourdomain.com to point to www.yourdomain.com is a DNS registrar
task, so I will leave that one to you but getting the redirect from http to
https is actually a feature of the Verizon Premium CDN.  So if you were
wondering why we used that particular CDN now you know.  The other CDNs in Azure
don't have a Rules engine that you can tinker with for redirections.  However,
this point is already too long so we'll tackle that next bit in a seperate post.

## Happy Ending!!<a name="ending"></a>

For everyone who doesn't want to walk through these instructions to create a
website in Azure... and who could blame you.  I've written a [Bash
script](https://raw.githubusercontent.com/msft-csu/azure-scripts/master/paas/az-create-website) that
will do it for you :).  You'll need a few things:
* Existing Storage Account and Resource Group 
* Privileges to modify the Storage Account as well as setup a CDN
* Azure CLI installed and logged into a valid subscription
* Environment variable named AZURE_AUTH_LOCATION pointing to a file created with
  __ad sp create-for-rbac --sdk-auth > authfile__
* Machine with __jq__ and __curl__ installed
* DNS records created at the registrar of your choosing for
    * __web__.domain.com -> \<storageacct_name>.blob.core.windows.net
    * __www__.domain.com -> \<storageacct_name>.azureedge.net

