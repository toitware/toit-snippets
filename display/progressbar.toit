// Copyright (C) 2020 Toitware ApS. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import pixel_display show *
import two_color
import texture show Transform
import log

SLEEP_DURATION ::= Duration --ms=2

main:
  display ::= (TwoColorPixelDisplay "eink")

  progress ::= ProgressBar display --width=80 --height=10 --x=60 --y=50 --context=display.context

  sleep SLEEP_DURATION

  50.repeat:
    progress.set_progress it
    sleep SLEEP_DURATION

  25.repeat:
    progress.set_progress (50 - it)
    sleep SLEEP_DURATION

  75.repeat:
    progress.set_progress (25 + it)
    sleep SLEEP_DURATION

class ProgressBar:
  width /int ::= ?
  height /int ::= ?
  x /int ::= ?
  y /int ::= ?
  context /GraphicsContext ::= ?
  display /TwoColorPixelDisplay ::= ?
  rectangle_ /two_color.FilledRectangle ::= ?
  progress_ /float := 0.0

  constructor .display --.width --.height --.x --.y --progress/num=0 --draw/bool=true --.context=display.context:
    if not (0 <= progress <= 100):
      throw "OUT_OF_BOUNDS"
    progress_ = progress.to_float

    top := (y - height)
    bottom := y
    left := x
    right := (x + width)

    display.line context left top right top
    display.line context left bottom right bottom
    display.line context right top right bottom
    rectangle_ = display.filled_rectangle context left top 1 height
    update_ --draw=draw

  progress -> num:
    return progress_

  set_progress progress/num --draw/bool=true -> none:
    if not (0 <= progress <= 100):
      throw "OUT_OF_BOUNDS"
    progress_ = progress.to_float
    update_ --draw=draw

  calculate_filled_width_ progress/num -> int:
    result := ((width.to_float / 100) * progress).to_int
    if result <= 0:
      return 1
    return result + 1

  update_ --draw/bool=true -> none:
    rectangle_.width = calculate_filled_width_ progress_
    if draw:
      display.draw
