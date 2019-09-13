#!/bin/bash
function watch() {
  [[ -z "${REPEAT}" || "${REPEAT}" =~ [^0-9.] ]] && REPEAT="1.0"
  local PREFIX="Every $REPEAT seconds: '"
  local SUFFIX="'" 

  STARTTIME=$(date +"%s")

  while true; do
    clear

    local COLS
    COLS=$(tput cols)
    local ARGS="$*"
    local RUNNINGSTATLENGTH=$((${#PREFIX}+${#ARGS}+${#SUFFIX}))
    if [ "$COLS" -ge $RUNNINGSTATLENGTH ]; then
      echo -n "${PREFIX}$(tput setaf 6)${*}$(tput sgr0)${SUFFIX}"

      RUNTIME="($(($(date +"%s")-STARTTIME))s since invocation)"
      if [ "$COLS" -ge $((RUNNINGSTATLENGTH+${#RUNTIME}+3)) ]; then
        printf "%*s\\n" $((COLS-RUNNINGSTATLENGTH)) "$RUNTIME"
      else
        echo
      fi
    fi
    
    "$SHELL" -c "$*"
    sleep $REPEAT
  done
}
