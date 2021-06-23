---
date: "2020-01-28T00:34:41+09:00"
description: test post
draft: false
title: TOML/YAML
weight: -1
---
Most of the configuration is determined through files that are some flavour of markup language (TOML/YAML).

The file `/content/config.yaml` has some of the settings for the page. Besides things like the title, you're not going to want to modify this since it's all very normal, rather than personal choices. Some exceptions are things like depth of table of contents, you can choose how deep you want that to go.

The file `/config/_default/languages.toml`  if you want to specify which languages to use if you turn the language menu back on. I have no intention of supporting anything but my only fluent language so I turned it off. See the original theme's code for more info or search online for localization support for Hugo.

The file `/config/_default/menus.en.toml` outlines what's at the top bar. If you want more, you can add to it just make sure you increment weight (location order) accordingly. `url` needs to match the folder name in `/content/`.

The file `/config/_default/params.toml` has all the fun stuff that turns on/off a lot of the features. Most of them are on by default so you can turn them off to simplify your page. It's also where you create "logo text", etc. Make sure you keep a clean copy of this if you tweak things and just want to reset everything.

I've yet to figure it out but I think you can change the chroma syntax highlighting by fiddling with `/themes/hugo-theme-zdocm/assets/sass/syntax/_syntax.scss` and other nearby files in cousin folders.


