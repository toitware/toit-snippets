// Copyright (C) 2018 Toitware ApS. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import bitmap show *
import font show *
import texture show *
import two_color show *
import pixel_display show *

print display ypos/int context/GraphicsContext text/string:
  if text != "":
    display.text context 20 ypos text
  return ypos + 25

main:
  ws := TwoColorPixelDisplay "eink"

  ypos := 30

  ws.draw

  sans := Font.get "sans10"
  portrait := ws.context --landscape=false --font=sans --color=BLACK

  block := ws.filled_rectangle portrait 20 20 20 20

  for counter := 0; counter < 45; counter++:
    sleep --ms=1000
    if counter == 4:
      ypos = print ws ypos portrait "Wombats can crush their"
    if counter == 6:
      ypos = print ws ypos portrait "enemies against the walls"
    if counter == 8:
      ypos = print ws ypos portrait "of their own burrows"
    if counter == 10:
      ypos = print ws ypos portrait "using their specially"
    if counter == 12:
      ypos = print ws ypos portrait "reinforced butts."
    block.move_to
      20 + (counter * 10) % 150
      20 + (counter * 10) % 150
    ctr := ws.text portrait 5 195 "$counter"
    ws.draw
    ws.remove ctr
