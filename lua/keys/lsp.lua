local keys = require("keys.util")

keys.nvmap("<leader>lf", vim.lsp.buf.format)  -- format code if LSP has formatter
keys.nvmap("<C-.>", vim.lsp.buf.code_action)  -- code action (like IntelliJ Alt+enter)

keys.imap("<C-space>", "<C-x><C-o>")  -- trigger autocompletion

-- nmap("K", vim.lsp.buf.hover)  -- give hover info of functions/methods/variables/... (only defined when an LSP attached)
keys.nmap("<C-k>", "K")  -- move calling keywordprg to c-k (default would be K)
keys.nmap("<F2>", vim.lsp.buf.rename)  -- rename variable/function/...
keys.nmap("<leader>ls", vim.lsp.buf.signature_help)  -- signature help in a floating window
keys.nmap("<leader>e", vim.diagnostic.open_float)  -- shows error messages in a floating window if they exist at current position
keys.nmap("<leader>lr", vim.lsp.buf.references)  -- open references associated with variable/function in QuickFix list
keys.nmap("<leader>lt", vim.lsp.buf.type_definition) -- go to type definition/declaration
keys.nmap("<leader>lh", function() vim.lsp.buf.typehierarchy("subtypes") end)  -- list child classes (generally subtypes) in the quickfix list
keys.nmap("<leader>lH", function() vim.lsp.buf.typehierarchy("supertypes") end)  -- -- list child classes (generally subtypes) in the quickfix list
keys.nmap("gI", vim.lsp.buf.implementation)  -- shows implementations for the symbol under cursor in the quickfix list (go to symbol if only one implementation exists)
keys.nmap("gd", vim.lsp.buf.definition)  -- go to defintion of the symbol under the cursor (not declaration)
keys.nmap("gD", vim.lsp.buf.declaration)  -- go to declaration of the symbol under the cursor (not definition)

-- quickfix
keys.nmap("<leader>ql", "<cmd>cwindow<cr>")  -- open quickfix list if items exist (nothing happens if there are no items)
keys.nmap("<leader>qP", "<cmd>cfirst<cr>")   -- go to first entry in the quickfix list
keys.nmap("<leader>qp", "<cmd>cprevious<cr>")  -- go to previous quickfix list entry
keys.nmap("<leader>qq", "<cmd>cc<cr>")  -- go to current quickfix list entry (last selected)
keys.nmap("<leader>qn", "<cmd>cnext<cr>")  -- go to next quickfix list entry
keys.nmap("<leader>qN", "<cmd>clast<cr>")  -- go to last entry in the quickfix list
