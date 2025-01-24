if [ -d ~/.rc.d ]; then
 for rc in ~/.rc.d/*; do
	 if [ -f "$rc" ]; then
		 . "$rc"
	 fi
 done
fi
unset rc
