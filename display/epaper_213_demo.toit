// Copyright (C) 2018 Toitware ApS. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import font
import texture show *
import two_color show *
import pixel_display show TwoColorPixelDisplay GraphicsContext

print display ypos/int context/GraphicsContext text/string:
  if text != "":
    display.text context 12 ypos text
  return ypos + 15

main:
  ws := TwoColorPixelDisplay "eink"

  sans := font.Font.get "sans10"

  // Landscape coordinate system.
  landscape := ws.context --landscape --font=sans --color=BLACK --translate_x=20

  // Portrait coordinate system.
  portrait := ws.context --landscape=false --font=sans --color=BLACK --translate_y=-20

  block := ws.filled_rectangle portrait 20 20 20 20

  ypos := 30
  for counter := 0; counter < 5; counter++:
    ctr := ws.text portrait 5 195 "$counter"
    if counter == 0:
      ypos = print ws ypos landscape "Wombats can crush their"
    if counter == 1:
      ypos = print ws ypos landscape "enemies against the walls"
    if counter == 2:
      ypos = print ws ypos landscape "of their own burrows"
    if counter == 3:
      ypos = print ws ypos landscape "using their specially"
    if counter == 4:
      ypos = print ws ypos landscape "reinforced butts."
    block.move_to
      20 + (counter * 29) % 150
      20 + (counter * 29) % 150
    ws.draw
    ws.remove ctr
  ws.draw --speed=0  // Do full flashing update to leave clean result.
