function screencast {(
  timestamp=`date -u +%Y-%m-%d_%H-%M-%S`
  echo "Screencasting with ffmpeg. Press 'q' to finish."
  ffmpeg \
    -loglevel quiet -stats \
    -video_size `xdpyinfo | awk '/dimensions/ {print $2}'` \
    -framerate 24 \
    -f x11grab -i ${DISPLAY}.0 \
    -f alsa -ac 2 -i pulse \
    -f mp4 ${1:-~/${timestamp}_screencast}."${2:-mp4}"
  echo "Screencast saved to: ${1:-~/${timestamp}_screencast}.${2:-mp4}"
)}
