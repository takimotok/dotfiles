local XDG_DATA_HOME = os.getenv("XDG_DATA_HOME") or (os.getenv("HOME") .. "/.local/share")
local MISE_SHIMS_PATH = XDG_DATA_HOME .. "/mise/shims"
local UVX_COMMAND_PATH = MISE_SHIMS_PATH .. "/uvx"
local NPX_COMMAND_PATH = MISE_SHIMS_PATH .. "/npx"

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
      roots = function()
        local home = os.getenv("HOME")
        local roots_list = {}

        local ghq_root = vim.fn.system("git config --get ghq.root"):gsub("%s+", "")
        if ghq_root ~= "" then
          ghq_root = ghq_root:gsub("^~", home)
          table.insert(roots_list, {
            name = "ghq-projects",
            uri = "file://" .. ghq_root,
          })
        end

        local additional_dirs = {
          home .. "/Desktop/tmp",
        }

        for _, dir in ipairs(additional_dirs) do
          if vim.fn.isdirectory(dir) == 1 then
            table.insert(roots_list, {
              name = "additional-" .. vim.fn.fnamemodify(dir, ":t"),
              uri = "file://" .. dir,
            })
          end
        end

        return roots_list
      end,
    },
  },
  opts = {
    default_servers = { "context7", "filesystem" },
  },
}

return M
