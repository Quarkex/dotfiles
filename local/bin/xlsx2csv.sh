#!/bin/bash
libreoffice --headless --convert-to csv "$1" && vim +"%s/\n^$\n/" +"wq ++enc=utf-8" "${1%%.xlsx}".csv
