// Copyright (C) 2018 Toitware ApS. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import font
import font.toitware.status_icons_16 as icons_16
import texture show *
import two_color show *
import pixel_display show TwoColorPixelDisplay

sans10 := font.Font.get "sans10"
icons := font.Font [icons_16.ASCII]

main:
  ws := TwoColorPixelDisplay "eink"

  // Clear screen.
  ws.background = WHITE

  // Landscape coordinate system.
  context := ws.context --landscape --font=icons --color=BLACK

  ws.text context 25 40 "acegikmoqsu"
  ws.text context 25 70 "C G H I N P"
  ws.text context 25 100 " W Y z"

  ws.draw --speed=0

  ws.draw --speed=0
