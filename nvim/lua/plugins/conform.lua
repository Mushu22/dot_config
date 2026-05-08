-- Autoformat
-- Note check formater for file :ConformInfo on open file
return {
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {

      -- for debug in ConformInfo
      log_level = vim.log.levels.DEBUG,

      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        -- local disable_filetypes = { c = true, cpp = true, proto = true }
        -- :echo &filetype -> show current file type
        local disable_filetypes = { c = true, cpp = true, proto = true }
        local lsp_format_opt

        -- disable auto format, <leader>f needed to format
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return
        end
        return {
          timeout_ms = 500,
          lsp_format = lsp_format_opt,
        }
      end,

      -- link file format to selected formater
      -- Note install formater with mason, :Mason / Menus formatter / select i
      formatters_by_ft = {
        lua = { 'stylua' },
        cpp = { 'clang-format' },
        c = { 'clang-format' },
        h = { 'clang-format' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },

      -- Add some extra args for clang-format
      formatters = {
        ['clang-format'] = {
          prepend_args = {
            '-style={BasedOnStyle: Google, ColumnLimit: 120, NamespaceIndentation: All, DerivePointerAlignment: false, PointerAlignment: Left}',
          },
        },
      },
    },
  },
}