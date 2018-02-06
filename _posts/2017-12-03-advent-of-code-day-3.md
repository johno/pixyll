---
author: dandl
comments: true
date: 2017-12-03 17:28:20+00:00
layout: post
link: http://doingandlearning.com/advent-of-code-day-3/
slug: advent-of-code-day-3
title: Advent of Code - Day 3
wordpress_id: 777
categories:
- coding
- Programming
tags:
- Advent of Code
---

I struggled to code today's problem - I saw it more as a problem I'd set students in my maths classroom and solved it much like I would have done that.

**Part 1:**

Each square on the grid is allocated in a spiral pattern starting at a location marked `1` and then counting up while spiraling outward. For example, the first few squares are allocated like this:


    
    <code>17  16  15  14  13
    18   5   4   3  12
    19   6   1   2  11
    20   7   8   9  10
    21  22  23---> ...
    </code>



While this is very space-efficient (no squares are skipped), requested data must be carried back to square `1` (the location of the only access port for this memory system) by programs that can only move up, down, left, or right. They always take the shortest path: the [Manhattan Distance](https://en.wikipedia.org/wiki/Taxicab_geometry) between the location of the data and square `1`.


    
    <span class="kn">from</span> <span class="nn">math</span> <span class="k">import</span> <span class="n">sqrt</span>
    <span class="n">target</span> <span class="o">=</span> <span class="mi">289326</span>
    
    <span class="c1"># in an nxn spiral - bottom right is the largest outside value 
    # and is equal to n squared</span>
    <span class="nb">print</span><span class="p">(</span><span class="n">sqrt</span><span class="p">(</span><span class="n">target</span><span class="p">))</span> <span class="c1"># 537.890...</span>
    <span class="c1"># this must be a 538x538 square</span>
    
    <span class="n">n</span> <span class="o">=</span> <span class="mi">538</span>
    <span class="n">bottom_left</span> <span class="o">=</span> <span class="n">n</span><span class="o">*</span><span class="n">n</span> <span class="o">-</span> <span class="n">n</span> <span class="o">+</span> <span class="mi">1</span>
    <span class="nb">print</span><span class="p">(</span><span class="n">bottom_left</span> <span class="o"><</span> <span class="n">target</span><span class="p">)</span> <span class="c1"># true</span>
    
    <span class="c1"># target is on the bottom row of a 538 x 538 grid</span>
    <span class="n">middle</span> <span class="o">=</span> <span class="p">(</span><span class="n">n</span> <span class="o">-</span> <span class="mi">1</span><span class="p">)</span><span class="o">/</span><span class="mi">2</span>
    <span class="nb">print</span><span class="p">(</span><span class="n">middle</span><span class="p">)</span>
    <span class="nb">print</span><span class="p">(</span><span class="n">bottom_left</span><span class="o">+</span><span class="n">middle</span><span class="o"><</span><span class="n">target</span><span class="p">)</span>
    <span class="nb">print</span><span class="p">(</span><span class="n">target</span> <span class="o">-</span> <span class="n">bottom_left</span> <span class="o">-</span> <span class="n">middle</span><span class="p">)</span>
    <span class="nb">print</span><span class="p">(</span><span class="mi">151</span><span class="o">+</span><span class="n">middle</span><span class="p">)</span>



Having encountered a problem similar to this in the past, I knew that the bottom left corner of the spiral in an nxn square was n-squared.  So, I square rooted the target to find out how big the spiral was.  Knowing the spiral was 538x538, I needed to know which side of the spiral it was on.  I checked to see if the bottom left was smaller than the target, it was - so now I know that the target is along the bottom.  But, where?

I worked out the middle of a row and checked if the sum of the bottom_left and middle was less than the target - it was.  I worked out how far along from the middle it was - 151.  I know it takes 151 to travel along the bottom to the middle, now I just need to add on another middle to get to the center vertically.

I did attempt to write a function to do this but it got jumbled somewhere in the middle.  It's over[ on my GitHub](https://github.com/doingandlearning/coding_practice/blob/master/Advent%20of%20Code%202017.ipynb) if you care.

**Part 2**

in the same allocation order as shown above, they store the sum of the values in all adjacent squares, including diagonals.

So, the first few squares' values are chosen as follows:




    
  * Square `1` starts with the value `1`.

    
  * Square `2` has only one adjacent filled square (with value `1`), so it also stores `1`.

    
  * Square `3` has both of the above squares as neighbors and stores the sum of their values, `2`.

    
  * Square `4` has all three of the aforementioned squares as neighbors and stores the sum of their values, `4`.

    
  * Square `5` only has the first and fourth squares as neighbors, so it gets the value `5`.



Once a square is written, its value does not change. Therefore, the first few squares would receive the following values:


    
    <code>147  142  133  122   59
    304    5    4    2   57
    330   10    1    1   54
    351   11   23   25   26
    362  747  806--->   ...
    </code>



What is the _first value written_ that is _larger_ than your puzzle input?

I puzzled with this for a bit - I thought there was probably an elegant recursion tactic to be able to solve it but I wasn't seeing it.  I decided to brute force it with a spreadsheet.

<table cellspacing="0" border="0" >
<tbody >
<tr >

<td align="left" height="17" >
</td>

<td align="left" >
</td>

<td align="left" >
</td>

<td align="left" >
</td>

<td align="right" >295229
</td>

<td align="right" >279138
</td>

<td align="right" >266330
</td>

<td align="right" >130654
</td>
</tr>
<tr >

<td align="right" height="17" >6591
</td>

<td align="right" >6444
</td>

<td align="right" >6155
</td>

<td align="right" >5733
</td>

<td align="right" >5336
</td>

<td align="right" >5022
</td>

<td align="right" >2450
</td>

<td align="right" >128204
</td>
</tr>
<tr >

<td align="right" height="17" >13486
</td>

<td align="right" >147
</td>

<td align="right" >142
</td>

<td align="right" >133
</td>

<td align="right" >122
</td>

<td align="right" >59
</td>

<td align="right" >2391
</td>

<td align="right" >123363
</td>
</tr>
<tr >

<td align="right" height="17" >14267
</td>

<td align="right" >304
</td>

<td align="right" >5
</td>

<td align="right" >4
</td>

<td align="right" >2
</td>

<td align="right" >57
</td>

<td align="right" >2275
</td>

<td align="right" >116247
</td>
</tr>
<tr >

<td align="right" height="17" >15252
</td>

<td align="right" >330
</td>

<td align="right" >10
</td>

<td align="right" >1
</td>

<td align="right" >1
</td>

<td align="right" >54
</td>

<td align="right" >2105
</td>

<td align="right" >109476
</td>
</tr>
<tr >

<td align="right" height="17" >16295
</td>

<td align="right" >351
</td>

<td align="right" >11
</td>

<td align="right" >23
</td>

<td align="right" >25
</td>

<td align="right" >26
</td>

<td align="right" >1968
</td>

<td align="right" >103128
</td>
</tr>
<tr >

<td align="right" height="17" >17008
</td>

<td align="right" >362
</td>

<td align="right" >747
</td>

<td align="right" >806
</td>

<td align="right" >880
</td>

<td align="right" >931
</td>

<td align="right" >957
</td>

<td align="right" >98098
</td>
</tr>
<tr >

<td align="right" height="17" >17370
</td>

<td align="right" >35487
</td>

<td align="right" >37402
</td>

<td align="right" >39835
</td>

<td align="right" >42452
</td>

<td align="right" >45220
</td>

<td align="right" >47108
</td>

<td align="right" >48065
</td>
</tr>
</tbody>
</table>

Again, there are definitely better ways to do this but the numbers were small enough that I didn't think it was much of a hassle.  This is a timed thing and so I went with the solution that would get me there quickest.

**Conclusion**

My background is maths and spreadsheets and teaching problem solving - that's going to be helpful sometimes but it may also make it harder for me to spot a programming solution because I have a solution in my head already.  Saying that, the right tool for the right job, eh?
