#!/bin/bash

CONVERT=$(which convert)

BOARD_COLOR="purple"
COPPER_COLOR="gold"
MASK_COLOR="purple"
MASK_OPACITY="70"
SILK_COLOR="white"
HOLE_COLOR="black"


BOARD_COLOR="rgb(58,18,100)"
COPPER_COLOR="rgb(177,136,131)"
MASK_COLOR="rgb(58,18,100)"
MASK_OPACITY="10"
SILK_COLOR="rgb(193,177,203)"
HOLE_COLOR="black"

${CONVERT} board_outline.png -transparent white -fill ${BOARD_COLOR} -colorize "100%" \
\( board_top.png board_drill.png -compose Plus -composite -write mpr:copper -delete 0,2 \
\( mpr:copper -transparent-color white -background ${COPPER_COLOR} -alpha Shape \) \
\( mpr:copper -shade 120x30 -blur 0x1 -auto-level mpr:copper -compose CopyOpacity -composite \) -compose Overlay -composite \) -compose Atop -composite \
\( board_top_mask.png -negate -brightness-contrast -${MASK_OPACITY} -background ${MASK_COLOR} -alpha Shape \) -compose Atop -composite \
\( \( board_top_silk.png \( board_top_mask.png -negate \) -compose Multiply -composite \) -transparent-color black -background ${SILK_COLOR} -alpha Shape \) -compose Atop -composite \
\( board_drill.png -transparent-color black -background ${HOLE_COLOR} -alpha Shape \) -compose Atop -composite board_top_render.png

${CONVERT} board_outline.png -transparent white -fill ${BOARD_COLOR} -colorize "100%" \
\( board_bottom.png board_drill.png -compose Plus -composite -write mpr:copper -delete 0,2 \
\( mpr:copper -transparent-color white -background ${COPPER_COLOR} -alpha Shape \) \
\( mpr:copper -shade 120x30 -blur 0x1 -auto-level mpr:copper -compose CopyOpacity -composite \) -compose Overlay -composite \) -compose Atop -composite \
\( board_bottom_mask.png -negate -brightness-contrast -${MASK_OPACITY} -background ${MASK_COLOR} -alpha Shape \) -compose Atop -composite \
\( \( board_bottom_silk.png \( board_bottom_mask.png -negate \) -compose Multiply -composite \) -transparent-color black -background ${SILK_COLOR} -alpha Shape \) -compose Atop -composite \
\( board_drill.png -transparent-color black -background ${HOLE_COLOR} -alpha Shape \) -compose Atop -composite -flop board_bottom_render.png
