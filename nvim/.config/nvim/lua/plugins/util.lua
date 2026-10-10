-- Small helpers so every plugin file can install itself with `vim.pack`
-- (Neovim 0.12+) without repeating boilerplate.
local M = {}

-- Expand "user/repo" into a full GitHub URL.
function M.gh(repo)
	return "https://github.com/" .. repo
end

-- Install/load plugins without the first-run confirmation prompt. Re-adding a
-- plugin that's already registered this session is a harmless no-op, so files
-- are free to declare their own shared dependencies (plenary, devicons, ...).
function M.add(specs)
	vim.pack.add(specs, { confirm = false })
end

return M
