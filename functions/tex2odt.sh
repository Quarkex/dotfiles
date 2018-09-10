function tex2odt {
      name="${1%.tex}";

      latex2html "$name.tex" -split 0 -no_navigation -info "" -address "" -html_version 4.0,unicode &&
      libreoffice --headless --convert-to odt:"OpenDocument Text Flat XML" "$name/index.html"
}
