---
title: "Latex Templates and Useful Packages"
categories:
  - writing
  - latex
layout: single
tags:
  - Overleaf
  - Zotero
  - Latex
---

This post presents the Latex templates I use along with the packages that I recommend.

## Academic article

```latex
\documentclass[11pt]{article}
\usepackage{biblatex}
\addbibresource{main.bib}
\usepackage[
  top=25mm,
  bottom=25mm,
  left=30mm,
  right=30mm
]{geometry}
\usepackage{hyperref}
\usepackage{url}
\usepackage{titling}
\usepackage{color}
\usepackage{soul}
\usepackage{cleveref}

\title{\Large\bfseries Your title}

\author{
  Marco Luzzara\\
  \small Department of Computer Science\\
  \small University of Milan
}

\date{December 2025}

\begin{document}

\maketitle

\begin{abstract}
Your abstract
\end{abstract}

\section{Introduction}

...

\printbibliography

\end{document}
```

## Recommended Latex Packages

### `titling`
The titling package provides control over the typesetting of the `\maketitle` command and `\thanks` commands, and makes the `\title`, `\author` and `\date` information permanently available.

### `soul`
The package provides hyphenable spacing out (letterspacing), underlining, striking out, etc., using the TeX hyphenation algorithm to find the proper hyphens automatically. `color` package must be installed too in order to use the yellow highlighting (`\hl{}`) 

### `cleveref`
The package enhances LaTeX's cross-referencing features, allowing the format of references to be determined automatically according to the type of reference. Use `\cref` for lowercase reference text, and `\Cref` to capitalized reference text. 


### `array`, `tabularx`, `multirow` for tables
An extended implementation of the array and tabular environments which extends the options for column formats, and provides “programmable” format specifications. It is useful to specify the width of table columns, if they must be fixed. If you don't need to control the width of each cell, but of the entire table and then evenly distribute the space within, use the `tabularx` package.

For example,

```latex
\usepackage{tabularx}
\renewcommand\tabularxcolumn[1]{m{#1}} % vertically center the cell text

\begin{table}[!h]
\centering
\begin{tabularx}{\textwidth} { 
    | >{\centering\arraybackslash\hsize=.1\hsize}X 
    | >{\raggedright\arraybackslash\hsize=.45\hsize}X 
    | >{\raggedright\arraybackslash\hsize=.45\hsize}X | }
\hline
    &
    \multicolumn{1}{|c|}{Centered 1} &
    \multicolumn{1}{|c|}{Centered 2} \\ \hline
    
    Value 1 &
    Value 2 &
    Value 3 \\ \hline
    
\end{tabularx}
\caption{Caption for table}
\label{tab:sample-table}
\end{table}
```

The above table consists of 3 columns:

1. Horizontally centered (`\centering`) column that takes 10% of entire width (`\hsize=.1\hsize`)
2. Column with text on the left (`\raggedright`), takes 45% of entire width
3. Column with text on the left (`\raggedright`), takes 45% of entire width

`\multicolumn` can be used to merge rows and columns, creating larger table cells. Usage examples of this package and the other described in this section are presented [here](https://www.overleaf.com/learn/latex/Tables#Tables_with_a_fixed_width).

...

<script>
  Array.from(document.links)
    .filter(link => link.hostname != window.location.hostname)
    .forEach(link => link.target = '_blank');
</script>

