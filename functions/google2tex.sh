#function google2tex {
#      name="${1%.txt}";
#      output="${name}.tex";
#      content="${1}";
#
#      rm "${output}";
#      touch "${output}";
#
#
#      while read p; do
#            if [[ "${p}" =~ ^class: ]] ; then  
#                  content="$(grep -v -E ^class:.*$ "${content}")";
#            fi
#      done <"${content}"
#
#      while read p; do
#
#            if [[ "${p}" =~ ^class: ]] ; then  
#                  read -d '' p <<EOF
#\\\documentclass{$(sed 's/^class://' <<< "${p}")}
#\\\usepackage{graphicx}
#\\\usepackage{listings}
#\\\usepackage{hyperref}
#
#EOF
#            fi
#            if [[ "${p}" =~ ^lang: ]] ; then 
#                  read -d '' p <<EOF
#\\\usepackage[$(sed 's/^lang://' <<< "${p}")]{babel}
#\\\usepackage[utf8]{inputenc}
#\\\usepackage[T1]{fontenc}
#
#EOF
#            fi
#            if [[ "${p}" =~ ^geometry: ]] ; then  
#                  p="\\usepackage[$(sed 's/^geometry://' <<< "${p}")]{geometry}"; 
#            fi
#            if [[ "${p}" =~ ^has:code$ ]] ; then  
#                  read -d '' p <<EOF
#\\\usepackage{color}
#\\\definecolor{dkgreen}{rgb}{0,0.6,0}
#\\\definecolor{gray}{rgb}{0.5,0.5,0.5}
#\\\definecolor{mauve}{rgb}{0.58,0,0.82}
#
#\\\lstset{
#  frame=tb,
#  language=HTML,
#  aboveskip=3mm,
#  belowskip=3mm,
#  showstringspaces=false,
#  columns=flexible,
#  numbers=left,
#  basicstyle={\small\ttfamily},
#  numberstyle=\tiny\color{gray},
#  keywordstyle=\color{blue},
#  commentstyle=\color{dkgreen},
#  stringstyle=\color{mauve},
#  breaklines=true,
#  breakatwhitespace=true
#  tabsize=3
#}
#
#EOF
#            fi
#            if [[ "${p}" =~ ^eop$ ]] ; then  
#                  read -d '' p <<EOF
#\\\begin{document}
#
#EOF
#            fi
#      
#      
#            echo "$p" >> "${output}";
#
#      done <"${content}"
#
#}

