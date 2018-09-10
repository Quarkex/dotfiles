function rtfm { help $@ || man $@ || $BROWSER "http://www.google.com/search?q=$@"; }
