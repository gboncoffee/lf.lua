local M = {}
local v = vim.api
local g = vim.g

M._lf_after_close = function(change) -- {{{
    local buffer_to_close = v.nvim_get_current_buf()

    if change then
        local sel_dir = io.open("/tmp/lfvim-lastdir", "r")
        if sel_dir then
            local dir = sel_dir:read() 
            if dir ~= "" then
                vim.cmd(g._lf_config.change_cwd_cmd .. dir)
            end
        end
    end

    if v.nvim_buf_is_valid(buffer_to_close) then
        v.nvim_buf_delete(buffer_to_close, {})
    end

    local sel_file = io.open("/tmp/lfvim-selection", "r")
    if sel_file then
        local file = sel_file:read() 
        if file ~= "" then
            vim.cmd("e " .. file)
            vim.cmd("filetype detect")
            vim.cmd("do BufAdd,BufEnter")
        end
    end

end -- }}}

M.setup = function(opts)
    for key, value in pairs(opts) do
        g._lf_config[key] = value
    end
end

M.lf = function(change, path) -- {{{
    if not path then path = "" end
    local lf_cmd = "lf -last-dir-path /tmp/lfvim-lastdir -selection-path /tmp/lfvim-selection " .. path

    -- we need to be sure that theese files aren't there
    os.remove("/tmp/lfvim-lastdir")
    os.remove("/tmp/lfvim-selection")

    local buffer = v.nvim_create_buf(false, true)
    v.nvim_open_win(buffer, true, {
        relative = "editor",
        col      = math.ceil(vim.o.columns * 0.125),
        row      = math.ceil(vim.o.lines   * 0.125),
        width    = math.ceil(vim.o.columns * 0.75 - 2),
        height   = math.ceil(vim.o.lines   * 0.75 - 2),
        border   = "rounded"
    })
    vim.cmd("term " .. lf_cmd)
    vim.bo.bufhidden = "wipe"

    v.nvim_create_autocmd({ "TermClose" }, {
        buffer = buffer,
        callback = function()
            M._lf_after_close(change)
        end
    })

    vim.cmd("normal a")
end -- }}}

return M
