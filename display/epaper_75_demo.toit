// Copyright (C) 2020 Toitware ApS. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import bitmap show *
import font show *
import font.matthew_welch.tiny as tiny_4
import texture show *
import two_color show *
import pixel_display show *

draw_paragraphs display context/GraphicsContext ypos step/int paragraph/string:
  paragraph.split("\n"): | para |
    para = para.trim
    para = para.replace --all "\u201c" "\""
    para = para.replace --all "\u201d" "\""
    while para:
      line := null
      if para.size > 70:
        cut := para.index_of --last " " 0 70
        if cut == -1:
          line = para
          para = null
        else:
          line = para.copy 0 cut
          para = para.copy cut+1
      else:
        line = para
        para = null
      display.text context 30 ypos line
      ypos += step
    ypos += step >> 1
  return ypos

main:
  // TODO: Currently no model has this driver installed, so this won't work.
  ws := TwoColorPixelDisplay "eink_7_5"

  landscape := ws.context
    --landscape
    --font = Font.get "sans10"
  tiny := landscape.with
    --font = Font [tiny_4.ASCII]
  ypos := 30

  ypos = draw_paragraphs ws landscape ypos 20 """\
    It is a truth universally acknowledged, that a single man in possession of a good fortune must be in want of a wife.
    However little known the feelings or views of such a man may be on his first entering a neighbourhood, this truth is so well fixed in the minds of the surrounding families, that he is considered as the rightful property of some one or other of their daughters."""
  draw_paragraphs ws tiny ypos 7 """\
    “My dear Mr. Bennet,” said his lady to him one day, “have you heard that Netherfield Park is let at last?”
    Mr. Bennet replied that he had not.
    “But it is,” returned she; “for Mrs. Long has just been here, and she told me all about it.”
    Mr. Bennet made no answer.
    “Do you not want to know who has taken it?” cried his wife impatiently.
    “You want to tell me, and I have no objection to hearing it.”
    This was invitation enough.
    “Why, my dear, you must know, Mrs. Long says that Netherfield is taken by a young man of large fortune from the north of England; that he came down on Monday in a chaise and four to see the place, and was so much delighted with it, that he agreed with Mr. Morris immediately; that he is to take possession before Michaelmas, and some of his servants are to be in the house by the end of next week.”
    “What is his name?”
    “Bingley.”
    “Is he married or single?”
    “Oh! Single, my dear, to be sure! A single man of large fortune; four or five thousand a year. What a fine thing for our girls!”
    “How so? How can it affect them?”
    “My dear Mr. Bennet,” replied his wife, “how can you be so tiresome! You must know that I am thinking of his marrying one of them.”"""
  tiny = tiny.with --translate_x=300
  draw_paragraphs ws tiny ypos 7 """\
    “Is that his design in settling here?”
    “Design! Nonsense, how can you talk so! But it is very likely that he may fall in love with one of them, and therefore you must visit him as soon as he comes.”
    “I see no occasion for that. You and the girls may go, or you may send them by themselves, which perhaps will be still better, for as you are as handsome as any of them, Mr. Bingley may like you the best of the party.”
    “My dear, you flatter me. I certainly have had my share of beauty, but I do not pretend to be anything extraordinary now. When a woman has five grown-up daughters, she ought to give over thinking of her own beauty.”
    “In such cases, a woman has not often much beauty to think of.”
    “But, my dear, you must indeed go and see Mr. Bingley when he comes into the neighbourhood.”
    “It is more than I engage for, I assure you.”
    “But consider your daughters. Only think what an establishment it would be for one of them. Sir William and Lady Lucas are determined to go, merely on that account, for in general, you know, they visit no newcomers. Indeed you must go, for it will be impossible for us to visit him if you do not.”
    “You are over-scrupulous, surely. I dare say Mr. Bingley will be very glad to see you; and I will send a few lines by you to assure him of my hearty consent to his marrying whichever he chooses of the girls; though I must throw in a good word for my little Lizzy.”"""

  title := "Pride & Predjudice"
  toit_width := (landscape.font.pixel_width title) + 6
  win_width := toit_width + 10
  author_window := SimpleWindow (640 - win_width) 80 win_width 70 landscape.transform 0 BLACK BLACK
  ws.add author_window
  author_window.add (TextTexture (win_width - 5) 30 author_window.transform TEXT_TEXTURE_ALIGN_RIGHT "Jane Austen" landscape.font WHITE)
  author_window.add (TextTexture (win_width - 5) 55 author_window.transform TEXT_TEXTURE_ALIGN_RIGHT "Pride & Predjudice" landscape.font WHITE)

  ws.draw
