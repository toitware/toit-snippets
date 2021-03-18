// Copyright (C) 2018 Toitware ApS. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import font.x11_100dpi.sans.sans_10_bold as sans_10
import font.x11_100dpi.sans.sans_12_bold as sans_12
import font.x11_100dpi.sans.sans_14_bold as sans_14
import font.x11_100dpi.sans.sans_18_bold as sans_18
import font.x11_100dpi.sans.sans_24_bold as sans_24
import font show *
import texture show *
import two_color show *
import pixel_display show TwoColorPixelDisplay

sans10 := Font [sans_10.ASCII]
sans12 := Font [sans_12.ASCII]
sans14 := Font [sans_14.ASCII]
sans18 := Font [sans_18.ASCII]
sans24 := Font [sans_24.ASCII]

main:
  ws := TwoColorPixelDisplay "eink"

  // Landscape coordinate system.
  landscape := ws.context --landscape

  ws.text (landscape.with --font=sans10) 32 12 "10 pixel bold"
  ws.text (landscape.with --font=sans12) 32 28 "12 pixel bold"
  ws.text (landscape.with --font=sans14) 32 44 "14 pixel bold"
  ws.text (landscape.with --font=sans18) 32 64 "18 pixel bold"
  ws.text (landscape.with --font=sans24) 32 94 "24 pixel bold"

  ws.draw --speed=0
  ws.draw --speed=10
  ws.draw --speed=10
