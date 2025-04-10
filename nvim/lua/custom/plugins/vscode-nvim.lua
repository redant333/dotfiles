return {
  'Mofiqul/vscode.nvim',
  priority = 1000,
  opts = {
    group_overrides = {
      -- Fix for bad colors in NeoTree
      NeoTreeDimText = { bg = 'none' },
    },
  },
  config = function(_, opts)
    require('vscode').setup(opts)
    vim.cmd.colorscheme 'vscode'
  end,
}
