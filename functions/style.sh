#!/bin/bash
style(){(
    name="$1";
    shift;
    text="$*"

    # Styles definition

          style_Clear="\e[0m";              style_clear_Clear="\e[0m"
           style_Bold="\e[1m";               style_clear_Bold="\e[21m"
            style_Dim="\e[2m";                style_clear_Dim="\e[22m"
     style_Underlined="\e[4m";         style_clear_Underlined="\e[24m"
          style_Blink="\e[5m";              style_clear_Blink="\e[25m"
        style_Reverse="\e[7m";            style_clear_Reverse="\e[27m"
         style_Hidden="\e[8m";             style_clear_Hidden="\e[28m"

     style_fg_Default="\e[39m";        style_clear_fg_Default="\e[39m"
       style_fg_Black="\e[30m";          style_clear_fg_Black="\e[39m"
         style_fg_Red="\e[31m";            style_clear_fg_Red="\e[39m"
       style_fg_Green="\e[32m";          style_clear_fg_Green="\e[39m"
      style_fg_Yellow="\e[33m";         style_clear_fg_Yellow="\e[39m"
        style_fg_Blue="\e[34m";           style_clear_fg_Blue="\e[39m"
     style_fg_Magenta="\e[35m";        style_clear_fg_Magenta="\e[39m"
        style_fg_Cyan="\e[36m";           style_clear_fg_Cyan="\e[39m"
   style_fg_LightGray="\e[37m";      style_clear_fg_LightGray="\e[39m"
    style_fg_DarkGray="\e[90m";       style_clear_fg_DarkGray="\e[39m"
    style_fg_LightRed="\e[91m";       style_clear_fg_LightRed="\e[39m"
  style_fg_LightGreen="\e[92m";     style_clear_fg_LightGreen="\e[39m"
 style_fg_LightYellow="\e[93m";    style_clear_fg_LightYellow="\e[39m"
   style_fg_LightBlue="\e[94m";      style_clear_fg_LightBlue="\e[39m"
style_fg_LightMagenta="\e[95m";   style_clear_fg_LightMagenta="\e[39m"
   style_fg_LightCyan="\e[96m";      style_clear_fg_LightCyan="\e[39m"
       style_fg_White="\e[97m";          style_clear_fg_White="\e[39m"

     style_bg_Default="\e[49m" ;       style_clear_bg_Default="\e[49m"
       style_bg_Black="\e[40m" ;         style_clear_bg_Black="\e[49m"
         style_bg_Red="\e[41m" ;           style_clear_bg_Red="\e[49m"
       style_bg_Green="\e[42m" ;         style_clear_bg_Green="\e[49m"
      style_bg_Yellow="\e[43m" ;        style_clear_bg_Yellow="\e[49m"
        style_bg_Blue="\e[44m" ;          style_clear_bg_Blue="\e[49m"
     style_bg_Magenta="\e[45m" ;       style_clear_bg_Magenta="\e[49m"
        style_bg_Cyan="\e[46m" ;          style_clear_bg_Cyan="\e[49m"
   style_bg_LightGray="\e[47m" ;     style_clear_bg_LightGray="\e[49m"
    style_bg_DarkGray="\e[100m";      style_clear_bg_DarkGray="\e[49m"
    style_bg_LightRed="\e[101m";      style_clear_bg_LightRed="\e[49m"
  style_bg_LightGreen="\e[102m";    style_clear_bg_LightGreen="\e[49m"
 style_bg_LightYellow="\e[103m";   style_clear_bg_LightYellow="\e[49m"
   style_bg_LightBlue="\e[104m";     style_clear_bg_LightBlue="\e[49m"
style_bg_LightMagenta="\e[105m";  style_clear_bg_LightMagenta="\e[49m"
   style_bg_LightCyan="\e[106m";     style_clear_bg_LightCyan="\e[49m"
       style_bg_White="\e[107m";         style_clear_bg_White="\e[49m"

    # End of styles definition

    echo $in
    echo $out
    echo -n -e "${!in}${text}${!out}"
)}
