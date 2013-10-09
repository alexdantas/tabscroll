# tabscroll - Neat guitar tab scroller.

`tabscroll` is a (Ruby-powered) guitar tab scroller on the terminal.

It supports forward and backwards auto-scrolling and currently
reads a nice range of guitar tabs.

## Usage and Screenshots

`$ tabscroll my-guitar-tab.txt`

 <!-- screenshot -->

## Guitar tab file format

Don't worry about it. Ideally you'd send a guitar tab independently of the
format and `tabscroll` would be smart enough to know how to display it.

But for now it requires you to split each tab row with a blank line. For
example, this would work:

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

  E  S S S S S  S Q    S S S S    E  S S S S S  S E  S S S S S  S
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

## Credits and contact

`tabscroll` was created by Alexandre Dantas. Do visit my
[homepage](http://www.alexdantas.net) and
[blog](http://www.alexdantas.net/projects).

`tabscroll` also has a page: http://www.alexdantas.net/projects/tabscroll

