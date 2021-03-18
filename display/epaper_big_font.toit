// Copyright (C) 2018 Toitware ApS. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import font
import roboto.black_36 as roboto
import texture show *
import two_color show *
import pixel_display show TwoColorPixelDisplay

sans := font.Font [roboto.ASCII]

main:
  ws := TwoColorPixelDisplay "eink"

  // Landscape coordinate system.
  landscape := ws.context --landscape --font=sans --alignment=TEXT_TEXTURE_ALIGN_CENTER

  black := landscape.with --color=BLACK
  white := landscape.with --color=WHITE

  rectangle := ws.filled_rectangle black 24 4 180 98
  counter := ws.text white 90 50 ""

  five_seconds := Duration --s=5

  while true:
    ctr := 0

    print "5 seconds of partial updates"
    start := Time.now
    while (start.to Time.now) < five_seconds:
      counter.text = "$ctr"
      ctr++
      if ctr == 10: ctr = 0
      ws.draw --speed=100

    print "5 seconds of sleep"
    sleep --ms=5000

    print "5 seconds of full updates"
    start = Time.now
    while (start.to Time.now) < five_seconds:
      counter.text = "$ctr"
      ctr++
      if ctr == 10: ctr = 0
      ws.draw --speed=0

    print "5 seconds of sleep"
    sleep --ms=5000
