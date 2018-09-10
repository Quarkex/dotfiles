function ff2cbz {(
      set -e;
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

      zip "$basename" * &&
      mv "$basename.zip" "../$basename.cbz" &&
      cd ".." &&
      rm -r "$basename";

      popd;
)}
