#!/bin/bash

[[ -z "${REPEAT}" || "${REPEAT}" =~ [^0-9.] ]] && REPEAT="1.0"
PREFIX="Every $REPEAT seconds: '"
SUFFIX="'" 

STARTTIME=$(date +"%s")

while [ true ]; do
    clear

    COLS=$(tput cols)
    ARGS="$*"
    RUNNINGSTATLENGTH=$((${#PREFIX}+${#ARGS}+${#SUFFIX}))
    if [ $COLS -ge $RUNNINGSTATLENGTH ]; then
	echo -n "$PREFIX"
	echo -ne '\033[0;36m'
	echo -n "$@"
	echo -ne '\033[0;0m'
	echo -n "$SUFFIX"

	RUNTIME="($(($(date +"%s")-$STARTTIME))s since invocation)"
	if [ $COLS -ge $(($RUNNINGSTATLENGTH+${#RUNTIME}+3)) ]; then
	    printf "%$(($COLS-$RUNNINGSTATLENGTH))s\\n" "$RUNTIME"
	else
	    echo
	fi
    fi
    
    sh -c "$*"
    sleep $REPEAT
done
