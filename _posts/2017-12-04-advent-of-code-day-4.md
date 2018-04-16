---
author: dandl
comments: true
date: 2017-12-04 12:09:41+00:00
layout: post
link: http://doingandlearning.com/advent-of-code-day-4/
slug: advent-of-code-day-4
title: Advent of Code - Day 4
wordpress_id: 780
---

**Puzzle - part 1**

A passphrase consists of a series of words (lowercase letters) separated by spaces.

To ensure security, a valid passphrase must contain no duplicate words.

The system's full passphrase list is available as your puzzle input.

_How many passphrases are valid?_

![Screenshot-2017-12-4 doingandlearning coding_practice](http://doingandlearning.com/wp-content/uploads/2017/12/Screenshot-2017-12-4-doingandlearning-coding_practice.png)

I set up a list for the valid passcodes and import the file which I read line by line.

For each line, I create a dictionary and count the number of times each word appears.  I then check that dictionary, if the maximum value is 1 then no word has been repeated and the given phrase can be added to the valid list.

To get the result, I simply print the length of the valid list.

**Part 2**

For added security, yet another system policy has been put in place. Now, a valid passphrase must contain no two words that are anagrams of each other - that is, a passphrase is invalid if any word's letters can be rearranged to form any other word in the passphrase.

![Screenshot-2017-12-4 doingandlearning coding_practice(1).png](http://doingandlearning.com/wp-content/uploads/2017/12/Screenshot-2017-12-4-doingandlearning-coding_practice1.png)

This time, I did exactly the same to begin with.  I now have the list for valid passphrases which minimises the amount of looping I have to do for the anagram checking.

I created a method to check for anagrams using the Counter function from collections.  Then, for each passphrase I checked if there were anagrams that were not the word with itself.  There were a number of passphrases that had more than one anagram so I created a dictionary with the index as the key value.

To get the final result, I subtracted the length of the invalid dictionary from the length of the valid list.

**Conclusion**

I used more print statements in working out where my issues were when I was coding.  That helped a lot.  This puzzle wasn't much different from the earlier one in Day 2 about checksums, so there was lots to be copied.

I'm not sure if I will get to the top 100 in this competition.  I am faster between puzzle 1 and puzzle 2 than average but I'm not at my computer at 6am when the puzzle goes live in my timezone.


