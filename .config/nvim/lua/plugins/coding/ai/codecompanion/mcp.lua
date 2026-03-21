local XDG_DATA_HOME = os.getenv("XDG_DATA_HOME") or (os.getenv("HOME") .. "/.local/share")
local MISE_INSTALLS_PATH = XDG_DATA_HOME .. "/mise/installs"
local UVX_COMMAND_PATH = MISE_INSTALLS_PATH .. "/uv/0.8.23/uv-aarch64-apple-darwin/uvx"
local NPX_COMMAND_PATH = MISE_INSTALLS_PATH .. "/node/22.20.0/bin/npx"

local M = {
  servers = {
    aws_docs = {
      cmd = {
        UVX_COMMAND_PATH,
        "awslabs.aws-documentation-mcp-server@latest",
      },
      env = {
        AWS_DOCUMENTATION_PARTITION = "aws",
        FASTMCP_LOG_LEVEL = "ERROR",
      },
    },
    context7 = {
      cmd = {
        NPX_COMMAND_PATH,
        "-y",
        "@upstash/context7-mcp",
      },
      env = {
        DEFAULT_MINIMUM_TOKENS = "6000",
      },
    },
    -- fetch = {
    --   cmd = {
    --     UVX_COMMAND_PATH,
    --     "mcp-server-fetch",
    --   },
    -- },
    filesystem = {
      cmd = {
        NPX_COMMAND_PATH,
        "-y",
        "@modelcontextprotocol/server-filesystem",
        vim.fn.getcwd(),
      },
    },
  },
  opts = {
    -- default_servers = { "aws_docs", "context7", "fetch", "filesystem" },
    default_servers = { "aws_docs", "context7", "filesystem" },
  },
}

return M
