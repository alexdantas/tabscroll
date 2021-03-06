# tabscroll - Neat guitar tab scroller.

<!-- gem badge (ignore this if you're in text mode) -->
[![Gem Version](https://badge.fury.io/rb/tabscroll.png)](http://badge.fury.io/rb/tabscroll)

`tabscroll` is a (Ruby-powered) guitar tab scroller on the terminal.

It supports forward and backwards auto-scrolling and currently
reads a nice range of guitar tabs.

## Usage and Screenshots

    $ tabscroll my-guitar-tab.txt

![big screen](http://www.alexdantas.net/projects/tabscroll/images/small.png)

![big screen](http://www.alexdantas.net/projects/tabscroll/images/help.png)

## Guitar tab file format and troubleshooting

`tabscroll` only works with textual guitar tabs, not chords with lyrics.

It attempts to read any kind of tab format (although it works better with tabs
exported from _Guitar Pro_). For now it requires you to split each tab row with
a blank line. For example, this would work:

      E  S S S S S  S Q    S S S S    E  S S S S S  S E  S S S S S  S
    --0--------0------0----L---0-1-|--0----------0h-1-0----------0h-1-|
    --1----------0h-1-1----L-1-----|--1----1----------1----1----------|
    ------------------0----L-------|--2--2-----2------0--0-----0------|
    -----0-2----------2----L-------|--3------3--------2------2--------|
    --3------3--------3----L-------|----------------------------------|
    -------------------------------|----------------------------------|

      E  S S S S S S E  S S S S  S S    E  S S S S S  S E  S S S S S  S
    --0----3---0-----5--3---0------0-|--L----------0h-1-0----------3p-1-|
    --1----------1-3-0--------3p-0---|--1----1----------1----1----------|
    --2--2---2-------0----0----------|--2--2-----2------0--0-----0------|
    ---------------------------------|--3------3--------2------2--------|
    --0------------------------------|----------------------------------|
    -----------------3------3--------|----------------------------------|

But this wouldn't:

    --0--------0------0----L---0-1-|--0----------0h-1-0----------0h-1-|
    --1----------0h-1-1----L-1-----|--1----1----------1----1----------|
    ------------------0----L-------|--2--2-----2------0--0-----0------|
    -----0-2----------2----L-------|--3------3--------2------2--------|
    --3------3--------3----L-------|----------------------------------|
    -------------------------------|----------------------------------|
    --0----3---0-----5--3---0------0-|--L----------0h-1-0----------3p-1-|
    --1----------1-3-0--------3p-0---|--1----1----------1----1----------|
    --2--2---2-------0----0----------|--2--2-----2------0--0-----0------|
    ---------------------------------|--3------3--------2------2--------|
    --0------------------------------|----------------------------------|
    -----------------3------3--------|----------------------------------|

So if something bad happens and the program crashes, edit the tab making sure to
keep a consistent tab format (6 in 6 lines, or 5 in 5) each with a blank line
inbetween.

At worse, please comment (add `#` at the start of) any line that's not the tab
(you know, author info, instructions, etc). Sorry for the inconvenience, I plan
to improve a lot the detection of tabs on the future.

## Contact

Hi, I'm Alexandre Dantas! Thanks for having interest in this project. Please
take the time to visit any of the links below.

* `tabscroll` homepage: http://www.alexdantas.net/projects/tabscroll
* Contact: `eu @ alexdantas.net`
* My homepage: http://www.alexdantas.net

