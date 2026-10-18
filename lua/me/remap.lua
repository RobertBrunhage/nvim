vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>h", ":wincmd h<CR>")
vim.keymap.set("n", "<leader>j", ":wincmd j<CR>")
vim.keymap.set("n", "<leader>k", ":wincmd k<CR>")
vim.keymap.set("n", "<leader>l", ":wincmd l<CR>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<leader>sv", ":vsplit <CR>")
vim.keymap.set("n", "<leader>sh", ":split <CR>")

vim.keymap.set("x", "p", "pgvy")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "<S-d>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<S-u>", "<cmd>cprev<CR>zz")

vim.keymap.set("n", "<C-f>", ":silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>ft", ":silent !flutter-test %:p<CR>")
vim.keymap.set("n", "<leader>ss", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

-- Enter between a pair like {|} puts the cursor on its own indented line (code only, not prose)
vim.keymap.set("i", "<CR>", function()
  local is_code = (vim.bo.indentexpr ~= "" or vim.bo.cindent) and vim.bo.filetype ~= "markdown"
  local col = vim.fn.col(".")
  local pair = vim.fn.getline("."):sub(col - 1, col)
  if is_code and (pair == "{}" or pair == "()" or pair == "[]") then
    -- reindent the closing bracket line, then open an indented line above it
    return "<CR><C-o>==<C-o>O"
  end
  return "<CR>"
end, { expr = true, desc = "Split brackets on enter" })

vim.keymap.set("n", "<leader>o", function()
  vim.cmd("silent !open " .. vim.fn.expand("%:p"))
end, { desc = "Open current netrw directory in system file explorer" })

vim.api.nvim_create_user_command("Format", function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  require("conform").format({ async = true, lsp_format = "fallback", range = range })
end, { range = true })

vim.keymap.set({ "n", "v" }, "<leader>f", ":Format<CR>", { desc = "Format buffer or range" })
