---
layout:     post
title:      Centrality in Graph Theory
date:       2021-03-1 12:31:19
summary:    Short discussioon on centrality in graph theory; how can we measure the importance of vertices in graphs? 
categories: Concepts
---

## Introduction

For a given node in a social network, [centrality](https://en.wikipedia.org/wiki/Centrality) aims to propose methods that represent the importance of graph vertices in terms of a number.  Have you ever had that group of friends you're only friends with because of one person (and also everyone else seems to be in the group because of this one person)? That person would have high centrality.

## How to Measure?

Let's assume we have access to an undirected graph $$G$$ defined as a dictionary mapping vertices to other vertices in the graph, i.e., $$G := \{A : (B, C), B : (A, D, C), ...\}$$.  

One simple measure of centrality is simply the *degree* of the node.  This is the number of edges leading out of the node.  Node $$A$$ has degree 2 in $$G$$ for instance.  Another metric for centrality in a webpage ranking setting could be the [PageRank](https://en.wikipedia.org/wiki/PageRank) of the node.

### Closeness Centrality

A potentially useful way to measure the centrality of a node is the *closeness centrality*. We can define closeness centrality as,

<center> $$ \textrm{Centrality}(v) = \frac{1}{\textrm{Distance to other vertices}} $$ </center>

Continuing with the example from the introduction, the person who "holds the group together" would be close to many people and have high closeness centrality.  To operationalize this formula, we could do something like run [breadth first search](https://en.wikipedia.org/wiki/Breadth-first_search) to compute the pairs distances between $$v$$ and every other node and take the average (or some other statistic).  Where $$m$$ is the number of edges and $$n$$ is the number of vertices, we could run this algorithm in $$O(mn)$$ because we could simply run BFS once.

### Betweeness Centrality

A potential issue with Closeness Centrality is that we might rank a node that is close to many vertices but only through a single node (or few vertices) as having high centrality.  For example, if I'm connected to many people in a group, but only through one friend.  In some sense, I'm less critical to the network, though I'm closely connected to many people.

We can capture this notion using *betweeness centrality*.  Let's consider all pairs of vertices in the graph $$u,w$$.  If the shortest path between all pairs of vertices goes through $$v$$ often, the vertex $$v$$ is probably more important.  We express between centrality as follows,

<center> $$\textrm{centrality}(v) = \sum_{u,w \neq v} \frac{\textrm{Number shortest paths from }u\textrm{ to }w \textrm{ through }v}{\textrm{Number shortest paths from } u \textrm{ to } w }$$</center> 

A simple (but non-optimal) way to compute this metric is to run [Floyd-Warshall](https://en.wikipedia.org/wiki/Floyd%E2%80%93Warshall_algorithm) generate all the shortest paths between vertices on the graph. This algorithm runs in $$O(n^3)$$.  An algorithm than runs in $$O(mn)$$ was proposed in [Brandes 2001](https://www.tandfonline.com/doi/abs/10.1080/0022250X.2001.9990249).

## Takeaways

Depending on the goal, there are many possible ways to express the importance of graph vertices.  

<!-- 
{% highlight ruby lineanchors %}
# The most awesome of classes
class Awesome < ActiveRecord::Base
  include EvenMoreAwesome

  validates_presence_of :something
  validates :email, email_format: true

  def initialize(email, name = nil)
    self.email = email
    self.name = name
    self.favorite_number = 12
    puts 'created awesomeness'
  end

  def email_format
    email =~ /\S+@\S+\.\S+/
  end
end
{% endhighlight %}
 -->