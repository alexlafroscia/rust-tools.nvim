local utils = require('rust-tools.utils.utils')

local M = {}

local function get_opts(query)
    local opts = vim.lsp.util.make_position_params();
    opts.query = query;
    opts.parseOnly = false;
    opts.selections = {vim.lsp.util.make_range_params().range};
    return opts
end

local function handler(err, result)
    if err then
        error("Cound not execute request to server: ".. err.message)
        return
    end

    vim.lsp.util.apply_workspace_edit(result);
end

function M.ssr(query)
    if not query then
       query = vim.fn.input("Enter query: ")
    end
    utils.request(0, "experimental/ssr", get_opts(query), handler)
end

return M
