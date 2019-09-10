function ff2num {(
    if [ "$1" = "." ]
    then
        execPath="${PWD%/}";
    else
        execPath="${1:-${PWD%/}}";
    fi
    while [ "${execPath: -1}" = "/" ]
    do
        execPath="${execPath%/}";
    done

    basename="${execPath##*/}";
    pushd . && cd "${execPath}";
    files=*.*;

    digits=1;
    amountOfFiles=0;
    for i in ${files}; do
        [ -f "$i" ] || continue;
        let amountOfFiles=amountOfFiles+1;
    done
    while [ "$amountOfFiles" -gt "11" ]; do
        let amountOfFiles=amountOfFiles=amomuntOfFiles/10;
        let digits=$digits+1;
    done

    a=0;
    for i in ${files}; do
        [ -f "$i" ] || continue;
        ext="${i##*.}";
        num=$(printf "%0${digits}d" ${a});
        mv "$i" "${basename}_$num.$ext";
        let a=a+1;
    done
    popd;
)}

