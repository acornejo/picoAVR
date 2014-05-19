#!/bin/bash

CONVERT="/usr/local/bin/convert"
COMPOSITE="/usr/local/bin/composite"

rm -f board*.png soldermask.png holes.png copper*.png 

${CONVERT} eagle_outline.png -negate -background black -alpha Shape edges.png
${CONVERT} eagle_outline.png -fill black -bordercolor black -threshold "50%" -draw "color 50%,50% floodfill" -negate -alpha Shape shape.png

${CONVERT} eagle_outline.png -transparent white -fill red -colorize "100,100,100,0" board.png
${CONVERT} eagle_top_mask.png -negate -transparent-color white -background red -alpha Shape soldermask.png
${CONVERT} eagle_drill.png -transparent-color black -background black -alpha Shape holes.png
${CONVERT} eagle_top_silk.png -transparent-color black -background white -alpha Shape silk.png
${CONVERT} eagle_top_mask.png eagle_top.png -compose plus -composite coppermask.png
${CONVERT} coppermask.png -transparent-color white -background gold -alpha Shape coppergold.png
${CONVERT} coppermask.png -shade 120x30 -auto-level coppershadow.png
${CONVERT} coppergold.png coppershadow.png -compose Atop -composite coppershadow_cropped.png
${CONVERT} coppergold.png coppershadow_cropped.png -compose Overlay -composite coppershaded.png
${CONVERT} board.png coppershaded.png -compose Atop -composite board1.png
${CONVERT} soldermask.png board1.png -compose dissolve -define compose:args=60,100 -composite board2.png
${CONVERT} board2.png silk.png -compose Atop -composite board3.png
${CONVERT} board3.png holes.png -compose minus -composite board4.png
${CONVERT} board4.png -background white -flatten board5.png


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
