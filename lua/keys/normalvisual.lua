local keys = require("keys.util")


-- make behaviour on wrapped lines as expected. that means those commands work for each wrapped line
-- instead of fully jumping to the end
keys.nvmap("j", "gj")  -- make j behave the same as in wrapped lines
keys.nvmap("k", "gk")  -- make k behave the same as in wrapped lines
keys.nvmap("0", "g0")  -- make 0 behave the same in wrapped lines
keys.nvmap("$", "g$")  -- make $ behave the same as in wrapped
