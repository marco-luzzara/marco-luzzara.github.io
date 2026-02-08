---
title: "Setting up Latex on VSCode with DevContainer"
categories:
  - vscode
  - latex
layout: single
tags:
  - vscode
  - Latex
  - Docker
---

In this post, we see how to setup VSCode to compile your Latex documents. DevContainer is necessary to avoid installing the Latex compiler directly on your host, but inside a container. 

Prepare a Dockerfile containing the Latex compiler. For simplicity, we are going to install the `texlive-full` package. Copy the below `Dockerfile` into the `.devcontainer` folder. 

```dockerfile
ARG BASE_IMAGE="ubuntu:24.04"
FROM ${BASE_IMAGE}

RUN <<EOF
    apt update
    apt install -y wget git make texlive-full
EOF

USER 1000
```

Create the `.devcontainer/devcontainer.json` file with the following content:

```json
{
    "name": "vscode-multi-layer-assurance",
    "build": {
        "dockerfile": "Dockerfile"
    },
    "customizations": {
        "vscode": {
            "extensions": ["james-yu.latex-workshop"],
            "settings": {
                "latex-workshop.latex.autoBuild.run": "onSave",
                "latex-workshop.latex.outDir": "output",
                "latex-workshop.latex.recipes": [
                    {
                        "name": "latexmk",
                        "tools": [
                            "latexmk"
                        ]
                    }
                ],
                "latex-workshop.latex.tools": [
                    {
                        "name": "latexmk",
                        "command": "latexmk",
                        "args": [
                            // "-shell-escape",
                            "-cd",
                            "-synctex=1",
                            "-interaction=nonstopmode",
                            "-file-line-error",
                            "-lualatex",
                            "-outdir=%OUTDIR%",
                            "%DIR%/main.tex"
                        ]
                    }
                ]
            }
        }
    }
}
```

When opened in a container, it will install the `Latex Workshop` extension and overwrite the default settings to:
- Use the `lualatex` compiler
- Copy the output files into the `output` folder
- Re-compile every time a file is tex file saved

...

<script>
  Array.from(document.links)
    .filter(link => link.hostname != window.location.hostname)
    .forEach(link => link.target = '_blank');
</script>

