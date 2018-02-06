---
author: dandl
comments: true
date: 2017-12-02 12:05:36+00:00
layout: post
link: http://doingandlearning.com/advent-of-code-day-2/
slug: advent-of-code-day-2
title: Advent of Code - Day 2
wordpress_id: 773
---

The next step in the journey is to solve a checksum.

**Part 1:**

For each row, determine the difference between the largest value and the smallest value; the checksum is the sum of all of these differences.


    
    <span class="n">filepath</span><span class="o">=</span><span class="s1">'input.txt'</span>
    <span class="n">output</span> <span class="o">=</span> <span class="p">[]</span>
    <span class="k">with</span> <span class="nb">open</span><span class="p">(</span><span class="n">filepath</span><span class="p">)</span> <span class="k">as</span> <span class="n">fp</span><span class="p">:</span>
        <span class="k">for</span> <span class="n">line</span> <span class="ow">in</span> <span class="n">fp</span><span class="p">:</span>
            <span class="n">out</span> <span class="o">=</span> <span class="nb">list</span><span class="p">(</span><span class="nb">map</span><span class="p">(</span><span class="nb">int</span><span class="p">,</span><span class="n">line</span><span class="o">.</span><span class="n">split</span><span class="p">()))</span>
            <span class="n">output</span><span class="o">.</span><span class="n">append</span><span class="p">(</span><span class="n">out</span><span class="p">)</span>
    
    <span class="n">checksum</span><span class="o">=</span><span class="mi">0</span>
    <span class="k">for</span> <span class="n">i</span> <span class="ow">in</span> <span class="nb">range</span><span class="p">(</span><span class="nb">len</span><span class="p">(</span><span class="n">output</span><span class="p">)):</span>
        <span class="n">checksum</span> <span class="o">+=</span> <span class="nb">max</span><span class="p">(</span><span class="n">output</span><span class="p">[</span><span class="n">i</span><span class="p">])</span><span class="o">-</span><span class="nb">min</span><span class="p">(</span><span class="n">output</span><span class="p">[</span><span class="n">i</span><span class="p">])</span>
    <span class="nb">print</span><span class="p">(</span><span class="n">checksum</span><span class="p">)
    </span>



First step is to get the input file imported in the correct format.  For each line, I've split it and converted each term into an integer.  I then append that list to the overall list.

After that, we loop through the terms, calculate difference between the max and the min of each row and add that difference to our checksum.

**Part 2:**

"the goal is to find the only two numbers in each row where one evenly divides the other - that is, where the result of the division operation is a whole number. They would like you to find those numbers on each line, divide them, and add up each line's result."


    
    <span class="n">div_sum</span> <span class="o">=</span> <span class="mi">0</span>
    <span class="k">for</span> <span class="n">i</span> <span class="ow">in</span> <span class="nb">range</span><span class="p">(</span><span class="nb">len</span><span class="p">(</span><span class="n">output</span><span class="p">)):</span>
        <span class="k">for</span> <span class="n">j</span> <span class="ow">in</span> <span class="nb">range</span><span class="p">(</span><span class="nb">len</span><span class="p">(</span><span class="n">output</span><span class="p">[</span><span class="n">i</span><span class="p">])):</span>
            <span class="k">for</span> <span class="n">k</span> <span class="ow">in</span> <span class="nb">range</span><span class="p">(</span><span class="nb">len</span><span class="p">(</span><span class="n">output</span><span class="p">[</span><span class="n">j</span><span class="p">])):</span>
                <span class="k">if</span> <span class="n">output</span><span class="p">[</span><span class="n">i</span><span class="p">][</span><span class="n">j</span><span class="p">]</span><span class="o">%</span><span class="n">output</span><span class="p">[</span><span class="n">i</span><span class="p">][</span><span class="n">k</span><span class="p">]</span><span class="o">==</span><span class="mi">0</span> <span class="ow">and</span> <span class="n">j</span><span class="o">!=</span><span class="n">k</span><span class="p">:</span>
                    <span class="n">div_sum</span> <span class="o">+=</span> <span class="n">output</span><span class="p">[</span><span class="n">i</span><span class="p">][</span><span class="n">j</span><span class="p">]</span><span class="o">/</span><span class="n">output</span><span class="p">[</span><span class="n">i</span><span class="p">][</span><span class="n">k</span><span class="p">]</span>
    <span class="nb">print</span><span class="p">(</span><span class="n">div_sum</span><span class="p">)
    </span>



This process starts of the same but the process for each row is more complicated.

I want to loop through each term, check if it is divisible by every other term and then add together the dividends.

I used a comparison using mod for this and then added it together.  I ended up with a bigger total than the final result.  I realised that I was including the term divided by itself so I added in the j!=k term to make sure this division didn't get added.

**Conclusion**

The main aspect of the challenge here was getting the data into the correct form.  Python has great methods to be able to find everything else.  I had to look up the map function to make sure I got the syntax right.  Day 2 done!
