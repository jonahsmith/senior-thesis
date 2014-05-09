# How this was written

I used a Zotero, R, Markdown, Pandoc, Github workflow.

## Zotero
I used Zotero to keep track of my resources. Great tool, awesome Firefox integration. Also very easy to export BibLaTeX files.

## R
All statistical procedures were carried out in R. Because of the imputation, I had to get each value manually. You'll see that in the code—unfortunately, no ```stargazer``` for me!

## Markdown
The paper was written entirely in Markdown. Very lightweight, and a breeze to use with...

## Pandoc
The swiss army knife of document conversion tools. Really incredible capabilities. Mainly went from Markdown to PDF (via LaTeX) for this project.

## Github
For versioning my writing, I kept a private repository courtesy of my complimentary GitHub for Education account.

## Other tools
- LaTeX: I used LaTeX to write the appendix. I usually find it too clunky for everyday use, but it was invaluable in efficiently typesetting the models.
- I also hesitate to admit that I used Excel to generate some of the tables in the Appendix. Not ideal, but straight-forward, aesthetically-pleasing table generation is a huge weak point of both LaTeX and Markdown, if you ask me. Since I was computing values (almost) one-by-one, I needed a nice interface to keep track of what I was collecting.
- The imputation was run on an Ubuntu server on Amazon Elastic Compute Cloud. I grew out of several smaller ones, and eventually needed to call in the heavy machinery. I should mention that the server time was very generously paid for, in part, by the Columbia College Senior Thesis Fund.