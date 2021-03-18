// Copyright (C) 2020 Toitware ApS. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import font show *
import pixel_display show TwoColorPixelDisplay

// Import size-96 icons based on the Pictogrammers version of the
// Material Design Icons project at https://materialdesignicons.com/
// This is a package installed with
// toit pkg install toit-icons-pictogrammers
// If this import fails you need to run `toit pkg fetch` in this directory.
import pictogrammers_icons.size_96 as icons

// A large, bold font for the temperature.
// Roboto is a package installed with
// toit pkg install toit-font-google-100dpi-roboto
import roboto.bold_36 as roboto

// Create a font that covers Western European languages (the Latin-1 subset of
// Unicode).
roboto_font := Font [roboto.ASCII, roboto.LATIN_1_SUPPLEMENT]

main:
  display := TwoColorPixelDisplay "eink"

  // Landscape coordinate system.
  context := display.context --landscape --font=roboto_font

  weather := display.icon context 30 78 icons.WEATHER_LIGHTNING_RAINY

  // The degree sign is from the LATIN_1_SUPPLEMENT Unicode block.  See
  // http://www.fileformat.info/info/unicode/char/b0/index.htm
  temp    := display.text context 120 70 "17°C"

  2.repeat: display.draw --speed=10

  sleep --ms=1000

  // Replace the icon with a different, more threatening one.
  weather.icon = icons.BIOHAZARD

  2.repeat: display.draw --speed=10
