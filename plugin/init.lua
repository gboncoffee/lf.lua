g = vim.g
v = vim.api
command = v.nvim_create_user_command

if g.autoloaded_lf then
    return
end

g.autoloaded_lf = true

-- defaults
g._lf_config = {
    default_cwd    = false,
    hijack_netrw   = true,
    change_cwd_cmd = "cd",
}

-- commands
command("Lf", function()
    require "lf".lf(g._lf_config.default_cwd)
end, {
    complete = "file",
    nargs = "*",
})

command("LfNoChangeCwd", function()
    require "lf".lf(false)
end, {
    complete = "file",
    nargs = "*",
})

command("LfChangeCwd", function() 
    require "lf".lf(true)
end, {
    complete = "file",
    nargs = "*",
})

-- netrw hijacking
if g._lf_config.hijack_netrw then
    augroup = v.nvim_create_augroup("LfHijackNetrw", {})
    v.nvim_create_autocmd({ "VimEnter" }, {
        pattern = "*",
        group   = augroup,
        command = "silent! autocmd! FileExplorer"
    })
    v.nvim_create_autocmd({ "BufEnter","VimEnter" }, {
        pattern  = "*",
        group    = augroup,
        callback = function()
            require "lf".lf_check_dir(vim.fn.expand("<amatch>"))
        end
    })
end
