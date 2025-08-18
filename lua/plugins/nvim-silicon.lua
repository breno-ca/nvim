return {
  'michaelrommel/nvim-silicon',
  lazy = true,
  cmd = 'Silicon',
  opts = {
    font = 'CaskaydiaMono Nerd Font Mono',
    theme = 'Coldark-Dark',
    disable_defaults = false,
    shadow_color = nil,
    to_clipboard = true,
    wslclipboard = 'always',
    wslclipboardcopy = 'keep',
    command = 'silicon',
    output = function()
      return os.getenv('HOME') .. "/Pictures/silicon/" .. os.date("!%Y-%m-%dT%H-%M-%SZ") .. "_code.png"
    end,
  }
}
