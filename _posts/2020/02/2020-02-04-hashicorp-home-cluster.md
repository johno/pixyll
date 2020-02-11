---
title: "HashiCorp Home Cluster"
layout: post
date: 2020-02-10
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

The bug for playing with Raspberry Pis really hit when I got one for Christmas last year. I started to set it up and was installing everything directly on the host OS. I got to thinking about how it would be easier if I managed the applications with Docker and some orchestration software.

But these different orchestration tools really shine when you have a cluster of servers to run them on. I don't really have anywhere in my house where I can cable up a rack of servers, so having a small, power-friendly computer like a Raspberry Pi made a lot of sense. Plus, one of the amazing benefits at HashiCorp (did I mentioned we are [hiring like crazy](https://grnh.se/896abd501)?) is that you get a training budget that allowed me to offset a lot of the cost for my cluster.

I ended up purchasing two Raspberry Pis (one fully setup with a case and memory card from [Vilros](https://vilros.com/collections/pi-day-featured-products/products/vilros-raspberry-pi-4-model-b-complete-starter-kit-with-clear-transparent-case-and-built-in-fan?variant=29406723768414)).  Later I added four more which I put into a 4ct case.

So at this point, I have the following hardware:

* 6x [Raspberry Pi 4 Model B (4GB)](https://amzn.to/2vjgwEG/)
* 1x [iUniker Raspberry Pi 4 Cluster Case](https://amzn.to/38h27aH)
* 4x [USB C Cable Short](https://amzn.to/2SfAdWP)
* 4x [CAT 6 Ethernet 1 foot](https://amzn.to/2SgKWk4)
* 4x [Samsung 128GB 100MB/s (U3) MicroSDXC EVO Select Memory Card](https://amzn.to/3bsDqdh)
* 1x [Samsung 64GB 100MB/s (U3) MicroSDXC EVO Select Memory Card](https://amzn.to/3buHE3Z)
* 1x [NETGEAR 8-Port Gigabit Ethernet Unmanaged Switch](https://amzn.to/2HgmMzy)

All of these are sitting nicely behind my monitor on my desk using a shared power supply.

# Software

I read a lot about using Kubernetes or a smaller variation like k3s on the Raspberry Pi cluster, but frankly, it seemed like a huge learning curve given where I work. I can jump into a Slack channel and immediately have access to amazing developers working on HashiCorp's own workload orchestrator [Nomad](https://www.nomadproject.io/). And trust me, I did ask tons of questions.

I ended up using [Ansible](https://www.ansible.com/) playbooks to setup all of the infrastructure. This helped make the deployment more reliable and repeatable.

Note: If you want to jump ahead and look at the code, you can go to [my GitHub repo](https://github.com/veverkap/pistuff) and take a look.

The Pi cluster is running the following software:

* [Consul](https://www.consul.io/) for service discovery and DNS
* [Dnsmasq](http://www.thekelleys.org.uk/dnsmasq/doc.html) for DNS lookups (this forwards to Consul)
* [Docker](https://www.docker.com/) for running containers
* [Nomad](https://www.nomadproject.io/) for workload orchestration
* [Traefik](https://containo.us/traefik/) for edge routing of HTTPS services

## Base Software

All of the servers are setup with various tools including dnsmasq and Docker (using Jeff Geerling's awesome [Docker ARM Ansible Role](https://github.com/geerlingguy/ansible-role-docker_arm)). To make the different Docker containers work, the Raspberry Pis also have various CIFS mounts on them that point at my QNAP NAS.

[site.yml](https://github.com/veverkap/pistuff/blob/master/site.yml) starts with this bootstrap segment:

<script src="https://gist.github.com/veverkap/f0b3bd5329e2cf9c5cc7961cb29b2e7e.js"></script>

## Consul

<center><img src="/images/consul.png" alt="Consul Logo" width="500" class="avatar" /></center>

Consul is great for DNS and service discovery, but when paired with Nomad and Traefik, it's simply:

<center><img src="https://media.giphy.com/media/12NUbkX6p4xOO4/giphy.gif" alt="shia magic" /></center>

You simply add a Nomad job and Consul discovers it and starts listing it in the catalog.  Traefik sees the new record in the catalog and makes it routable instantaneously.

For example, this Nomad job [homeassistant.nomad](https://github.com/veverkap/pistuff/blob/master/jobs/homeassistant.nomad):

<iframe src="https://gist.github.com/veverkap/e90ea33256e74542a27bd874b296a6d2.pibb" frameborder="0" scrolling="yes" width="100%"></iframe>
<hr>

Runs on Nomad like this:

<center><img src="/images/nomadjob.png" alt="Nomad job webui"></center>

And is automagically turned into this on Traefik:

<center><img src="/images/traefik-homeassistant.png" alt="traefik dashboard"></center>

And then I can hit homeassistant.domain.com and see this:

<center><img src="/images/homeassistant.png" alt="homeassistant dashboard"></center>

I have configured three of the servers (rpi1, rpi2 and rpi3) to act as Consul servers and all of the pis are running the Consul client as well.  This allows them to see each other via DNS (rp*.node.consul) instead of having to configure /etc/hosts or some sort of DNS config on each box manually.

Further, I am running a dnsmasq forwarder on each box that maps local DNS lookups (via port 53) for .consul domains to the Consul DNS resolver listening on port 8600 (see [Consul Forwarding](https://learn.hashicorp.com/consul/security-networking/forwarding#dnsmasq-setup) in the Consul guides for more information)


## Nomad

<center><img src="/images/nomad.png" alt="nomad Logo" width="500" class="avatar" /></center>

As mentioned in the Consul section, the integration with Nomad is very robust and automated. I am leveraging the Docker driver for almost everything. For Nomad, I have setup rpi6 as the leader and all of the other Raspberry Pis run the client so that they can be scheduled with jobs.

You can run nomad cli locally and schedule jobs via the command line or you can run jobs via the Web UI.

<center><img src="/images/nomaddash.png" alt="nomad dashboard"></center>

## Traefik

<center><img src="/images/traefik.png" height="200" alt="Traefik Logo" class="avatar" /></center>

Originally, I had planned on using [kibatic/ansible-traefik](https://github.com/kibatic/ansible-traefik) but this role has not yet been updated to Traefik 2.0, which has LOTS of goodies in it that I didn't want to miss out on. I plan on going back shortly and opening a PR to add 2.0 support to that role. Traefik 2.0 is able to dynamically generate ACME TLS certifications with Let's Encrypt and the middleware support that handles authentication is amazing.

<center><img src="/images/traefikdash.png" alt="traefik dashboard"></center>

## Terraform

<center><img src="/images/terraform.png" alt="Terraform Logo" width="500" class="avatar" /></center>

I couldn't go all of this way without at least TRYING to do something on this project with Terraform, could I? So I'm handling all of the public DNS changes with Terraform using the [Terraform Cloudflare provider](https://www.terraform.io/docs/providers/cloudflare/index.html). I am managing ALL of my veverka.net DNS through Terraform Cloud with CloudFlare.

<script src="https://gist.github.com/veverkap/4a6565904cf29f24ac2b1e901e2303ef.js"></script>

If I want to add a new CNAME to my veverka.net domain, I just edit the .tf file, git add and git commit and it is automatically planned on [Terraform Cloud](https://app.terraform.io). I go in and review it and tell it to apply when I know the changes are good.

<center><img src="/images/terraformcloud.png" alt="terraform dashboard"></center>

# Summary

This adventure was full of learning and amazement honestly. I had heard very little about these HashiCorp products before joining the team and now they are a part of my everyday life. If you have any questions, feel free to add a comment below and I'll reply.
