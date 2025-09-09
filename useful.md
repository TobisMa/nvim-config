# completion
ctrl-x  wait for submode for completion
    ctrl-f  files
    ctrl-n  only this file
    ctrl-i  keywords in currrent and included files
    ctrl-l  whole line completion (searches for lines with the same beginning)
    ctrl-v  vim command line
    ctrl-d  definition/macro completion
    ctrl-o  omnifunc completion ()
    s       spell completion

    ctrl-x  cancels completion mode

repeating ctrl-x after selecting a submode (e. g. ctrl-x ctrl-n ctrl-x ctrl-n) will make the match in the completion list longer

# buffer windws
count will refer to a number before the command e. g. `5ce` has a count of 5

ctrl-w  prefix to make buffer window actions
    hjkl    move cursor around
    q       close the buffer window (not the underlying buffer)

    r R     rotate the buffer windows (in reverse)
    HJKL    move the buffer window itself
    x       exchange two neighbouring windows (takes the next, or previous if there is no next window)
    +-      change current window height by count or 1
    <>      change current window width by count or 1
    =       resize all windows to make them equally large
    | _     set width/height of the window to count


# marks
- use `m<reg>` to set a mark
- use `'<reg>` to go to line on first non blank character
- use ``<reg>` to go to the exact position (including cursor column)

# :norm

# useful commands
- :g
- :v

# useful keycodes mode keycombs 
- `q:` (normal mode): opens vim cmd history which can then be edited and enter will run the edited command
- `g<`: reopen the last commands result
- `gx`: opens link under cursor (works on valid file paths as well) using system app
- `<C-g>`: next occurence of your search while staying in the search field
- `<C-t>`: previous occurence of your search while staying in the search field
- `J`: merge lines
- `gi`: goto to last position where insert mode has been exited

# insert mode keycodes (stuff from normal mode you can do in insert mode)
ctrl+y: copy characters from line above
ctrl+e: copy characters from line below
ctrl+t: indent line
ctrl+d: unindent line
ctrl+a: insert last inserted text
ctrl+r: insert text from register (e. g. `ctrl+r t` would insert from reg t)
ctrl+v: literal insert a key (for example backspace or esc)
ctrl+u: delete whole line left from cursor
ctrl+w: delete last word
ctrl+x: see above

# set spell
- traverse with [s and ]s
- `z=` to get suggestions
- `ctrl-x s` triggers suggestion completion menu in insert mode
