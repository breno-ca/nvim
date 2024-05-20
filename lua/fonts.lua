--[[
Para trocar a fonte atual do neovim é necessário
alterar a fonte pelas configurações do terminal

Caso as fontes sejam definidas pelo sistema, estas
funções serão úteis para alternar entre as fontes
--]]

-- lista de fontes 
local fonts = {
        'CaskaydiaMono NFM',
        'Cousine Nerd Font Mono',
        'MartianMono NFM'
}

-- lista as fontes da lista
function ListFonts()
    for i, font in ipairs(fonts) do
        print(i .. ". " .. font)
    end
end

-- define uma fonte com base no índice
function SetFont(index)
	-- verifica se o índice informado é válido
	if index < 1 or index > #fonts then
		print("Fonte não encontrada")
		return
	end
	print('set guifont=' .. fonts[index])
	vim.cmd('set guifont=' .. fonts[index])
end
