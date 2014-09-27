---
layout: post
title: "Best subset model selection with R"
author: "Jose A. Dianes"
date: "27 September 2014"
comments: true
categories: data analysis
output:
  html_document:
    keep_md: yes
---

Linear regression models are easy to fit and interpret. Moreover, they are 
suprisingly accurate in many real world situations where the relationship 
between the response and the predictors is approximately linear.

However, it is often the case that not all the variables used in a multiple 
regression model are in associated with the response. Including irrelevant 
variables leads to **unnecessary complexity**. By removing them we can obtain a 
model that is more **easily interpreted**. Additionally, when the number of 
predictors is close to the number of samples, linear models **tend to overfit** 
and therefore to perform badly in their further predictions.  

The *best subset model selection* approach identifies a subset of the 
predictors that show to be related to the response. We can then fit
a model using least squares on the reduced set of variables.  

Here, we are going to do that using `R`.  

#### The `swiss` data set  

We will use the classic `swiss` data set provided with R datasets. We can have 
a look at its documentation.  


{% highlight r %}
data(swiss)
?swiss
{% endhighlight %}

There we see that contains *standardized fertility measure and socio-econimic 
indicators for each of the 47 French-speaking provinces of Switzerlad at about 
1888.* It is composed by 47 observations on 6 variables, each of which is in 
percent (i.e. in [0, 100]), including:  

* Fertility.  
* Agriculture in % of men involded in agriculture as occupation.  
* Examination as % draftees receiving highest mark on army examination.  
* Education as % of education beyond primary school for draftees.  
* Catholic as % of catholic (as opposed to protestant).  
* Infant mortality as % of live births who live less than 1 year.  

We can have a quick look at how these variables interact using some plts.  


{% highlight r %}
pairs(swiss)
{% endhighlight %}

![center]({{ base.url}}/assets/2014-09-27-best-subset-model-selection-with-R/swiss-pairs.png) 

We are interested in predicting infant mortality using a multi linear model.  







