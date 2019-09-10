current_firefox_tab_number() {
    profile_folder="$(cat ~/.mozilla/firefox/profiles.ini | grep Path | sed s/^Path=//)"
    python2 <<< $'import json\nf = open("${HOME}/.mozilla/firefox/${profile_folder}/sessionstore.js", "r")\njdata = json.loads(f.read())\nf.close()\nprint str(jdata["windows"][0]["selected"])'
}

firefox_urls() {
    profile_folder="$(cat ~/.mozilla/firefox/profiles.ini | grep Path | sed s/^Path=//)"
    urls="$(echo 'import json\nf = open("'$HOME'/.mozilla/firefox/'${profile_folder}'/sessionstore.js", "r")\njdata = json.loads(f.read())\nf.close()\nfor win in jdata.get("windows"):\n\tfor tab in win.get("tabs"):\n\t\ti = tab.get("index") - 1\n\t\tprint tab.get("entries")[i].get("url")' | python2)"
    for url in $urls; do echo "$url"; done
}
current_firefox_url() {
    profile_folder="$(cat ~/.mozilla/firefox/profiles.ini | grep Path | sed s/^Path=//)"
    sed -n "$(current_firefox_tab_number)p" <(python2 <<< $'import json\nf = open("${HOME}/.mozilla/firefox/${profile_folder}/sessionstore.js", "r")\njdata = json.loads(f.read())\nf.close()\nfor win in jdata.get("windows"):\n\tfor tab in win.get("tabs"):\n\t\ti = tab.get("index") - 1\n\t\tprint tab.get("entries")[i].get("url")')
}
