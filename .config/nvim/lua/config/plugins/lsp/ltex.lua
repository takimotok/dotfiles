local M = {}

-- user defined dictionaries
M.userDefinedDictionaries = {
  ["en-US"] = vim.fn.stdpath("config") .. "/spell/user/en-US.txt",
  ["ja-JP"] = vim.fn.stdpath("config") .. "/spell/user/ja-JP.txt",
}

-- function to avoid interacting with the table directly
function M.getUserDefinedDictionaryByLang(lang)
  return M.userDefinedDictionaries[lang]
end

-- Download language dictionaries if not exists
function M.download_dictionaries()
  if vim.fn.filereadable(vim.fn.expand("~/.local/share/cspell/vim.txt.gz")) ~= 1 then
    local url = "https://github.com/iamcco/coc-spell-checker/raw/master/dicts/vim/vim.txt.gz"
    io.popen("curl --create-dirs -fsSLo ~/.local/share/cspell/vim.txt.gz" .. " " .. url)
  end

  if vim.fn.filereadable(vim.fn.expand("~/.local/share/cspell/aws.txt")) ~= 1 then
    local url = "https://raw.githubusercontent.com/streetsidesoftware/cspell-dicts/main/dictionaries/aws/dict/aws.txt"
    io.popen("curl --create-dirs -fsSLo ~/.local/share/cspell/aws.txt" .. " " .. url)
  end

  if vim.fn.filereadable(vim.fn.expand("~/.local/share/cspell/bash.txt")) ~= 1 then
    local url = "https://github.com/streetsidesoftware/cspell-dicts/raw/main/dictionaries/bash/dict/bash-words.txt"
    io.popen("curl --create-dirs -fsSLo ~/.local/share/cspell/bash.txt" .. " " .. url)
  end

  if vim.fn.filereadable(vim.fn.expand("~/.local/share/cspell/css.txt")) ~= 1 then
    local url = "https://raw.githubusercontent.com/streetsidesoftware/cspell-dicts/main/dictionaries/css/dict/css.txt"
    io.popen("curl --create-dirs -fsSLo ~/.local/share/cspell/css.txt" .. " " .. url)
  end

  if vim.fn.filereadable(vim.fn.expand("~/.local/share/cspell/data-science.txt")) ~= 1 then
    local url =
      "https://raw.githubusercontent.com/streetsidesoftware/cspell-dicts/main/dictionaries/data-science/dict/data-science.txt"
    io.popen("curl --create-dirs -fsSLo ~/.local/share/cspell/data-science.txt" .. " " .. url)
  end

  if vim.fn.filereadable(vim.fn.expand("~/.local/share/cspell/docker.txt")) ~= 1 then
    local url =
      "https://raw.githubusercontent.com/streetsidesoftware/cspell-dicts/main/dictionaries/docker/src/docker-words.txt"
    io.popen("curl --create-dirs -fsSLo ~/.local/share/cspell/docker.txt" .. " " .. url)
  end

  if vim.fn.filereadable(vim.fn.expand("~/.local/share/cspell/en_US.txt")) ~= 1 then
    local url =
      "https://raw.githubusercontent.com/streetsidesoftware/cspell-dicts/main/dictionaries/en_US/src/en_US.txt"
    io.popen("curl --create-dirs -fsSLo ~/.local/share/cspell/en_US.txt" .. " " .. url)
  end

  if vim.fn.filereadable(vim.fn.expand("~/.local/share/cspell/fonts.txt")) ~= 1 then
    local url =
      "https://raw.githubusercontent.com/streetsidesoftware/cspell-dicts/main/dictionaries/fonts/dict/fonts.txt"
    io.popen("curl --create-dirs -fsSLo ~/.local/share/cspell/fonts.txt" .. " " .. url)
  end

  if vim.fn.filereadable(vim.fn.expand("~/.local/share/cspell/html.txt")) ~= 1 then
    local url = "https://raw.githubusercontent.com/streetsidesoftware/cspell-dicts/main/dictionaries/html/dict/html.txt"
    io.popen("curl --create-dirs -fsSLo ~/.local/share/cspell/html.txt" .. " " .. url)
  end

  if vim.fn.filereadable(vim.fn.expand("~/.local/share/cspell/latex.txt")) ~= 1 then
    local url =
      "https://raw.githubusercontent.com/streetsidesoftware/cspell-dicts/main/dictionaries/latex/dict/latex.txt"
    io.popen("curl --create-dirs -fsSLo ~/.local/share/cspell/latex.txt" .. " " .. url)
  end

  if vim.fn.filereadable(vim.fn.expand("~/.local/share/cspell/lua.txt")) ~= 1 then
    local url = "https://raw.githubusercontent.com/streetsidesoftware/cspell-dicts/main/dictionaries/lua/dict/lua.txt"
    io.popen("curl --create-dirs -fsSLo ~/.local/share/cspell/lua.txt" .. " " .. url)
  end

  if vim.fn.filereadable(vim.fn.expand("~/.local/share/cspell/node.txt")) ~= 1 then
    local url = "https://raw.githubusercontent.com/streetsidesoftware/cspell-dicts/main/dictionaries/node/dict/node.txt"
    io.popen("curl --create-dirs -fsSLo ~/.local/share/cspell/node.txt" .. " " .. url)
  end

  if vim.fn.filereadable(vim.fn.expand("~/.local/share/cspell/npm.txt")) ~= 1 then
    local url = "https://raw.githubusercontent.com/streetsidesoftware/cspell-dicts/main/dictionaries/npm/dict/npm.txt"
    io.popen("curl --create-dirs -fsSLo ~/.local/share/cspell/npm.txt" .. " " .. url)
  end

  if vim.fn.filereadable(vim.fn.expand("~/.local/share/cspell/php.txt")) ~= 1 then
    local url = "https://raw.githubusercontent.com/streetsidesoftware/cspell-dicts/main/dictionaries/php/dict/php.txt"
    io.popen("curl --create-dirs -fsSLo ~/.local/share/cspell/php.txt" .. " " .. url)
  end

  if vim.fn.filereadable(vim.fn.expand("~/.local/share/cspell/python.txt")) ~= 1 then
    local url =
      "https://raw.githubusercontent.com/streetsidesoftware/cspell-dicts/main/dictionaries/python/src/python/python.txt"
    io.popen("curl --create-dirs -fsSLo ~/.local/share/cspell/python.txt" .. " " .. url)
  end

  if vim.fn.filereadable(vim.fn.expand("~/.local/share/cspell/ruby.txt")) ~= 1 then
    local url = "https://raw.githubusercontent.com/streetsidesoftware/cspell-dicts/main/dictionaries/ruby/dict/ruby.txt"
    io.popen("curl --create-dirs -fsSLo ~/.local/share/cspell/ruby.txt" .. " " .. url)
  end

  if vim.fn.filereadable(vim.fn.expand("~/.local/share/cspell/shell.txt")) ~= 1 then
    local url =
      "https://raw.githubusercontent.com/streetsidesoftware/cspell-dicts/main/dictionaries/shell/dict/shell-all-words.txt"
    io.popen("curl --create-dirs -fsSLo ~/.local/share/cspell/shell.txt" .. " " .. url)
  end
