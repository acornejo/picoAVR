#!/bin/bash
EAGLE=/Applications/EAGLE-6.5.0/EAGLE.app/Contents/MacOS/EAGLE

${EAGLE} -C 'SCRIPT imagedump.scr; QUIT' picoavr.brd
