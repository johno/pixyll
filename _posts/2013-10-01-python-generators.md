---
layout: post
title:  Python Generators Example
date:   2013-10-01 21:39:32 -0800
categories: python programming
---
Generators were a mystery to me when I first learned Python. I learned them through an excellent explanation on [Stackoverflow](http://www.stackoverflow.com) about Python [yield keyword](http://stackoverflow.com/questions/231767/the-python-yield-keyword-explained#231855) and generators in general. Generators are more memory efficient than a regular list because they return a sequence lazilily, meaning each item in the sequence gets computed at the last minute.

The other day, I was reading the book [Python for Data Analysis](http://www.amazon.com/Python-Data-Analysis-Wes-McKinney/dp/1449319793/) and found an interesting usage of Python generators in the appendix.

It was the classic coin change problem and Python generators were used to solve it. 

{% highlight python %}
def make_change(amount, coins=[1, 5, 10, 25], hand=None):
    hand = [] if hand is None else hand
    if amount == 0:
        yield hand
    for coin in coins:
        # ensures we don't give too much change, and combinations are unique
        if coin > amount or (len(hand) > 0 and hand[-1] < coin):
            continue

        for result in make_change(amount - coin, coins=coins, hand=hand + [coin]):
            yield result

{% endhighlight %}
