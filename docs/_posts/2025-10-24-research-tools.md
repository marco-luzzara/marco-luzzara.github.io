---
title: "First-class Research Tools"
categories:
  - Toolkit
layout: single
tags:
  - Overleaf
  - Zotero
  - Latex
---

This post describes the research tools I am using during my PhD. 

## Building the papers' library

You typically start with some ready-to-read papers, maybe recommended by your supervisor; first thing to do is to save and organize them. The most popular tool to do that is [**Zotero**](https://www.zotero.org), for which exists a browser extension too. It will be your library for the entire research period, and for this reason, make sure to organize your paper in multi-level folders if necessary.

You can copy the BibTex for each article you have saved using the *Quick Copy* function. This can be configured on *Edit" => *Settings* => *Export*, and in *Item format* select *BibTex*.

## Discovering phase

One of the most time-consuming research activities is discovering new papers from the research line you are studying. To build the state of the art, you might have to explore a lot of papers and the risk of reading some unnecessary and unrelated stuff is high. The traditional search engine for academic works is Google Scholar, but there are ways to speed this up. In particular, if you need to find related works, I suggest you these tools:

- [**Research Rabbit**](https://researchrabbitapp.com/home):
    - Sync with Zotero
    - Build a graph from a collection of papers
    - *Graph Type = Timeline* to order papers according to the publication date
- [**Connected Papers**](https://www.connectedpapers.com)
    - Prior and derivative works
    - Filter by year
- [**Litmaps**](https://app.litmaps.com)
    - ❌ No advanced filters (unless you pay)

[This article](https://effortlessacademic.com/litmaps-vs-researchrabbit-vs-connected-papers-the-best-literature-review-tool-in-2025/) outlines the pros and cons of the above online tools.

For semantic-based researches, many AI-powered tools are available:

- [Semantic Scholar](https://www.semanticscholar.org/search) (a search engine, just like Google Scholar)
- [Elicit](https://elicit.com) and [Consensus](https://consensus.app)

In case you are looking for a dataset, there is [Dataset Search](https://datasetsearch.research.google.com).


### Ranking papers and conferences

How do you know if the conference where the paper has been published is a top-quality one?
One service that shows you the ranking of conferences is [ICORE](https://portal.core.edu.au/conf-ranks/).

For the papers you have identified, it may be useful to check the rank of the conference where it has been presented. If the conference rank is low, the paper might not be as remarkable as you believed. **This does not absolutely mean that all papers presented during a low-ranked conference are cheap**.

Another tool that ranks conferences and journals, but using objective metrics, is [Scimago](https://www.scimagojr.com/journalsearch.php). For each result, you see its H-index and quartile. **Q1** means that the journal/conference is in the best 25%.


## Writing

Overleaf is the most popular collaborative online application that you can use to write papers. To compile your work offline, `pandoc/latex` Docker image is a good alternative, especially when paired with VSCode and Devcontainers (and possibly extensions).

The tools I suggest are:

- [Mathpix](https://mathpix.com/image-to-latex) - image to latex, convert images of math, text, and tables to LaTeX
- [tablegenerator](https://www.tablesgenerator.com) - generate latex table from UI
- [Beamer](https://www.overleaf.com/learn/latex/Beamer_Presentations%3A_A_Tutorial_for_Beginners_(Part_1)%E2%80%94Getting_Started) - create presentation with latex
- [Mathcha.io](https://www.mathcha.io/editor) - Export images and math expression, convenient for exporting images to tikz

- Bibliography-related:
    - [BibTex Tidy](https://flamingtempura.github.io/bibtex-tidy) - Tidy the bibliography
    - [Cite this for me](https://www.citethisforme.com)/[doi2bib](https://www.doi2bib.org) - Get the bibtex from an url (and other sources)
    - [Google Scholar BibTeX Copier](https://chromewebstore.google.com/detail/google-scholar-bibtex-cop/ihccfpbmoeeiibppdgcjjcoahggpfohl) - It automatically copies the bibtex code when you click on Cite -> BibTex in Google Scholar. Otherwise, you have to copy it manually and close the web page opened by Google scholar. This extension can be paired with [Google Scholar Button](https://chromewebstore.google.com/detail/google-scholar-button/ldipcbpaocekfooobnbcddclnhejkcpn?hl=en), which repeats the last browser research on Google scholar without switching page.
    
### AI-Generation tool

- [NotebookLM](https://notebooklm.google.com) - Select the collection you want to include on NotebookLM, *"Export Collection..."* => Check *Export notes*, *Export files*, and *Include annotations*. Make sure the format is *Zotero RDF*, save it in a folder and `cd` into it. Then run:
    ```bash
    mkdir -p exported-pdfs && find . -name "*.pdf" -exec mv '{}' exported-pdfs/ \;
    ```
    All files are saved into the `exported-pdfs` folder.

- [YomuAI](https://www.yomu.ai) - subscription based tool, but offers free tools (see the footer of the website)


<script>
  Array.from(document.links)
    .filter(link => link.hostname != window.location.hostname)
    .forEach(link => link.target = '_blank');
</script>

