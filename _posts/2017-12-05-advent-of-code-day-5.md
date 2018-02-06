---
author: dandl
comments: true
date: 2017-12-05 13:06:37+00:00
layout: post
link: http://doingandlearning.com/advent-of-code-day-5/
slug: advent-of-code-day-5
title: Advent of Code - Day 5
wordpress_id: 784
categories:
- coding
- Programming
tags:
- Advent of Code
---

**Puzzle - Part 1**

...a list of the offsets for each jump. Jumps are relative: `-1` moves to the previous instruction, and `2` skips the next one. Start at the first instruction in the list. The goal is to follow the jumps until one leads _outside_ the list.

In addition, these instructions are a little strange; after each jump, the offset of that instruction increases by `1`. So, if you come across an offset of `3`, you would move three instructions forward, but change it to a `4` for the next time it is encountered.

[![code-snippet](http://doingandlearning.com/wp-content/uploads/2017/12/Screenshot-2017-12-5-doingandlearning-coding_practice-284x300.png)](http://doingandlearning.com/wp-content/uploads/2017/12/Screenshot-2017-12-5-doingandlearning-coding_practice.png)Importing the file was the same as before - slight problem that my GitHub only has one input file which is the current problem so if you are using my solution you need to make sure you have the right file.

I misunderstood the problem initially.  I thought if any offset with the same value would be changed on each encounter rather than just the element itself.

So, having had a go at the first way I was told my solution was too low - I re-read the problem and saw the issue.  Once I got that it was easy to be able to finish the problem.

**Part 2**

Now, the jumps are even stranger: after each jump, if the offset was _three or more_, instead _decrease_ it by `1`. Otherwise, increase it by `1` as before.

[![code snippet 2](http://doingandlearning.com/wp-content/uploads/2017/12/Screenshot-2017-12-5-doingandlearning-coding_practice1-300x295.png)](http://doingandlearning.com/wp-content/uploads/2017/12/Screenshot-2017-12-5-doingandlearning-coding_practice1.png)

This was a pretty straight-forward addition.  I think there has to be a faster way than I did it.  When I ran this it took a long time and I was convinced I'd done something wrong.  That caused me a delay - once I realised it was working (print statement) - I let it run and got the solution.

**Conclusion**

GH Hardy loved pure mathematics because it had no application to the real world.  Little did he know that his work would be the foundation of cryptography and encryption.  I feel a bit like this with these problems - they aren't immediately applicable to web development problems but I can see that they may be surprisingly useful when I least expect it.
