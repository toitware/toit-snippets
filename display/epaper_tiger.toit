// Copyright (C) 2020 Toitware ApS. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

// An example of showing a pbm file on an epaper display.

import texture show *
import two_color show *
import pixel_display show TwoColorPixelDisplay

import ..third_party.tiger

ws := TwoColorPixelDisplay "eink"

main:
  use_pbm_texture
  sleep --ms=1000
  use_opaque_bitmap_texture
  sleep --ms=1000
  use_opaque_pbm_texture

// Display the PBM by using a $PbmTexture.  This doesn't support scaling up the
// image.  Black pixels from the image are drawn in the given color, while
// white pixels are left transparent.
use_pbm_texture:
  x := 40
  y := 0

  image_texture := PbmTexture
    x
    y
    ws.inverted_landscape
    BLACK
    TIGER_PBM_FILE

  ws.add image_texture

  ws.draw --speed=0

  ws.remove image_texture

// Display the PBM by using an $OpaquePbmTexture.  This doesn't support scaling
// up the image.  Both black and white pixels are drawn.
use_opaque_pbm_texture:
  x := 40
  y := 0

  image_texture := OpaquePbmTexture
    x
    y
    ws.landscape
    TIGER_PBM_FILE

  ws.add image_texture

  ws.draw --speed=0

  ws.remove image_texture

// Display the PBM by using an $OpaqueBitmapTexture.  This supports scaling up
// the image by a factor of 2.  Both black and white pixels are drawn.
use_opaque_bitmap_texture:
  x := 40
  y := 0

  pbm := Pbm.parse TIGER_PBM_FILE

  image_texture := ws.opaque_bitmap
    ws.context --landscape
    x
    y
    2 * pbm.width
    2 * pbm.height

  draw_pbm image_texture pbm --scale=2

  ws.draw --speed=0

  ws.remove image_texture

