#!/bin/bash
EAGLE=/Applications/EAGLE-6.5.0/EAGLE.app/Contents/MacOS/EAGLE
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

rm -f board_*.png
${EAGLE} -C 'SCRIPT imagedump.scr; QUIT' picoavr.brd
. ${DIR}/composite.sh
