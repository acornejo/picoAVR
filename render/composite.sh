#!/bin/bash

CONVERT=$(which convert)

BOARD_COLOR="red"
COPPER_COLOR="gold"
MASK_COLOR="red"
MASK_OPACITY="50%"
SILK_COLOR="white"
HOLE_COLOR="black"

rm -f board*.png mask.png holes.png copper*.png 


${CONVERT} eagle_top.png \
\( -clone 0 -shade 120x30 -auto-level \) -compose CopyOpacity -composite \
\( -clone 0 -transparent-color white -background ${COPPER_COLOR} -alpha Shape \) \
 -compose Overlay -composite coppershaded.png

${CONVERT} eagle_top.png -transparent-color white -background black -alpha Shape -matte \
            \( +clone -channel A -separate +channel  -bordercolor black -border 1  -blur 0x1 -shade 120x30 -auto-level -blur 0x1 -fill ${COPPER_COLOR} -tint 100 \) \
            -gravity center -compose Atop -composite \
            coppershaded2.png

# ${CONVERT} eagle_top.png -transparent-color white -background ${COPPER_COLOR} -alpha Shape coppergold.png
# ${CONVERT} eagle_top.png -shade 120x30 -auto-level coppershadow.png
# ${CONVERT} coppergold.png coppershadow.png -compose Atop -composite coppershadow_cropped.png
# ${CONVERT} coppergold.png coppershadow_cropped.png -compose Overlay -composite coppershaded.png
${CONVERT} eagle_outline.png -transparent white -fill ${BOARD_COLOR} -colorize "100%" \
coppershaded2.png -compose Atop -composite \
\( eagle_top_mask.png -negate -transparent-color white -background ${MASK_COLOR} -colorize ${MASK_OPACITY} -alpha Shape \) -compose Atop -composite \
\( eagle_top_silk.png -transparent-color black -background ${SILK_COLOR} -alpha Shape \) -compose Atop -composite \
\( eagle_drill.png -transparent-color black -background ${HOLE_COLOR} -alpha Shape \) -compose Atop -composite board.png


# ${CONVERT} eagle_top_mask.png eagle_top.png -compose plus -composite -shade 120x30 -auto-level -write mpr:copper_shadow +delete copper.png mpr:copper_shadow -compose Overlay -composite copper_shaded.png

# ${CONVERT} eagle_top_mask.png eagle_top.png -compose plus -composite -shade 120x30 -auto-level copper_shadow.png
# ${CONVERT} copper_shadow.png copper.png -compose Overlay -composite copper_shaded.png

# ${CONVERT} copper.png -background gold -alpha Shape test.png

# ${COMPOSITE} -transparent-color "white" -compose plus eagle_top_mask.png eagle_top.png copper.png
# ${CONVERT} -negate eagle_top_mask.png maskn.png
# ${COMPOSITE} -transparent-color "white" -compose plus eagle_top.png maskn.png traces.png
# ${CONVERT} eagle_outline.png -transparent "white" -fill "#ff0000" -colorize "100,100,100,0" board.png
# ${COMPOSITE} -transparent-color "black" -compose plus board.png traces.png test.png

# # top image
# top_cmds  = composite_cmd + ' -transparent-color "white" -compose plus ' + "\"" + image_prefix + "_top_mask.png\" " + "\"" + image_prefix + "_top.png\" pads.png\n"
# top_cmds += convert_cmd + " -negate \"" + image_prefix + "_top_mask.png\" maskn.png\n"
# top_cmds += composite_cmd + " -transparent-color \"white\" -compose plus \"" + image_prefix + "_top.png\" maskn.png  traces.png\n"
# cmds = top_cmds
#
# # create board
# board_color_cmds = convert_cmd + " \"" + image_prefix + "_imagesize.png\" " + ' -transparent "white"  -fill "' + rgb_string(color_board) + '" -colorize "100,100,100,0"  board.png' + "\n"
# cmds += board_color_cmds
#
# # set colors
# color_cmds  = convert_cmd + ' -transparent "white" -fill "' + rgb_string(color_plating) + '" -colorize "100,100,100,0" pads.png pads.png' + "\n"
# color_cmds += convert_cmd + ' -transparent "white"  -fill "' + rgb_string(color_tracing) + '" -colorize "100,100,100,0" traces.png traces.png' + "\n"
#
# cmds += color_cmds
# cmds += convert_cmd + " \"" + image_prefix + "_top_silk.png\" " + ' -transparent "white" -fill "' + rgb_string(color_silk) + '" -colorize "100,100,100,0" silk.png' + "\n"
#
# # create combined top image
# top_combine_cmds = convert_cmd + ' -flatten -background "none" ' + "board.png traces.png silk.png pads.png \"" + prefix + "_board_top.png\"\n"
# top_combine_cmds += convert_cmd + " \"" + prefix + "_board_top.png\" -crop \"" + crop_arg + "\" \"" + prefix + "_board_top." + result_extension + "\"\n"
# cmds += top_combine_cmds
