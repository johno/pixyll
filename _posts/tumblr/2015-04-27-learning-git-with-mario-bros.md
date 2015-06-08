---
layout:     post
title:      Learning Git with Mario Bros
date:       2015-04-27 09:41:29
summary:    Like playing Mario Bros? Here's one programming lesson hidden in the famous videogame.
categories: code
author:     stefy
---
![mariobros](/images/mariobros.jpg)


###What Mario Bros and Git have in common:

Part of learning how to program is understanding how Git works. Git is an 
open source project started by Linux creator Linus Torvalds. It basically allows
you to make changes to a project by copying the repository to your own system.
Then you can make your changes on your local copy and “check them in” to the 
central server. When I had trouble putting this to practice, Max, our awesome,
back-end lead, came up with this brilliant, yet simple, explanation:

Max began explaining that a **commit** is just like a "checkpoint": a snapshot
of your files in a determined point in time. Now, imagine you are in a Mario game.You're in the middle of world 4. All you see is where you are right now: you 
have 50 coins and 2 lives while you are running for you life! You want to know 
how many lives and coins you had when you crossed the last "checkpoint" 
(meaning when you passed from world 3 to 4). 

To do that, you use `git checkout` (hereinafter referred to as `git co`). 
`git co` allows you to travel through time to see how you were doing in the last 
worlds (in the programming context: to see past files). It updates things in the 
current world (**working tree**) to match the version in the specific world you
like. If no **paths** are given (if you were in world 1, for example),`git co` 
will also update `HEAD`, which is the current world, to set the specific world
as the current. 

Next, you write `git co HEAD~1` (because the last commit was made when changing 
worlds). This does not mean you have to go back through all levels of world 4. Instead, it lets you grasp what was going on in the past, in order to work on top
of that in the future (you'll probably play differently knowing you have one life
left, than you would if you knew you had three, right?) 
Once satisfied with the changes and information you aquired, you write
`git co master` and return to where you were. 

Continuing with this analogy, the branches would be parallel universes in which different things happen at the same time. And every time you make a **merge**, 
you're joining two universes and trying to get everything to fit together 
(the analogy breaks down here a little).

All of this happens in our “master” universe. An example of using a branch would
be that you have a star, but don’t want to risk it on “master”. As a result, you 
make another **branch** (a parallel universe exactly the same up to this point 
in time) and use your star there. If everything works, you can easily merge 
the branch to **master**.  And worst case, you can delete that branch without 
having merged it and nothing happens. You still keep your star. 

###Next Steps

If you ever played Mario Bros (or almost any videogame, for that matter), this 
past explanation can be useful to understand the Git flow. Nevertheless, 
there are other interactive resources on the Internet that can help. 
I recommend:

1. [Try GitHub](https://try.github.io/levels/1/challenges/1)
2. [GitHub Guides](https://guides.github.com/introduction/flow/)
3. [The Git Game](http://pcottle.github.io/learnGitBranching/)
4. [Git Basics](http://teamtreehouse.com/library/git-basics) 




