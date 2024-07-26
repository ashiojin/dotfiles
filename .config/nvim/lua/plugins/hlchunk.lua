-- local function interpolate(color1, color2, ratio)
--     local function hex_to_rgb(hex)
--         if #hex == 0 then
--             hex = '#000000'
--         end
--         print('parse: ' .. hex)
--         local r,g,b = string.match(hex, '#?(%x%x)(%x%x)(%x%x)')
-- 
--         return tonumber(r, 16), tonumber(g, 16), tonumber(b, 16)
--     end
-- 
--     local function rgb_to_hex(r, g, b)
--         local hex = '#'
--         hex = hex .. string.format('%02x', vim.fn.round(r))
--         hex = hex .. string.format('%02x', vim.fn.round(g))
--         hex = hex .. string.format('%02x', vim.fn.round(b))
--         return hex
--     end
-- 
--     local r1, g1, b1 = hex_to_rgb(color1)
--     local r2, g2, b2 = hex_to_rgb(color2)
-- 
--     local r = r1 * (1 - ratio) + r2 * ratio
--     local g = g1 * (1 - ratio) + g2 * ratio
--     local b = b1 * (1 - ratio) + b2 * ratio
-- 
--     return rgb_to_hex(r, g, b)
-- end
return {
    'shellRaining/hlchunk.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
        chunk = {
            enable = true,
            duration = 50,
            delay = 10,
        },
        indent = {
            enable = true,
            chars = { '│', },
            style = {
                {
                    fg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID('Whitespace')), 'fg', 'gui'),
                },
            },
        },
        line_num = {
            enable = false,
        },
        blank = {
            enable = true,
            chars = { ' ', },
            style = {
                {
                    bg = vim.fn.synIDattr(
                        vim.fn.synIDtrans(vim.fn.hlID('cursorline')),
                        'bg',
                        'gui'
                    ),
                },
                { bg = '', fg = '' },
            },
        },
    },
}
