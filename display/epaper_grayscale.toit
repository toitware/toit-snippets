// Copyright (C) 2020 Toitware ApS. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import font
import texture show *
import four_gray show *
import pixel_display show FourGrayPixelDisplay GraphicsContext

sans := font.Font.get "sans10"

print display ypos/int context/GraphicsContext text/string:
  if text != "":
    display.text context 12 ypos text
  return ypos + 15

main:
  ws := FourGrayPixelDisplay "eink"

  // Clear screen.
  ws.draw

  // Landscape coordinate system.
  landscape := ws.context --landscape --font=sans

  // Portrait coordinate system.
  portrait := ws.context --landscape=false --font=sans

  block := ws.filled_rectangle (portrait.with --color = BLACK) 20 20 20 20
  block2 := ws.filled_rectangle (portrait.with --color = DARK_GRAY) 20 40 20 20
  block3 := ws.filled_rectangle (portrait.with --color = LIGHT_GRAY) 20 40 20 20

  bullseye := OpaquePixmapTexture 50 50 24 24 landscape.transform
  ws.add bullseye

  bullseye.set_all_pixels DARK_GRAY
  24.repeat: | x |
    24.repeat: | y |
      d := (x - 12) * (x - 12) + (y - 12) * (y - 12)
      bullseye.set_pixel x y
        d < 16 ? WHITE : (d < 64 ? LIGHT_GRAY : (d < 144 ? BLACK : WHITE))

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
      20 + (counter * 18) % 150
      20 + (counter * 5) % 150
    block2.move_to
      20 + (counter * 18) % 150
      40 + (counter * 5) % 150
    block3.move_to
      20 + (counter * 18) % 150
      60 + (counter * 5) % 150
    ws.draw
    ws.remove ctr
    sleep --ms=1000
