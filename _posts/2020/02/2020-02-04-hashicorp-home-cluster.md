---
title: "HashiCorp Home Cluster"
layout: post
date: 2020-02-04
---
<center><img src="/images/hashilogo.webp" alt="HashiCorp" class="avatar" /></center>
<br />

It's been a hot minute (as my teenager daughter says it) since I started at HashiCorp as a developer on the Terraform Cloud team (we are [hiring like crazy](https://grnh.se/896abd501) btw) and while the firehose at work has soaked me completely - I hadn't had much exposure to many of the other HashiCorp Products other than [Packer](https://packer.io/).

Turns out we eat a lot of our own dogfood at Hashi and the devops flow that folks like I use to get code into production utilizes Hashi products under the hood. After asking dumb question after dumb question internally about how things worked, I figured it would be a better idea to learn the products themselves. And what better way to do that than run them at home?

<center><img src="/images/rpi-intensifies.gif" alt="Raspberry Pi Intensifies" class="avatar" /></center>

Most of the devices on my home network are already <s>frankensteined </s> provisioned for other purposes and configuration of those felt like it would be more of a challenge so I went and got a bunch of Raspberry Pis instead and networked them all together. This is the story of how that all went down.

* auto-gen TOC:
{:toc}

# Prior Art
I'm not the first person to go down this road - it seems that the Raspberry Pi lends itself to lots of cool stuff and some other brave citizens have setup HashiCorp tools at home.  Here are the resources I used to help set things up:

1. [Marco Lancini](https://www.marcolancini.it/offensive-infrastructure/) - goes over how Consul works and describes a "HashiStack" provisioned with Ansible on a single VM, not Raspis
2. [Tim Perret](https://github.com/timperrett/hashpi) - finding Tim's GitHub repo really inspired a bunch of stuff that I did here - using Ansible first and foremost
3. [Mockingbird Consulting](https://www.mockingbirdconsulting.co.uk/blog/2019-01-05-hashicorp-at-home/) - helped a lot with Traefik setup

Many thanks to all of these folks for letting me stand on the shoulders of giants. Look at their code, read their blogs, it helps.

# Hardware



# Software
What software?
