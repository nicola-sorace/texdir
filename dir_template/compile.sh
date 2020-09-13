#!/bin/bash
rm document.aux document.fdb_latexmk document.fls document.log document.out document.pdf document.toc wordcount.txt
latexmk -pdf -pvc --shell-escape document.tex # & sleep 1; zathura report1.pdf
