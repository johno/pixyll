---
author: dandl
comments: true
date: 2017-12-01 15:30:12+00:00
layout: post
link: http://doingandlearning.com/advent-of-code-day-1/
slug: advent-of-code-day-1
title: Advent of Code - Day 1
wordpress_id: 769
categories:
- coding
- Programming
tags:
- advent
- code
---

For the past few years, Eric Wastl has been posting a series of small programming puzzles during the [days of advent](http://adventofcode.com/2017). The puzzles are in two parts, which are often related, and are at a variety of skill levels.  I'm going to aim to do these puzzles each day and blog about my progress.  I'll also be posting my notebook to [GitHub here](https://github.com/doingandlearning/coding_practice).

**The puzzle - part 1:**

Find the sum of all digits that match the next digit in the list.  The list is circular, so the digit after the last digit is the first in the list.


    
    <span class="k">def</span> <span class="nf">circ_sum</span><span class="p">(</span><span class="n">target</span><span class="p">):</span>
        <span class="n">total</span> <span class="o">=</span> <span class="mi">0</span>
        <span class="n">target</span> <span class="o">=</span> <span class="nb">map</span><span class="p">(</span><span class="nb">int</span><span class="p">,</span> <span class="nb">str</span><span class="p">(</span><span class="n">target</span><span class="p">))</span>
        <span class="k">for</span> <span class="n">i</span> <span class="ow">in</span> <span class="nb">range</span><span class="p">(</span><span class="mi">0</span><span class="p">,</span><span class="nb">len</span><span class="p">(</span><span class="n">target</span><span class="p">)</span><span class="o">-</span><span class="mi">1</span><span class="p">):</span>
            <span class="k">if</span> <span class="n">target</span><span class="p">[</span><span class="n">i</span><span class="p">]</span><span class="o">==</span><span class="n">target</span><span class="p">[</span><span class="n">i</span><span class="o">+</span><span class="mi">1</span><span class="p">]:</span>
                <span class="n">total</span> <span class="o">+=</span><span class="n">target</span><span class="p">[</span><span class="n">i</span><span class="p">]</span>
        <span class="k">if</span> <span class="n">target</span><span class="p">[</span><span class="nb">len</span><span class="p">(</span><span class="n">target</span><span class="p">)</span><span class="o">-</span><span class="mi">1</span><span class="p">]</span><span class="o">==</span><span class="n">target</span><span class="p">[</span><span class="mi">0</span><span class="p">]:</span>
            <span class="n">total</span><span class="o">+=</span><span class="n">target</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span>
        <span class="k">return</span> <span class="n">total
    </span>



So I made a function with a name that wasn't great - circ_sum (circular sum) - need to work on my naming.  I wanted to use a list comprehension strategy and so needed to convert the integer to a list - I used a map to do that.

I then looped through the list and did the comparision - if they matched they got added to the total and I dealt with the last terms separately.

I initially used two for loops but realized my error.

**Part 2:**

Now, instead of considering the next digit, it wants you to consider the digit halfway around the circular list.  The list will always have an even number of terms.


    
    <span class="k">def</span> <span class="nf">circ_sum_step</span><span class="p">(</span><span class="n">target</span><span class="p">):</span>
        <span class="n">total</span> <span class="o">=</span> <span class="mi">0</span>
        <span class="n">target</span> <span class="o">=</span> <span class="nb">map</span><span class="p">(</span><span class="nb">int</span><span class="p">,</span> <span class="nb">str</span><span class="p">(</span><span class="n">target</span><span class="p">))</span>
        <span class="n">step</span> <span class="o">=</span> <span class="nb">len</span><span class="p">(</span><span class="n">target</span><span class="p">)</span><span class="o">/</span><span class="mi">2</span>
        <span class="k">for</span> <span class="n">i</span> <span class="ow">in</span> <span class="nb">range</span><span class="p">(</span><span class="nb">len</span><span class="p">(</span><span class="n">target</span><span class="p">)</span><span class="o">-</span><span class="mi">1</span><span class="p">):</span>
            <span class="k">if</span> <span class="p">(</span><span class="n">i</span> <span class="o">+</span> <span class="n">step</span><span class="p">)</span> <span class="o"><</span> <span class="nb">len</span><span class="p">(</span><span class="n">target</span><span class="p">):</span>
                <span class="k">if</span> <span class="n">target</span><span class="p">[</span><span class="n">i</span><span class="p">]</span><span class="o">==</span><span class="n">target</span><span class="p">[</span><span class="n">i</span><span class="o">+</span><span class="n">step</span><span class="p">]:</span>
                    <span class="n">total</span> <span class="o">+=</span><span class="n">target</span><span class="p">[</span><span class="n">i</span><span class="p">]</span>
            <span class="k">else</span><span class="p">:</span>
                <span class="k">if</span> <span class="n">target</span><span class="p">[</span><span class="n">i</span><span class="p">]</span><span class="o">==</span><span class="n">target</span><span class="p">[</span><span class="n">i</span><span class="o">-</span><span class="n">step</span><span class="p">]:</span>
                    <span class="n">total</span> <span class="o">+=</span><span class="n">target</span><span class="p">[</span><span class="n">i</span><span class="p">]</span>
        <span class="k">if</span> <span class="n">target</span><span class="p">[</span><span class="nb">len</span><span class="p">(</span><span class="n">target</span><span class="p">)</span><span class="o">-</span><span class="mi">1</span><span class="p">]</span><span class="o">==</span><span class="n">target</span><span class="p">[</span><span class="n">step</span><span class="o">-</span><span class="mi">1</span><span class="p">]:</span>
            <span class="n">total</span><span class="o">+=</span><span class="n">target</span><span class="p">[</span><span class="n">step</span><span class="o">-</span><span class="mi">1</span><span class="p">]</span>
        <span class="k">return</span> <span class="n">total
    </span>



I copied my original function and scoped a variable step based on half the length of the list.  This time, I needed to check whether the sum of the step and index term were greater than the length of the list.

I made an error in the else clause initially in which I had target[step-i] in the comparison.  Took me a few minutes to notice it but once I did it all went well.

**Conclusion**

I didn't find this too challenging.  There are probably better ways to do this and I'll have a look but my method worked and got the result I wanted.  I got my two stars and I'm looking forward to tomorrow's puzzle.


