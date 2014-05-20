#!/bin/bash

CONVERT=$(which convert)

BOARD_COLOR="green"
COPPER_COLOR="gold"
MASK_COLOR="green"
MASK_OPACITY="70"
SILK_COLOR="white"
HOLE_COLOR="black"

${CONVERT} eagle_outline.png -transparent white -fill ${BOARD_COLOR} -colorize "100%" \
\( eagle_top.png eagle_drill.png -compose Plus -composite -write mpr:copper -delete 0,2 \
\( mpr:copper -transparent-color white -background ${COPPER_COLOR} -alpha Shape \) \
\( mpr:copper -shade 120x30 -blur 0x1 -auto-level mpr:copper -compose CopyOpacity -composite \) -compose Overlay -composite \) -compose Atop -composite \
\( eagle_top_mask.png -negate -brightness-contrast -${MASK_OPACITY} -background ${MASK_COLOR} -alpha Shape \) -compose Atop -composite \
\( \( eagle_top_silk.png \( eagle_top_mask.png -negate \) -compose Multiply -composite \) -transparent-color black -background ${SILK_COLOR} -alpha Shape \) -compose Atop -composite \
\( eagle_drill.png -transparent-color black -background ${HOLE_COLOR} -alpha Shape \) -compose Atop -composite board_top.png

${CONVERT} eagle_outline.png -transparent white -fill ${BOARD_COLOR} -colorize "100%" \
\( eagle_bottom.png eagle_drill.png -compose Plus -composite -write mpr:copper -delete 0,2 \
\( mpr:copper -transparent-color white -background ${COPPER_COLOR} -alpha Shape \) \
\( mpr:copper -shade 120x30 -blur 0x1 -auto-level mpr:copper -compose CopyOpacity -composite \) -compose Overlay -composite \) -compose Atop -composite \
\( eagle_bottom_mask.png -negate -brightness-contrast -${MASK_OPACITY} -background ${MASK_COLOR} -alpha Shape \) -compose Atop -composite \
\( \( eagle_bottom_silk.png \( eagle_bottom_mask.png -negate \) -compose Multiply -composite \) -transparent-color black -background ${SILK_COLOR} -alpha Shape \) -compose Atop -composite \
\( eagle_drill.png -transparent-color black -background ${HOLE_COLOR} -alpha Shape \) -compose Atop -composite -flop board_bottom.png
