---
layout: post
title: Guide to Forking Pixyll
date: 2019-01-26 19:22
summary: Pixyll is available to you under the MIT license.
categories: jekyll pixyll
---

The following is an overview to copying and sharing Pixyll.[^1]

Most people have an understanding of what the copyright and licensing obligations are for source code, but not everyone has practical experience.  There is a lot of information about how to use free and open source source code generally, but not necessarily how it works specifically.

## Basics

Pixyll is free and open source software under the MIT license, a _permissive license_.  You can use Pixyll without charge and it is provided to you, "as is", without warranty of any kind.

These are some of the rights for Pixyll since it is under the MIT license:[^2]

1. You can **copy** Pixyll by forking it on GitHub or by any other means of copying.
2. You can **use** Pixyll to publish your site without restriction or limitation.
3. You can **change** Pixyll as you wish, and you can publish your site with a modified version of Pixyll.
4. You can also **distribute** copies of Pixyll to other people.
5. You can also **distribute modified** copies of Pixyll.

Other rights you have of Pixyll under the MIT license:

- You can **sell** copies of Pixyll, including copies you have modified.
- You can **combine** Pixyll with other works that are under the MIT license, or other permissive licenses, a copyleft license or a proprietary license.  Pixyll already does this itself by using Jekyll, Ruby and other dependencies.
- You can distribute copies of Pixyll to others under either the MIT license or you can **relicense** Pixyll under another license.  This includes a different permissive license, a copyleft license or a proprietary license.

Your only responsibility is to preserve both the copyright notices of Pixyll and the MIT license in your copy or modified work.

## How to

If you've modified Pixyll significantly and want to share your version, especially public copies of the code, then there are a few items you should do.

1. You should probably **rename** your fork of Pixyll with a different name.
2. A new name isn't required by the MIT license, but it is good etiquette.[^3]
3. You should add your name to the **copyright** of your version, and you should preserve the existing copyrights of Pixyll.
4. Maintaining the copyright notices isn't required of the MIT license, but it is suggested by the license and is a good practice for documenting the copyrights of your derived work.

The items above do not apply when you just copied and modified Pixyll in small ways to just publish your site and you have no plans to fork Pixyll under a different name.

If you want to publish a fork of Pixyll under a different name but keeping it under the MIT license, then you should add your name to the copyright notices:

    Copyright (c) 2019 Your Name
    Copyright (c) 2014-2019 John Otander for Pixyll

However, if you want to publish a fork of Pixyll under a different name *and* a different license, then you should should still add your name to the copyright notices but have a section titled "Pixyll" at the bottom of your LICENSE file that preserves the copyright and license notices for Pixyll:

    Pixyll
    
    Copyright (c) 2014-2019 John Otander
    
    MIT License
    
    Permission is hereby granted, [...]

If you are just modifying Pixyll in small ways to customize your site, you are not obligated to maintain the copyright notices of Pixyll on your site.  However, if you want to credit the Pixyll theme that would be appreciated, see section on "Pixyll Plug" in the README file that came with Pixyll.

Thanks for using Pixyll, and happy hacking!

---
[^1]: **Disclaimer**: This material is for informational purposes only, and should not be construed as legal advice or opinion.  For actual legal advice, you should consult with professional legal services.
[^2]: This list of privileges are derived from the four freedoms of "The Free Software Definition" published by the GNU project <https://www.gnu.org/philosophy/free-sw.en.html>.
[^3]: Using a different name from "Pixyll" for your derivate work helps avoid misdirected questions from people who are using your version.  It's similar to using version numbers to discrimate the revisions of software when troubleshooting issues.
