#!/bin/bash
# Enough is enough. Use "case" here!
if [[ "$1" == "" ]]; then
    echo "Usage:"
    echo ""
    echo "${0##*/} start: Start the Jekyll server."
    echo ""
    echo "${0##*/} stop:  Stop the Jekyll server."
    echo ""
    echo "${0##*/} enter: Start an interactive shell in the Jekyll server."
    echo ""
    echo "${0##*/} build: Build page."
    echo ""
    echo "${0##*/} import <file> [target]: Copy file inside the server container."
    echo ""
    echo "${0##*/} export <file> [target]: Copy file from the server container."
    echo ""
    echo "${0##*/} regenerate: CAREFUL. Erases current docker images and start again"
    exit 0;
elif [[ "$1" == "start" ]]; then
    docker start carina211-tmp
elif [[ "$1" == "restart" ]]; then
    docker stop  carina211-tmp && docker start carina211-tmp
elif [[ "$1" == "stop" ]]; then
    docker stop carina211-tmp
elif [[ "$1" == "import" ]]; then
    if [[ ! "$2" == "" ]]; then
        docker cp "$2" carina211-tmp:"${3-/root/.}"
    fi
elif [[ "$1" == "export" ]]; then
    if [[ ! "$2" == "" ]]; then
        docker cp carina211-tmp:"$2" "${3-.}"
    fi
elif [[ "$1" == "build" ]]; then
    if [[ ! "$2" == "" ]]; then
        docker exec -it carina211-tmp sh -c 'cd /srv/jekyll/ && jekyll build'
    fi
elif [[ "$1" == "regenerate" ]]; then
    docker stop carina211-tmp
    docker rm carina211-tmp
    docker run --name  carina211-tmp --label=jekyll --volume=${HOME}/workbench/carina211-tmp.github.io:/srv/jekyll -p 80:8080 -p 443:8443 -it -p 127.0.0.1:4000:4000 -d jekyll/jekyll
elif [[ "$1" == "enter" ]]; then
    docker exec -it  carina211-tmp bash
else
    echo "Unknown argument: $1"
    exit 1;
fi
