return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true
    -- config = function()
    --     local npair = require("nvim-autopairs")
    --     local Rule = require("nvim-autopairs.rule")
    --
    --     npair.setup({})
    --
    --     -- only nix file add ";"
    --     npair.add_rule(
    --         Rule("}", "};", "nix")
    --         :with_pair(function() return false end)
    --         :with_move(function(opts)
    --             return opts.char == "}"
    --         end)
    --         :use_undo(true)
    --         :after(function(opts)
    --             vim.api.nvim_put({ ";" }, "c", true, true)
    --         end)
    --     )
    -- end
}
