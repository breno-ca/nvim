_G.nsd = function(description)
  return {
    noremap = true,
    silent = true,
    desc = description
  }
end

_G.nsder = function(description)
  return {
    noremap = true,
    silent = true,
    desc = description,
    expr = true,
    replace_keycodes = false
  }
end

_G.call = function(func, args)
  return function()
    func(args)
  end
end

_G.keymap = function(mode, mapping, command, opts)
  vim.keymap.set(
    mode,
    mapping,
    command,
    opts
  )
end

_G.n = 'n'
_G.i = 'i'
_G.t = 't'
_G.v = 'v'
_G.ni = { n, i }
_G.nv = { n, v }
_G.xo = { 'x', 'o' }
_G.ntv = { n, t, v }
_G.niv = { n, i, v }
