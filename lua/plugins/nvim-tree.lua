return {
  'nvim-tree/nvim-tree.lua',
  lazy = false,

  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'b0o/nvim-tree-preview.lua',
  },

  config = function()
    require 'nvim-tree'.setup {
      actions = { open_file = { resize_window = false } },
      renderer = {
        icons = { show = { diagnostics = false } },
        indent_width = 2,
        highlight_diagnostics = "name",
        indent_markers = {
          enable = true,
          inline_arrows = true,
          icons = {
            corner = "└",
            edge = "│",
            item = "│",
            bottom = "─",
            none = " ",
          },
        },
      },
      diagnostics = {
        enable = true,
        show_on_dirs = true,
        severity = {
          min = vim.diagnostic.severity.ERROR,
          max = vim.diagnostic.severity.ERROR
        },
      },
      view = {
        width = 30,
        cursorline = true,
        preserve_window_proportions = true,
      },
      update_focused_file = { enable = true },
      filters = {
        dotfiles = false,
        git_ignored = false,
        custom = { '^.git$' }
      },
      sort = {
        sorter = "suffix",
        folders_first = true
      },
      live_filter = {
        prefix = "Filter:",
        always_show_folders = false
      },
      on_attach = function(bufnr)
        local api = require('nvim-tree.api')

        api.config.mappings.default_on_attach(bufnr)

        local function opts(desc)
          return {
            desc = 'nvim-tree: ' .. desc,
            buffer = bufnr,
            noremap = true,
            silent = true,
            nowait = true
          }
        end

        local preview = require('nvim-tree-preview')

        vim.keymap.set('n', '<S-Tab>', preview.watch, opts 'Preview (Watch)')
        vim.keymap.set('n', '<Esc>', preview.unwatch, opts 'Close Preview/Unwatch')
        vim.keymap.set('n', '<C-d>', function() return preview.scroll(4) end, opts 'Scroll Down')
        vim.keymap.set('n', '<C-u>', function() return preview.scroll(-4) end, opts 'Scroll Up')
        vim.keymap.set('n', '<Tab>', function()
          local ok, node = pcall(api.tree.get_node_under_cursor)
          if ok and node then
            if node.type == 'directory' then
              api.node.open.edit()
            else
              preview.node(node, { toggle_focus = true })
            end
          end
        end, opts 'Preview')
      end
    }
  end

}
