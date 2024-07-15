-- NOTE: Plugins can also be configured to run Lua code when they are loaded.
--
-- This is often very useful to both group configuration, as well as handle
-- lazy loading plugins that don't need to be loaded immediately at startup.
--
-- For example, in the following configuration, we use:
--  event = 'VimEnter'
--
-- which loads which-key before all the UI elements are loaded. Events can be
-- normal autocommands events (`:help autocmd-events`).
--
-- Then, because we use the `config` key, the configuration only runs
-- after the plugin has been loaded:
--  config = function() ... end

return {
  {                     -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()

      require('which-key').add {
        {
          mode = 'n',
          { "<leader>b",  group = "[B]uffer" },
          { "<leader>b_", hidden = true },
          { "<leader>c",  group = "[C]ode" },
          { "<leader>c_", hidden = true },
          { "<leader>d",  group = "[D]ocument" },
          { "<leader>d_", hidden = true },
          { "<leader>g",  group = "[G]it Hunk" },
          { "<leader>g_", hidden = true },
          { "<leader>r",  group = "[R]ename" },
          { "<leader>r_", hidden = true },
          { "<leader>s",  group = "[S]earch" },
          { "<leader>s_", hidden = true },
          { "<leader>t",  group = "[T]oggle" },
          { "<leader>t_", hidden = true },
          { "<leader>w",  group = "[W]orkspace" },
          { "<leader>w_", hidden = true },
        },
        {
          mode = 'v',
          { "<leader>g", desc = "[G]it Hunk" },
        }
      }
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
