function faviconize {(
    convert "$1" -background none -define icon:auto-resize=64,48,32,16 ${2:-favicon}.ico
)}
