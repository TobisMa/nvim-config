# TODOLIST
## Future
- [ ] FIX: Backspace in the last line in file goes up two lines
- [ ] completion order (is mostly okay though) (lower letter start should give lower letter start in completion)
- [ ] make luasnip jump behaviour understandable and maybe work with tab

## Partially completed / WIP
- [-] restoring indentation when deleting lines/keeping indentation when pressing enter consecutively
    - FIX: delete whitespace left from cursor and newline even if text is on the right side of the cursor
- [-] continue indent guides on blank lines using nvim\_...\_extmark(...)
    - verify plugin TobisMa/indentguides.nvim works

## Completed
- [X] include inserts >> instead of > (no problem with auto-import though)
- [X] make result into quickfix list
- [X] switch indent guides on shiftwidth with autocommand on OptionsSet
