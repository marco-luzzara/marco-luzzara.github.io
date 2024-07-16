## Create the site

To create the site from scratch:

```bash
make create-site THEME_GEM_ID="\"just-the-docs\"" THEME_NAME="just-the-docs/just-the-docs"
```

For the `THEME_GEM_ID`, check the theme github repo for installation steps. For the `THEME_NAME`, use the format `GITHUB_REPO_OWNER/GITHUB_REPOSITORY_NAME` (see [here](https://github.com/benbalter/jekyll-remote-theme?tab=readme-ov-file#declaring-your-theme))

---

## Test site locally

```bash
make serve
```

---

## Change Theme

To change the theme, use `make change-theme` with the same variables used for `create-site` recipe. Here are some examples:

```bash
make change-theme THEME_GEM_ID="\"minimal-mistakes-jekyll\"" THEME_NAME="mmistakes/minimal-mistakes"
```