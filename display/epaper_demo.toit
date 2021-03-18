// Copyright (C) 2018 Toitware ApS. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import font show *
import font.x11_100dpi.sans.sans_24_bold as sans_24_bold
import texture show *
import three_color show *
import pixel_display show *

CLOCK_DIAMETER ::= 64
CLOCK_CENTER ::= 32
CLOCK_RADIUS ::= 29

clock_lines texture x_sign y_sign:
  clock_line texture x_sign y_sign 0.5 0.866
  clock_line texture x_sign y_sign 0.866 0.5
  clock_line texture x_sign y_sign 0.0 1.0
  clock_line texture x_sign y_sign 1.0 0.0

clock_line texture x_sign y_sign xmag ymag:
  x := (CLOCK_CENTER + CLOCK_RADIUS * x_sign * xmag * 0.9).to_int
  y := (CLOCK_CENTER + CLOCK_RADIUS * y_sign * ymag * 0.9).to_int
  texture.set_pixel x y
  texture.set_pixel (x + x_sign) y
  texture.set_pixel (x + x_sign) (y + y_sign)
  texture.set_pixel x (y + y_sign)

main:
  ws := ThreeColorPixelDisplay "epaper_3_color_2_7"

  sans := Font.get "sans10"
  number_font := Font [sans_24_bold.ASCII, sans_24_bold.CURRENCY_SYMBOLS]

  // 176x264 portrait coordinate system.
  context := ws.context --landscape=false --font=sans --color=RED

  // 264x176 landscape coordinate system.
  landscape := ws.landscape

  ws.text context 20 103 "14:25:10"
  date := ws.text context 20 123 "October 1 2018"

  ws.text context 130 20 "left"
  ws.text (context.with --alignment=TEXT_TEXTURE_ALIGN_RIGHT) 130 38 "right, no real"
  ws.text (context.with --alignment=TEXT_TEXTURE_ALIGN_CENTER) 130 56 "center"

  black := context.with --color=BLACK
  clock := ws.bitmap black 20 20 CLOCK_DIAMETER CLOCK_DIAMETER
  clock_lines clock 1 1
  clock_lines clock -1 1
  clock_lines clock -1 -1
  clock_lines clock 1 -1

  toitness_group := TextureGroup
  toitness := TextTexture 70 150 landscape TEXT_TEXTURE_ALIGN_LEFT "Toit like a toiger" sans WHITE

  toit_height := (sans.pixel_width "Toit") + 6

  box1 := FilledRectangle BLACK toitness.display_x - 3 toitness.display_y - 3 toitness.display_w + 6 toit_height context.transform
  box2 := FilledRectangle RED toitness.display_x - 3 toitness.display_y - 3 + toit_height toitness.display_w + 6 toitness.display_h + 6 - toit_height context.transform

  toitness_group.add toitness
  toitness_group.add box1
  toitness_group.add box2
  ws.add toitness_group

  numbers_context := ws.context --landscape --font=number_font
  ws.text numbers_context 166 200 "€24,-"

  barcode := BarCodeEan13 "5740700990427" 20 150 context.transform
  ws.add barcode

  ws.draw

  sleep --ms=1000

  date.text = "October 7 2019"
  ws.draw

  sleep --ms=1000

  ws.remove barcode
  barcode = BarCodeEan13 "1234567890123" 20 150 context.transform
  ws.add barcode

  ws.draw
