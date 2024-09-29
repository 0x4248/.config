local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
    lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  spec = {
    { "LazyVim/LazyVim",       import = "lazyvim.plugins" },
    {
      "tokyonight.nvim",
      opts = {
        transparent = true,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
      }
    },
    { 'wakatime/vim-wakatime', lazy = false },
    {
      "nvimdev/dashboard-nvim",
      event = "VimEnter",
      opts = function()
        local logo = [[
██╗  ██╗██████╗ ██╗  ██╗ █████╗ ██╗   ██╗██╗███╗   ███╗
██║  ██║╚════██╗██║  ██║██╔══██╗██║   ██║██║████╗ ████║
███████║ █████╔╝███████║╚█████╔╝██║   ██║██║██╔████╔██║
╚════██║██╔═══╝ ╚════██║██╔══██╗╚██╗ ██╔╝██║██║╚██╔╝██║
     ██║███████╗     ██║╚█████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
     ╚═╝╚══════╝     ╚═╝ ╚════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]]

        logo = string.rep("\n", 8) .. logo .. "\n\n"

        local opts = {
          theme = "doom",
          hide = {
            statusline = false,
          },
          config = {
            header = vim.split(logo, "\n"),
            center = {
              { action = LazyVim.telescope("files"), desc = " Find File", icon = " ", key = "f" },
              { action = "ene | startinsert", desc = " New File", icon = " ", key = "n" },
              { action = "Telescope oldfiles", desc = " Recent Files", icon = " ", key = "r" },
              { action = "Telescope live_grep", desc = " Find Text", icon = " ", key = "g" },
              { action = "Neotree", desc = " File Explorer", icon = " ", key = "e" },
              { action = [[lua LazyVim.telescope.config_files()()]], desc = " Config", icon = " ", key = "c" },
              { action = 'lua require("persistence").load()', desc = " Restore Session", icon = " ", key = "s" },
              { action = "LazyExtras", desc = " Lazy Extras", icon = " ", key = "x" },
              { action = "Lazy", desc = " Lazy", icon = "󰒲 ", key = "l" },
              { action = "LazyVim.terminal()", desc = " Terminal", icon = " ", key = "t" },
              { action = "qa", desc = " Quit", icon = " ", key = "q" },
            },
            footer = function()
              local stats = require("lazy").stats()
              local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
              return { "⚡ neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms ⚡" }
            end,
          },
        }

        for _, button in ipairs(opts.config.center) do
          button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
          button.key_format = "  %s"
        end

        if vim.o.filetype == "lazy" then
          vim.cmd.close()
          vim.api.nvim_create_autocmd("User", {
            pattern = "DashboardLoaded",
            callback = function()
              require("lazy").show()
            end,
          })
        end

        return opts
      end,
    },
  },

  defaults = {
    lazy = false,
    version = false,
  },

  checker = { enabled = true },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

vim.opt.relativenumber = false
