return function(client, bufnr)
  if client.server_capabilities.inlayHintProvider then
    local inlayhints_avail, inlayhints = pcall(require, "lsp-inlayhints")
    if inlayhints_avail then inlayhints.on_attach(client, bufnr, _) end
  end
  if client.name == "copilot" then
    local copilot_cmp_avail, copilot_cmp = pcall(require, "copilot_cmp")
    if copilot_cmp_avail then copilot_cmp._on_insert_enter {} end
  end

  local function is_vue_project()
    local package_json_path = vim.fn.getcwd() .. "/package.json"
    local file = io.open(package_json_path, "r")

    if file then
      local package_json_content = file:read "*a"
      file:close()

      local package_json = vim.fn.json_decode(package_json_content)

      if package_json and package_json.dependencies and package_json.dependencies.vue then return true end
    end

    return false
  end

  local function is_react_project()
    local package_json_path = vim.fn.getcwd() .. "/package.json"
    local file = io.open(package_json_path, "r")

    if file then
      local package_json_content = file:read "*a"
      file:close()

      local package_json = vim.fn.json_decode(package_json_content)

      if package_json and package_json.dependencies and package_json.dependencies.react then return true end
    end

    return false
  end

  -- prevent tsserver and denols competeing
  local active_clients = vim.lsp.get_active_clients()

  if is_vue_project() then
    if client.name == "volar" then
      for _, client_ in pairs(active_clients) do
        -- stop tsserver if denols is already active
        if client_.name == "tsserver" then client_.stop() end
      end
    elseif client.name == "tsserver" then
      for _, client_ in pairs(active_clients) do
        -- prevent tsserver from starting if denols is already active
        if client_.name == "volar" then client.stop() end
      end
    end
  end

  if is_react_project() then
    if client.name == "tsserver" then
      for _, client_ in pairs(active_clients) do
        -- stop tsserver if denols is already active
        if client_.name == "volar" then client_.stop() end
      end
    elseif client.name == "volar" then
      for _, client_ in pairs(active_clients) do
        -- prevent tsserver from starting if denols is already active
        if client_.name == "tsserver" then client.stop() end
      end
    end
  end
end
