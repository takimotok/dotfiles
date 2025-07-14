return {
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
  settings = {
    typescript = {
      inlayHints = {
        parameterNames = { enabled = "literals" },
        functionLikeReturnTypes = { enabled = true },
        variableTypes = { enabled = false },
      },
      updateImportsOnFileMove = { enabled = "always" },
    },
    vtsls = {
      enableMoveToFileCodeAction = true,
      autoUseWorkspaceTsdk = true,
    },
  },
}