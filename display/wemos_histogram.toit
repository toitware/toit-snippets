// Copyright (C) 2018 Toitware ApS. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

// Demo of 128x64 monochrome display.

import font show *
import font.x11_100dpi.sans.sans_24_bold as sans_24_bold
import pixel_display show *
import texture show *
import two_color show *
import histogram show *
import bitmap show *

main:
  oled := TwoColorPixelDisplay "ssd1306"

  oled.background = BLACK

  histo := TwoColorHistogram 7 7 45 50 oled.landscape 0.5 WHITE
  oled.add histo

  animate oled histo oled.landscape

animate oled histogram transform:
  sans := Font.get "sans10"
  sans24b := Font [sans_24_bold.ASCII]

  lvl := 50

  boef_x := 50
  loeg_x := 50

  sans_context := oled.context --landscape --font=sans --color=WHITE
  boef := oled.text sans_context boef_x 16 "Bøf"
  loeg := oled.text sans_context loeg_x 32 "Løg"

  sans24b_context := sans_context.with --font=sans24b --alignment=TEXT_TEXTURE_ALIGN_RIGHT
  fps := oled.text sans24b_context 126 62 "30.0"

  boef_dir := 3
  loeg_dir := -3
  last := Time.monotonic_us
  previous := Time.monotonic_us
  while true:
    lvl += (random 0 5) - 2
    if lvl > 95: lvl--
    if lvl < 5: lvl++
    histogram.add lvl

    time_now := Time.monotonic_us
    fps.text = "$(%.1f 1000000.0 / (time_now - last)) "
    last = time_now

    boef_x += boef_dir
    loeg_x += loeg_dir
    if boef_x < 0 or loeg_x < 0:
      boef_dir = -boef_dir
      loeg_dir = -loeg_dir
    boef.move_to boef_x 16
    loeg.move_to loeg_x 32
    oled.draw

    next := Time.monotonic_us
    sleep --ms=19
    previous = next
