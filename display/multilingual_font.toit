// Copyright (C) 2018 Toitware ApS. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import font.x11_100dpi.clearly_u.clearly_u_12_autobold as clear_12
import font show *
import texture show *
import two_color show *
import pixel_display show TwoColorPixelDisplay

clear12 := Font [clear_12.ASCII, clear_12.GREEK_AND_COPTIC, clear_12.ARMENIAN, clear_12.GEORGIAN]

main:
  ws := TwoColorPixelDisplay "eink"

  // Actually is already white.
  ws.background = WHITE

  // Landscape coordinate system.  Actually, GC defaults to black.
  context := ws.context --landscape --font=clear12 --color=BLACK

  ws.text context 30 18 "12 pixel Clearly-U"

  ws.text context 30 38 "Επιλεγμένο λήμμα"

  ws.text context 30 58 "ΕπՇաբաթվա հոդված"

  ws.text context 30 78 "რჩეული სტატია"

  ws.draw --speed=0
  ws.draw --speed=10
  ws.draw --speed=10