end

function M.read_dictionaries()
  -- load user defined dictionaries
  -- make sure spell/user/{lang}.txt files are exist
  local files = {}

  -- specify ja-JP dictionary
  local userDefinedJaJPDictionary = M.getUserDefinedDictionaryByLang("ja-JP")
  local lang = vim.fn.fnamemodify(userDefinedJaJPDictionary, ":t:r")
  local fullpath = vim.fs.normalize(userDefinedJaJPDictionary)
  files[lang] = { ":" .. fullpath }

  -- expand words in the en-US dictionaries
  files["en-US"] = {}
  local cspellFiles = vim.fn.glob("~/.local/share/cspell/*.txt")
  for _, file in ipairs(vim.split(cspellFiles, "\n")) do
    for line in io.open(file, "r"):lines() do
      if line == nil or line == "" then
        goto continue
      end

      table.insert(files["en-US"], line)

      ::continue::
    end
  end

  local userDefinedEnUSDictionary = M.getUserDefinedDictionaryByLang("en-US")
  for line in io.open(userDefinedEnUSDictionary, "r"):lines() do
    if line == nil or line == "" then
      goto continue
    end

    table.insert(files["en-US"], line)

    ::continue::
  end

  return files
end

function M.on_attach(client, _)
  local addToDict = function(command, _)
    --[[
    -- command = {
      -- arguments={ ... },
      -- command=_ltex.addToDictionary,
      -- title=Add 'LTeX' to dictionary,
    -- }
    -- command.arguments = {
    --  url = xxx (buffer file path),
    --  words = {
    --    {lang} = { word1 },
    --  },
    -- }
    ]]
    for _, arg in ipairs(command.arguments) do
      -- @TODO: we could read dict. files once per lang ?
      for lang, words in pairs(arg.words) do
        M.addWrodsToUserDictionary(lang, words)
        client.config.settings.ltex.dictionary = M.read_dictionaries()
      end
    end

    -- notify the client of the new settings
    return client.notify("workspace/didChangeConfiguration", client.config.settings)
  end

  -- add the function to handle the command
  -- then lsp.commands does not find the handler, it will look at opts.handler["workspace/executeCommand"]
  vim.lsp.commands["_ltex.addToDictionary"] = addToDict
end

function M.addWrodsToUserDictionary(lang, words)
  local userDictionary = M.getUserDefinedDictionaryByLang(lang)
  if not userDictionary then
    print("no user_dictionary defined for lang %q", lang)
    return nil
  end

  local file = io.open(userDictionary, "a+")
  if file == nil then
    return
  end

  for _, word in ipairs(words) do
    file:write(word .. "\n")
  end

  file:close()
end

function M.init()
  M.download_dictionaries()
end

return M
