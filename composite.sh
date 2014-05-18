#!/bin/bash

CONVERT="/usr/local/bin/convert"
COMPOSITE="/usr/local/bin/composite"

${COMPOSITE} -transparent-color "white" -compose plus eagle_top_mask.png eagle_top.png copper.png
${CONVERT} -negate eagle_top_mask.png maskn.png
${COMPOSITE} -transparent-color "white" -compose plus eagle_top.png maskn.png traces.png
${CONVERT} eagle_outline.png -transparent "white" -fill "#ff0000" -colorize "100,100,100,0" board.png
${COMPOSITE} -transparent-color "black" -compose plus board.png traces.png test.png

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
