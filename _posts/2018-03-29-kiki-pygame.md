---
layout: post
title: Pygame on Pi Day
date: 2018-03-29 13:30:32 -0800
categories: pygame python piday
---

Kiki's school celebrates [Pi day][piday] by allowing its students to showcase thier [STEAM][steam] projects. Although Kiki was only in kindergarten I wanted her to do a project. As I scouted around the web for ideas I ran across [Hello Ruby][hello-ruby]. They have a novel approach to educating young girls on computers, technology and ultimately, coding. I looked through the site and one of thier play projects was _Make a keyboard_. As a former keyboard nerd, I knew instantly that the project would have to be center around the computer keyboard. 

The [project][ruby-keyboard] provides a printout of stickers to stick on each letter on the keyboard. Hello Ruby, in general, is really nicely done and I even bought thier book which turns out to be a real gem. You should check it out too if you're into teaching your kids computer programming.

Anyways, back to Kiki's STEAM project. I have a few keyboards that I'm no longer using that are sitting and collecting dust. And I'd let Kiki do the stickers on one of them. Then I'd create a small GUI app that would show alphabets when a key on the keyboard was pressed. It would teach the kindergarten kids how simple a computer keyboard really works. It doesn't have to be just boring alphabets, it'd show them the letters along with corresponding animals just like they have been learning in school. That would be the project.

![keyboard stickers][keyboard_pic]

I have an old laplop, a 2007 macbook no less, which was still sort of funtional the last time I took it to Myanmar. I would run that GUI app on it and showcase it on the Pi day. That way if the laptop dies on some unexpected event, such as a random kid accidentally knock it over, it wouldn't be that big of a deal.

![Kid checking out keybaord][piday_event_pic]

Only I would have to create a GUI app. Python has several options for [GUI apps][py_gui] including PyQt and Tkinter. I found Tkinter to be a bit low level, so I thought of trying PyQt. I quickly ran into a problem installing/compiling Qt on my 32-bit mackbook which was still on [Mountain Lion][osx_8]. Apple dropped 32-bit support with thier later OSX releases, so I couldn't upgrade that macbook past Mountain Lion.

So I ended up installing [pygame][pygame] from binary on it. That turns out saving our project whose [source][kiki-project] is on github. Besides pygame has a nice API and it was a pleasure to work with. I intend to explore more with it in the future.

![alphabet animals][screenshot]


[piday]: http://www.piday.org/
[steam]: https://steamedu.com/
[hello-ruby]: http://www.helloruby.com/
[ruby-keyboard]: http://www.helloruby.com/play/12
[py_gui]: https://docs.python.org/3/faq/gui.html
[osx_8]: https://en.wikipedia.org/wiki/OS_X_Mountain_Lion
[pygame]: https://www.pygame.org
[kiki-project]: https://github.com/ypa/kikiKinderPiDay
[keyboard_pic]: /images/piday_keyboard.JPG
[screenshot]: /images/alphabet_dog.png
[piday_event_pic]: /images/tryingout.JPG
