function awake {(
    case "$1" in
        ada) wakeonlan 00:22:15:d3:99:df; ;;
        clu) wakeonlan f8:d1:11:0e:d5:27; ;;
        dimaxion) wakeonlan c4:2c:03:d9:48:aa; ;;
        klue) wakeonlan 00:1e:68:b9:22:45; ;;
        multivac) wakeonlan 60:a4:4c:3d:69:a8; ;;
        *) echo "Unknown machine.";
    esac
)}
