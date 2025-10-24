---
title: "My Linux Toolkit"
categories:
  - Toolkit
layout: single
tags:
  - Linux
---

This post is intended as a catalog of Linux tools/softwares I have found useful and worth giving a try.

## Networking

### [Wireshark](https://www.wireshark.org)

It is so popular that it does not need a presentation.

Useful guides:

- [Decrypt TLS traffic](https://wiki.wireshark.org/TLS#tls-decryption)

### [Trippy](https://trippy.rs/guides/usage/)

> Trippy combines the functionality of `traceroute` and `ping` and is designed to assist with the analysis of networking issues.

It does not have to be necessarily installed because there is also the Docker image available. Example:

```bash
docker run -it fujiapple/trippy example.com --udp
```


## Disk Usage

### [ncdu](https://linux.die.net/man/1/ncdu)

> `ncdu` (NCurses Disk Usage) is a curses-based version of the well-known `du`, and provides a fast way to see what directories are using your disk space.

```bash
sudo ncdu <directory>
```

### [Disk Usage Analyzer](https://apps.gnome.org/Baobab/)

Also known as Baobab (from command line `baobab`), it is the default disk usage analyzer in Ubuntu.


## Virtualization/Containerization

### [Virtualbox](https://www.virtualbox.org)

Again, it is so popular that it does not need a presentation.

Notes:

- Install the VirtualBox Extension Pack from [here](https://www.virtualbox.org/wiki/Downloads)

### [K9s](https://k9scli.io)

> K9s is a terminal based UI to interact with your Kubernetes clusters. The aim of this project is to make it easier to navigate, observe and manage your deployed applications in the wild.

- [Commands and Key bindings](https://k9scli.io/topics/commands/)
- [Integration with Hotkeys](https://k9scli.io/topics/hotkeys/)


## Databases

### [DBeaver](https://dbeaver.io)

> DBeaver Community is a free, open-source database management tool for personal projects. Manage and explore SQL databases like MySQL, MariaDB, PostgreSQL, SQLite, Apache Family, and more.

The Enterprise edition is available for academic purposes.


## Image/Video Editing

### [OBS Studio](https://obsproject.com)

> Free and open source software for video recording and live streaming.

### [LosslessCut](https://mifi.no/losslesscut/)

> Shave gigabytes off video and audio files in seconds without loss of quality. LosslessCut simply cuts the data stream and directly copies it over.


## Web Development

### [Postman](https://www.postman.com)

> Postman is the platform where teams build those APIs together. With built-in support for the Model Context Protocol (MCP), Postman helps you design, test, and manage APIs that power both human workflows and intelligent agents.


## Clients

### [Remmina](https://remmina.org)

> Remote access screen and file sharing to your desktop

It includ RDP, SSH, and SFTP client. Pre-installed on Ubuntu.


<script>
  Array.from(document.links)
    .filter(link => link.hostname != window.location.hostname)
    .forEach(link => link.target = '_blank');
</script>