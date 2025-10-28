---
title: "Configure Ubuntu with Cloud Init"
categories:
  - Automation
layout: single
tags:
  - Cloud-init
---

Suppose you have a new computer, with no OS installed. Before you can actually work on it, you definitely need an OS (let's say, Ubuntu) with a specific set of packages: maybe a Chromium-based browser, Docker, and git, to say a few.

## Cloud-init introduction

The first option you have is cloning your entire hard disk, but this means bringing all the garbage you have in your current computer into the new one. If you want to start from a plain Ubuntu, I suggest you a way to configure it very easily: [**Cloud-init**](https://cloudinit.readthedocs.io/en/latest/explanation/introduction.html). 

> Cloud-init is an open source initialization tool that was designed to make it easier to get your systems up and running with a minimum of effort, already configured according to your needs.

In this post, I will not deepen all the aspects of Cloud-init, you can find a lot of [examples](https://cloudinit.readthedocs.io/en/latest/reference/examples.html) and the available [modules](https://cloudinit.readthedocs.io/en/latest/reference/modules.html) in the official documentation.

## Run `cloud-init`

After installing Ubuntu, `cloud-init` has already run at least once and will not execute again automatically. Ubuntu determines this based on certain "artifacts" that Cloud-init leaves in the filesystem. To remove these artifacts and trick Cloud-init into thinking it has not been executed yet, run:

```bash
sudo cloud-init clean --logs
```

Our brand-new Ubuntu needs:

- The APT repositories (if necessary)
- The packages to install
- Custom configurations

So, create a YAML file that adheres to the Cloud-init format, like this one (`user-data.yaml`):

```yaml
#cloud-config

apt:
  preserve_sources_list: false
  sources:
    vscode:
      source: "deb [arch=amd64] https://packages.microsoft.com/repos/code stable main"
      keyid: "BC528686B50D79E339D3721CEB3E94ADBE1229CF"
    docker:
      # !!! IMPORTANT !!! the source depends on the ubuntu version, so must be changed on a new major version
      source: "deb [arch=amd64] https://download.docker.com/linux/ubuntu noble stable"
      keyid: "9DC858229FC7DD38854AE2D88D81803C0EBFCD88"
    virtualbox:
      # !!! IMPORTANT !!! the source depends on the ubuntu version, so must be changed on a new major version
      source: "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian noble contrib"
      keyid: "B9F8D658297AF3EFC18D5CDFA2F683C52980AECF"

package_reboot_if_required: true
package_update: true
package_upgrade: true
packages:
  - curl
  - ca-certificates
  - thunderbird
  - snap:
    - [kubectl, --classic]
    - [helm, --classic]
  - code
  - telegram-desktop
  - vivaldi
  # --- BEGIN Docker ---
  - docker-ce
  - docker-ce-cli
  - containerd.io
  - docker-buildx-plugin
  - docker-compose-plugin
  # --- END Docker ---
  - git-all
  - postman
  - virtualbox-7.2
  - wireshark
  # --- BEGIN LibreOffice ---
  - libreoffice-calc
  - libreoffice-writer
  - libreoffice-gnome
  # --- END LibreOffice ---
  - xclip
  - remmina

runcmd:
  # Docker - add 1000 user to docker group
  - |
    DEFAULT_USER=$(id -un 1000)
    groupadd docker
    usermod -aG docker "$DEFAULT_USER"

write_files:
  # Custom aliases
  - content: |
      alias clip='xclip -selection clipboard'
      alias rm='trash'
    owner: maluz:maluz
    path: /home/maluz/.bash_aliases
    permissions: '0744'
    defer: true
  # git config
  - content: |
      [user]
      	email = marco.luzzara@hotmail.it
      	name = Marco Luzzara
      [alias]
      	hist = git log --all --decorate --oneline --graph
      	git = !git
      	sua = status -uall
      [init]
      	defaultBranch = main
    owner: maluz:maluz
    path: /home/maluz/.gitconfig
    permissions: '0664'
    defer: true
  # kubectl and helm bash completion
  - content: |
      source <(kubectl completion bash)
      source <(helm completion bash)
    path: /home/maluz/.bashrc
    append: true
    owner: maluz:maluz
    defer: true
  # Templates
  - content: ''
    path: '/home/maluz/Templates/Empty File'
    owner: maluz:maluz
    defer: true
```

You can update the `packages` section with the packages you want to install, and `sources` with the APT repositories to add. While it is straightforward to install a new package, adding an APT repository requires some efforts:

- `source` property: it contains the repository endpoint. You can always find this line in the package documentation. For example, Docker repository is: `deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable`. In the Cloud-init file, I have omitted the `signed-by` property because Cloud-init retrieves that from the `keyid` property.
- `keyid` property: is the GPG key identifier that Cloud-init will use to verify and import the repository's signing key. First, request the GPG key from the endpoint, then pipeline the output to `gpg --show-key`. For example, Docker GPG key is returned from:
    ```bash
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --show-key
    ```
    The string 40-character long is the value of `keyid`.

As for the `runcmd` section, you should reserve a line for each configuration procedure. To execute multiple commands for a single configuration procedure, use YAML multiline string. 

Cloud-init is always executed as root, so you do not need to prepend `sudo` to the commands. For this reason, the `runcmd` scripts have been adapted to modify the default user (1000) environment.

The `write_files` section can be used to write/append content to a file, such as `~/.bash_aliases`, which contains custom aliases. Make sure to set the adapt the `owner` and `path` according to the default user name. `defer: true` is important because it allows to

> Defer writing the file until ‘final’ stage, after users were created, and packages were installed.

If in the cloud-init logs (`/var/log/cloud-init.log`) you see a message like `Skipping module named cc_write_files, no/empty 'write_files' key in configuration`, try removing the `defer` option.

---

Finally, you can run cloud-init modules with:

```bash
# Install the apt repositories
sudo cloud-init single --name cc_apt_configure --file user-data.yaml
# install the specified packages
sudo cloud-init single --name cc_package_update_upgrade_install --file user-data.yaml
# run the runcmd scripts
sudo cloud-init single --name cc_runcmd --file user-data.yaml
sudo cloud-init single --name scripts_user --file user-data.yaml
# write files
sudo cloud-init single --name cc_write_files --file user-data.yaml
```

Then reboot.

To re-run a module, the `cloud-init clean` is mandatory.

<script>
  Array.from(document.links)
    .filter(link => link.hostname != window.location.hostname)
    .forEach(link => link.target = '_blank');
</script>
