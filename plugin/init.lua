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
    change_cwd_cmd = "cd",
}

-- commands
command("Lf", function(args)
    require "lf".lf(g._lf_config.default_cwd, args.args)
end, {
    complete = "file",
    nargs = "*",
})

command("LfNoChangeCwd", function(args)
    require "lf".lf(false, args.args)
end, {
    complete = "file",
    nargs = "*",
})

command("LfChangeCwd", function(args)
    require "lf".lf(true, args.args)
end, {
    complete = "file",
    nargs = "*",
})
