local M = {}

--- Setup window appearance for nvim-cmp completion and documentation popups.
-- Chooses border style and highlight based on core config.
-- @return table: Window configuration for completion and documentation.
function M.window_setup()
  local G = require("core")
  if G.cmp_window_border == "rounded" then
    local border_opt = {
      border = "rounded",
      winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
      col_offset = -3,
      side_padding = 0,
    }
    return {
      completion = require("cmp.config.window").bordered(border_opt),
      documentation = require("cmp.config.window").bordered(border_opt),
    }
  end
  if G.cmp_window_border == "single" then
    local border_opt = {
      border = "single",
      winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
    }
    return {
      completion = require("cmp.config.window").bordered(border_opt),
      documentation = require("cmp.config.window").bordered(border_opt),
    }
  end
  return {
    completion = require("cmp.config.window"),
    documentation = require("cmp.config.window"),
  }
end

--- Format completion items with icons and colorful labels using lspkind.
-- @param entry table: The completion entry.
-- @param item table: The completion item to format.
-- @return table: The formatted completion item.
function M.format_colorful(entry, item)
  local lspkind = require("lspkind").cmp_format({
    mode = "symbol_text",
    maxwidth = {
      abbr = 30,
      menu = 40,
    },
    ellipsis_char = "...",
    show_labelDetails = true,
    symbol_map = { -- add more icons here
      Copilot = "",
    },
  })(entry, item)
  local strings = vim.split(lspkind.kind, "%s", { trimempty = true })
  item.kind = " " .. (strings[1] or "") .. " "
  item.menu = item.menu
  return item
end

return M
