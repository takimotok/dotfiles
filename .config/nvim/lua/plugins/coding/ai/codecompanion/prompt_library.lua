local M = {
  ["With Instructions"] = {
    strategy = "chat",
    description = "general.instructions.md を前提にチャット",
    opts = {
      short_name = "inst",
      auto_submit = false,
    },
    context = {
      {
        type = "file",
        path = ".github/instructions/general.instructions.md",
      },
    },
    prompts = {
      {
        role = "user",
        content = "以降、このファイルの内容を前提にchatを行います。",
      },
    },
  },
}

return M
