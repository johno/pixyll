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
variables leads to unnecessary complexity. By removing them we can obtain a 
model that is more easily interpreted. Additionally, when the number of 
predictors is close to the number of samples, linear models tend to overfit 
and therefore to perform badly in their predictions.  

The best subset model selection approach identifies a subset of the 
predictors that show to be related to the response. We can then fit
a model using least squares on the reduced set of variables.  

Here, we are going to do that using R.  

### The Swiss data set  


