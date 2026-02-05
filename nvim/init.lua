-- lua/custom 以下の設定を読みこむ
require("custom")

-- リーダーキーの設定
-- NOTE: プラグインが読み込まれる前に設定する
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 検索
-- 大文字小文字を区別せずに検索します
vim.opt.ignorecase = true
-- 検索文字列に大文字が含まれている場合は、大文字小文字を区別します
vim.opt.smartcase = true
-- 検索結果をハイライト表示します
vim.opt.hlsearch = true
-- 入力中から検索結果にジャンプします
vim.opt.incsearch = true
-- 置換時にプレビュー画面を分割して表示します
vim.opt.inccommand = "split"

-- 外観とUI
-- 行番号を表示します
vim.opt.number = true
-- ターミナルのタイトルを編集中のファイル名にします
vim.opt.title = true
-- カーソル行を強調表示します
vim.opt.cursorline = true
-- サイドバーのサインカラム（エラー等が出る列）を常に表示します
vim.opt.signcolumn = "yes"
-- Nerd Fontがインストールされていることを前提にアイコン等を有効にします
vim.g.have_nerd_font = true
-- マウス操作を有効にします
vim.opt.mouse = "a"
-- 下部のモード表示（-- INSERT -- 等）を非表示にします（ステータスラインがあるため）
vim.opt.showmode = false
-- カーソルの上下に最低限表示する行数を指定します
vim.opt.scrolloff = 10
-- 不可視文字を表示します
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- インデントとタブ
-- 改行時に前の行のインデントを継続します
vim.opt.autoindent = true
-- 言語構造に基づいた高度な自動インデントを行います
vim.opt.smartindent = true
-- 行頭のTabで shiftwidth の数だけインデントします
vim.opt.smarttab = true
-- タブ幅を指定します
vim.opt.tabstop = 4
-- 自動インデントの幅を指定します
vim.opt.shiftwidth = 4
-- タブを入力した際にスペースを展開します
vim.opt.expandtab = true
-- 折り返し時にインデントを維持します
vim.opt.breakindent = true

-- 動作・システム
-- 保存せずにバッファ（ファイル）を切り替えられるようにします
vim.opt.hidden = true
-- 分割を下に開きます
vim.opt.splitbelow = true
-- 分割を右に開きます
vim.opt.splitright = true
-- 特定の文字数での自動改行を無効化します
vim.opt.textwidth = 0
-- 行末・行頭でのカーソル移動の制限を緩和します
vim.opt.whichwrap = "b,s,h,l,<,>,[,]"
-- Undo（元に戻す）履歴をファイルに保存します
vim.opt.undofile = true
-- 反応速度（ms）を向上させます
vim.opt.updatetime = 250
-- キーコード待機時間を設定します
vim.opt.timeoutlen = 300
-- ファイルを閉じる際に保存確認ダイアログを表示します
vim.opt.confirm = true
-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- クリップボード
-- OSのクリップボードとNeovimのレジスタを同期させる
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)

-- キーマップ
-- ノーマルモードで Esc を押した時に検索ハイライトを消去します
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
-- 診断情報のリスト表示
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
-- ターミナルモードを Esc 2回で抜けます
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
-- Ctrl + hjkl でウィンドウ間を移動します
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
-- lua/custom/keymaps.lua に追記
-- F5キーで QuickRun を実行
vim.keymap.set("n", "<F5>", "<cmd>QuickRun<CR>", { desc = "Run code with QuickRun" })
-- 実行中に「あ、無限ループした！」となった時の停止用（おまけ）
vim.keymap.set("n", "<leader>qk", "<cmd>pcall(quickrun#session#kill)<CR>", { desc = "[Q]uickrun [K]ill" })
-- 端末（ターミナル）のタブやウィンドウ名に、現在開いているファイル名を表示します。
vim.o.title = true

-- [[ 括弧抜け設定 ]]
-- インサートモード中に Shift + Tab で、次の閉じ括弧 ')', '}', ']' の外側へジャンプします
vim.keymap.set("i", "<S-Tab>", function()
	-- カーソルの直後の文字を確認し、閉じ括弧なら1文字右へ移動
	local col = vim.fn.col(".")
	local line = vim.fn.getline(".")
	local char = line:sub(col, col)

	if char == ")" or char == "}" or char == "]" or char == '"' or char == "'" then
		return "<Right>"
	else
		-- 閉じ括弧がない場合は、通常のShift+Tab（逆インデント）の挙動を維持
		return "<C-d>"
	end
end, { expr = true, replace_keycodes = true, desc = "Jump out of brackets" })

-- [[ オプション設定 ]]
-- 詳細は `:help vim.o` を参照

-- 相対行番号を表示する（移動を助けるために便利。必要に応じてコメントアウトを外す）
vim.o.relativenumber = true

-- 行番号を表示する（デフォルトにする）
vim.o.number = true
vim.o.statuscolumn = "%=%l %r"

-- マウスモードを有効化（画面分割のサイズ変更などに便利）
vim.o.mouse = "a"
-- モード（-- INSERT -- など）を表示しない（ステータスラインで確認できるため不要）
vim.o.showmode = false
-- 折り返し後の行にもインデントを適用する
vim.o.breakindent = true
-- アンドゥ履歴をファイルとして保存する（Neovimを閉じても戻せるようになる）
vim.o.undofile = true
-- 検索時に大文字小文字を区別しない。ただし検索語に大文字が含まれる場合は区別する (smartcase)
vim.o.ignorecase = true
vim.o.smartcase = true
-- サインカラム（エラーアイコンなどが表示される左端）を常に表示する
vim.o.signcolumn = "yes"
-- 更新時間を短縮する（変更が検知されるまでの速度に影響）
vim.o.updatetime = 250
-- キーマップの入力待ち時間を短縮する（jj などの判定が速くなります）
vim.o.timeoutlen = 300
-- 新しい分割ウィンドウを右、または下に開くように設定
vim.o.splitright = true
vim.o.splitbelow = true
-- 不可視文字（タブや末尾のスペースなど）の表示設定
-- `vim.opt` はテーブル形式のオプションを扱うのに便利です
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
-- 置換コマンド（:%s/..）の変更内容を、入力しながらリアルタイムでプレビューする
vim.o.inccommand = "split"
-- カーソル行をハイライトする
vim.o.cursorline = true
-- カーソルの上下に常に表示しておく最小行数（10行あれば視認性が良い）
vim.o.scrolloff = 10
-- 保存せずに終了しようとした際に、保存するか確認ダイアログを出す
vim.o.confirm = true

-- [[ 基本キーマップ ]]
-- 詳細は `:help vim.keymap.set()` を参照
-- ノーマルモードで <Esc> を押すと検索のハイライトを消す
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
-- エラーや警告（診断情報）の一覧をクイックフィックスリストで開く
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "診断リストを開く" })
-- 内蔵ターミナルモードを <Esc><Esc> で抜けられるようにする
-- 標準の <C-\><C-n> よりも直感的です
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "ターミナルモードを抜ける" })
-- ウィンドウ間の移動を Ctrl + hjkl で簡単に行えるようにする
-- （Ctrl + w -> h と打つ手間を省く）
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "左のウィンドウへ移動" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "右のウィンドウへ移動" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "下のウィンドウへ移動" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "上のウィンドウへ移動" })

-- [[ BinaryXXD ]]
local binary_group = vim.api.nvim_create_augroup("BinaryXXD", { clear = true })
-- *.bin ファイルを開く前にバイナリモードをセット
vim.api.nvim_create_autocmd("BufReadPre", {
	pattern = "*.bin",
	group = binary_group,
	callback = function()
		vim.bo.binary = true
	end,
})
-- バイナリモードなら xxd で表示を変換
vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = "*",
	group = binary_group,
	callback = function()
		if vim.bo.binary then
			vim.cmd("silent %!xxd -g 1")
			vim.bo.filetype = "xxd"
		end
	end,
})
-- 書き込み前に xxd からバイナリに戻す
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	group = binary_group,
	callback = function()
		if vim.bo.binary then
			vim.cmd("%!xxd -r")
		end
	end,
})
-- 書き込み後に再び xxd 表示に戻す
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*",
	group = binary_group,
	callback = function()
		if vim.bo.binary then
			vim.cmd("silent %!xxd -g 1")
			vim.bo.modified = false
		end
	end,
})

-- [[ 基本的な自動コマンド ]]
-- 詳細は `:help lua-guide-autocommands` を参照

-- テキストをヤンク（コピー）した際にハイライトを表示する
-- ノーマルモードで `yap`（段落をコピー）などを試すと分かりやすいです
-- 詳細は `:help vim.hl.on_yank()` を参照
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "テキストをヤンクした際にハイライトする",
	-- 設定の重複を防ぐためにグループ化
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- [[ プラグインマネージャー `lazy.nvim` のインストール ]]
-- 詳細は `:help lazy.nvim.txt` または https://github.com/folke/lazy.nvim を参照
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	-- 安定版の lazy.nvim を GitHub からクローンする
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("lazy.nvim のクローン中にエラーが発生しました:\n" .. out)
	end
end

---@type vim.Option
local rtp = vim.opt.rtp
-- Neovim の検索パス（runtimepath）の先頭に lazy.nvim を追加する
rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--  To check the current status of your plugins, run
--    :Lazy
--  You can press `?` in this menu for help. Use `:q` to close the window
--  To update plugins you can run
--    :Lazy update
require("lazy").setup({
	-- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
	"NMAC427/guess-indent.nvim",
	{
		"thinca/vim-quickrun",
		dependencies = {
			{ "shougo/vimproc.vim", build = "make" },
		},
		config = function()
			vim.g.quickrun_config = {
				["_"] = {
					runner = "vimproc",
					runner_options = {
						["runner/vimproc/updatetime"] = 60,
					},
					outputter = "error",
					["outputter/error/success"] = "buffer",
					["outputter/error/error"] = "quickfix",
					["outputter/buffer/split"] = ":rightbelow 8sp", -- 下側に8行で表示
					["outputter/buffer/close_on_empty"] = 1,
				},
				cpp = {
					command = "g++",
					-- 2026年現在の最新標準 C++26 を指定。競プロなら -O2 と -Wall は必須
					cmdopt = "-std=c++26 -O2 -Wall",
					["hook/time/enable"] = 1, -- 実行時間を計測する kurenaifさん流設定
				},
				python = {
					command = "python3",
				},
				tex = {
					command = "latexmk",
					cmdopt = "--xelatex -pv",
					exec = "%c %o %s",
				},
				-- グラフ作成に便利
				gnuplot = {
					command = "gnuplot",
				},
			}
		end,
	},
	{
		-- 1. インデントの可視化 (vim-indent-guides の現代版)
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			enabled = false, -- 最初はOFFにしておく kurenaifさん流
		},
		keys = {
			{ "<leader>ig", "<cmd>IBLToggle<cr>", desc = "Toggle Indent Guides" },
		},
	},
	{
		-- 2. スタート画面 (vim-startify の現代版)
		-- 最近開いたファイルやブックマークを美しく表示
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		config = function()
			require("dashboard").setup({
				theme = "hyper",
				config = {
					week_header = { enable = true },
					shortcut = {
						{ desc = "󰒲 Lazy", group = "@property", action = "Lazy", key = "l" },
						{ desc = "󰄉 Recent Files", group = "@property", action = "Telescope oldfiles", key = "r" },
					},
				},
			})
		end,
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},

	-- NOTE: Plugins can also be added by using a table,
	-- with the first argument being the link and the following
	--
	--
	-- Use `opts = {}` to automatically pass options to a plugin's `setup()` function, forcing the plugin to be loaded.
	--

	-- Alternatively, use `config = function() ... end` for full control over the configuration.
	-- If you prefer to call `setup` explicitly, use:
	--    {
	--        'lewis6991/gitsigns.nvim',
	--        config = function()
	--            require('gitsigns').setup({
	--                -- Your gitsigns configuration here
	--            })
	--        end,
	--    }
	--
	-- Here is a more advanced example where we pass configuration
	-- options to `gitsigns.nvim`.
	--
	-- See `:help gitsigns` to understand what the configuration keys do
	{ -- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},

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
	-- Then, because we use the `opts` key (recommended), the configuration runs
	-- after the plugin has been loaded as `require(MODULE).setup(opts)`.

	{ -- Useful plugin to show you pending keybinds.
		"folke/which-key.nvim",
		event = "VimEnter", -- Sets the loading event to 'VimEnter'
		opts = {
			-- delay between pressing a key and opening which-key (milliseconds)
			-- this setting is independent of vim.o.timeoutlen
			delay = 0,
			icons = {
				-- set icon mappings to true if you have a Nerd Font
				mappings = vim.g.have_nerd_font,
				-- If you are using a Nerd Font: set icons.keys to an empty table which will use the
				-- default which-key.nvim defined Nerd Font icons, otherwise define a string table
				keys = vim.g.have_nerd_font and {} or {
					Up = "<Up> ",
					Down = "<Down> ",
					Left = "<Left> ",
					Right = "<Right> ",
					C = "<C-…> ",
					M = "<M-…> ",
					D = "<D-…> ",
					S = "<S-…> ",
					CR = "<CR> ",
					Esc = "<Esc> ",
					ScrollWheelDown = "<ScrollWheelDown> ",
					ScrollWheelUp = "<ScrollWheelUp> ",
					NL = "<NL> ",
					BS = "<BS> ",
					Space = "<Space> ",
					Tab = "<Tab> ",
					F1 = "<F1>",
					F2 = "<F2>",
					F3 = "<F3>",
					F4 = "<F4>",
					F5 = "<F5>",
					F6 = "<F6>",
					F7 = "<F7>",
					F8 = "<F8>",
					F9 = "<F9>",
					F10 = "<F10>",
					F11 = "<F11>",
					F12 = "<F12>",
				},
			},

			-- Document existing key chains
			spec = {
				{ "<leader>s", group = "[S]earch" },
				{ "<leader>t", group = "[T]oggle" },
				{ "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
			},
		},
	},

	-- NOTE: Plugins can specify dependencies.
	--
	-- The dependencies are proper plugin specifications as well - anything
	-- you do for a plugin at the top level, you can do for a dependency.
	--
	-- Use the `dependencies` key to specify the dependencies of a particular plugin

	{ -- Fuzzy Finder (files, lsp, etc)
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ -- If encountering errors, see telescope-fzf-native README for installation instructions
				"nvim-telescope/telescope-fzf-native.nvim",

				-- `build` is used to run some command when the plugin is installed/updated.
				-- This is only run then, not every time Neovim starts up.
				build = "make",

				-- `cond` is a condition used to determine whether this plugin should be
				-- installed and loaded.
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },

			-- Useful for getting pretty icons, but requires a Nerd Font.
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
		config = function()
			-- Telescope is a fuzzy finder that comes with a lot of different things that
			-- it can fuzzy find! It's more than just a "file finder", it can search
			-- many different aspects of Neovim, your workspace, LSP, and more!
			--
			-- The easiest way to use Telescope, is to start by doing something like:
			--  :Telescope help_tags
			--
			-- After running this command, a window will open up and you're able to
			-- type in the prompt window. You'll see a list of `help_tags` options and
			-- a corresponding preview of the help.
			--
			-- Two important keymaps to use while in Telescope are:
			--  - Insert mode: <c-/>
			--  - Normal mode: ?
			--
			-- This opens a window that shows you all of the keymaps for the current
			-- Telescope picker. This is really useful to discover what Telescope can
			-- do as well as how to actually do it!

			-- [[ Configure Telescope ]]
			-- See `:help telescope` and `:help telescope.setup()`
			require("telescope").setup({
				-- You can put your default mappings / updates / etc. in here
				--  All the info you're looking for is in `:help telescope.setup()`
				--
				-- defaults = {
				--   mappings = {
				--     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
				--   },
				-- },
				-- pickers = {}
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			-- Enable Telescope extensions if they are installed
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")

			-- See `:help telescope.builtin`
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
			vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
			vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
			vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

			-- Slightly advanced example of overriding default behavior and theme
			vim.keymap.set("n", "<leader>/", function()
				-- You can pass additional configuration to Telescope to change the theme, layout, etc.
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "[/] Fuzzily search in current buffer" })

			-- It's also possible to pass additional configuration options.
			--  See `:help telescope.builtin.live_grep()` for information about particular keys
			vim.keymap.set("n", "<leader>s/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "[S]earch [/] in Open Files" })

			-- Shortcut for searching your Neovim configuration files
			vim.keymap.set("n", "<leader>sn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch [N]eovim files" })
		end,
	},

	-- LSP Plugins
	{
		-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
		-- used for completion, annotations and signatures of Neovim apis
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		-- Main LSP Configuration
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for Neovim
			-- Mason must be loaded before its dependents so we need to set it up here.
			-- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
			{ "mason-org/mason.nvim", opts = {} },
			"mason-org/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			-- Useful status updates for LSP.
			{ "j-hui/fidget.nvim", opts = {} },

			-- Allows extra capabilities provided by blink.cmp
			"saghen/blink.cmp",
		},
		config = function()
			-- Brief aside: **What is LSP?**
			--
			-- LSP is an initialism you've probably heard, but might not understand what it is.
			--
			-- LSP stands for Language Server Protocol. It's a protocol that helps editors
			-- and language tooling communicate in a standardized fashion.
			--
			-- In general, you have a "server" which is some tool built to understand a particular
			-- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
			-- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
			-- processes that communicate with some "client" - in this case, Neovim!
			--
			-- LSP provides Neovim with features like:
			--  - Go to definition
			--  - Find references
			--  - Autocompletion
			--  - Symbol Search
			--  - and more!
			--
			-- Thus, Language Servers are external tools that must be installed separately from
			-- Neovim. This is where `mason` and related plugins come into play.
			--
			-- If you're wondering about lsp vs treesitter, you can check out the wonderfully
			-- and elegantly composed help section, `:help lsp-vs-treesitter`

			--  This function gets run when an LSP attaches to a particular buffer.
			--    That is to say, every time a new file is opened that is associated with
			--    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
			--    function will be executed to configure the current buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					-- NOTE: Remember that Lua is a real programming language, and as such it is possible
					-- to define small helper and utility functions so you don't have to repeat yourself.
					--
					-- In this case, we create a function that lets us more easily define mappings specific
					-- for LSP related items. It sets the mode, buffer and description for us each time.
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					-- Rename the variable under your cursor.
					--  Most Language Servers support renaming across files, etc.
					map("grn", vim.lsp.buf.rename, "[R]e[n]ame")

					-- Execute a code action, usually your cursor needs to be on top of an error
					-- or a suggestion from your LSP for this to activate.
					map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })

					-- Find references for the word under your cursor.
					map("grr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

					-- Jump to the implementation of the word under your cursor.
					--  Useful when your language has ways of declaring types without an actual implementation.
					map("gri", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

					-- Jump to the definition of the word under your cursor.
					--  This is where a variable was first declared, or where a function is defined, etc.
					--  To jump back, press <C-t>.
					map("grd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

					-- WARN: This is not Goto Definition, this is Goto Declaration.
					--  For example, in C this would take you to the header.
					map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

					-- Fuzzy find all the symbols in your current document.
					--  Symbols are things like variables, functions, types, etc.
					map("gO", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")

					-- Fuzzy find all the symbols in your current workspace.
					--  Similar to document symbols, except searches over your entire project.
					map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")

					-- Jump to the type of the word under your cursor.
					--  Useful when you're not sure what type a variable is and you want to see
					--  the definition of its *type*, not where it was *defined*.
					map("grt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")

					-- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
					---@param client vim.lsp.Client
					---@param method vim.lsp.protocol.Method
					---@param bufnr? integer some lsp support methods only in specific files
					---@return boolean
					local function client_supports_method(client, method, bufnr)
						if vim.fn.has("nvim-0.11") == 1 then
							return client:supports_method(method, bufnr)
						else
							return client.supports_method(method, { bufnr = bufnr })
						end
					end

					-- The following two autocommands are used to highlight references of the
					-- word under your cursor when your cursor rests there for a little while.
					--    See `:help CursorHold` for information about when this is executed
					--
					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if
						client
						and client_supports_method(
							client,
							vim.lsp.protocol.Methods.textDocument_documentHighlight,
							event.buf
						)
					then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
							end,
						})
					end

					-- The following code creates a keymap to toggle inlay hints in your
					-- code, if the language server you are using supports them
					--
					-- This may be unwanted, since they displace some of your code
					if
						client
						and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
					then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})

			-- Diagnostic Config
			-- See :help vim.diagnostic.Opts
			vim.diagnostic.config({
				severity_sort = true,
				float = { border = "rounded", source = "if_many" },
				underline = { severity = vim.diagnostic.severity.ERROR },
				signs = vim.g.have_nerd_font and {
					text = {
						[vim.diagnostic.severity.ERROR] = "󰅚 ",
						[vim.diagnostic.severity.WARN] = "󰀪 ",
						[vim.diagnostic.severity.INFO] = "󰋽 ",
						[vim.diagnostic.severity.HINT] = "󰌶 ",
					},
				} or {},
				virtual_text = {
					source = "if_many",
					spacing = 2,
					format = function(diagnostic)
						local diagnostic_message = {
							[vim.diagnostic.severity.ERROR] = diagnostic.message,
							[vim.diagnostic.severity.WARN] = diagnostic.message,
							[vim.diagnostic.severity.INFO] = diagnostic.message,
							[vim.diagnostic.severity.HINT] = diagnostic.message,
						}
						return diagnostic_message[diagnostic.severity]
					end,
				},
			})

			-- LSP servers and clients are able to communicate to each other what features they support.
			--  By default, Neovim doesn't support everything that is in the LSP specification.
			--  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
			--  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			-- Enable the following language servers
			--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
			--
			--  Add any additional override configuration in the following tables. Available keys are:
			--  - cmd (table): Override the default command used to start the server
			--  - filetypes (table): Override the default list of associated filetypes for the server
			--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
			--  - settings (table): Override the default settings passed when initializing the server.
			--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
			local servers = {
				clangd = {},
				gopls = {},
				pyright = {},
				-- rust_analyzer = {},
				-- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
				--
				-- Some languages (like typescript) have entire language plugins that can be useful:
				--    https://github.com/pmizio/typescript-tools.nvim
				--
				-- But for many setups, the LSP (`ts_ls`) will work just fine
				-- ts_ls = {},
				--

				lua_ls = {
					-- cmd = { ... },
					-- filetypes = { ... },
					-- capabilities = {},
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
							-- diagnostics = { disable = { 'missing-fields' } },
						},
					},
				},
			}

			-- Ensure the servers and tools above are installed
			--
			-- To check the current status of installed tools and/or manually install
			-- other tools, you can run
			--    :Mason
			--
			-- You can press `g?` for help in this menu.
			--
			-- `mason` had to be setup earlier: to configure its options see the
			-- `dependencies` table for `nvim-lspconfig` above.
			--
			-- You can add other tools here that you want Mason to install
			-- for you, so that they are available from within Neovim.
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua", -- Used to format Lua code
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
				automatic_installation = false,
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for ts_ls)
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},

	{ -- Autoformat
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				-- Disable "format_on_save lsp_fallback" for languages that don't
				-- have a well standardized coding style. You can add additional
				-- languages here or re-enable it for the disabled ones.
				local disable_filetypes = { c = true, cpp = true }
				if disable_filetypes[vim.bo[bufnr].filetype] then
					return nil
				else
					return {
						timeout_ms = 500,
						lsp_format = "fallback",
					}
				end
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform can also run multiple formatters sequentially
				-- python = { "isort", "black" },
				--
				-- You can use 'stop_after_first' to run the first available formatter from the list
				-- javascript = { "prettierd", "prettier", stop_after_first = true },
			},
		},
	},

	{ -- Autocompletion
		"saghen/blink.cmp",
		event = "VimEnter",
		version = "1.*",
		dependencies = {
			-- Snippet Engine
			{
				"L3MON4D3/LuaSnip",
				version = "2.*",
				build = (function()
					-- Build Step is needed for regex support in snippets.
					-- This step is not supported in many windows environments.
					-- Remove the below condition to re-enable on windows.
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
				dependencies = {
					-- `friendly-snippets` contains a variety of premade snippets.
					--    See the README about individual language/framework/plugin snippets:
					--    https://github.com/rafamadriz/friendly-snippets
					-- {
					--   'rafamadriz/friendly-snippets',
					--   config = function()
					--     require('luasnip.loaders.from_vscode').lazy_load()
					--   end,
					-- },
				},
				opts = {},
			},
			"folke/lazydev.nvim",
		},
		--- @module 'blink.cmp'
		--- @type blink.cmp.Config
		opts = {
			keymap = {
				-- 'default' (recommended) for mappings similar to built-in completions
				--   <c-y> to accept ([y]es) the completion.
				--    This will auto-import if your LSP supports it.
				--    This will expand snippets if the LSP sent a snippet.
				-- 'super-tab' for tab to accept
				-- 'enter' for enter to accept
				-- 'none' for no mappings
				--
				-- For an understanding of why the 'default' preset is recommended,
				-- you will need to read `:help ins-completion`
				--
				-- No, but seriously. Please read `:help ins-completion`, it is really good!
				--
				-- All presets have the following mappings:
				-- <tab>/<s-tab>: move to right/left of your snippet expansion
				-- <c-space>: Open menu or open docs if already open
				-- <c-n>/<c-p> or <up>/<down>: Select next/previous item
				-- <c-e>: Hide menu
				-- <c-k>: Toggle signature help
				--
				-- See :h blink-cmp-config-keymap for defining your own keymap
				preset = "default",

				-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
				--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
			},

			appearance = {
				-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",
			},

			completion = {
				-- By default, you may press `<c-space>` to show the documentation.
				-- Optionally, set `auto_show = true` to show the documentation after a delay.
				documentation = { auto_show = false, auto_show_delay_ms = 500 },
			},

			sources = {
				default = { "lsp", "path", "snippets", "lazydev" },
				providers = {
					lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
				},
			},

			snippets = { preset = "luasnip" },

			-- Blink.cmp includes an optional, recommended rust fuzzy matcher,
			-- which automatically downloads a prebuilt binary when enabled.
			--
			-- By default, we use the Lua implementation instead, but you may enable
			-- the rust implementation via `'prefer_rust_with_warning'`
			--
			-- See :h blink-cmp-config-fuzzy for more information
			fuzzy = { implementation = "lua" },

			-- Shows a signature help window while you type arguments for a function
			signature = { enabled = true },
		},
	},

	{ -- You can easily change to a different colorscheme.
		-- Change the name of the colorscheme plugin below, and then
		-- change the command in the config to whatever the name of that colorscheme is.
		--
		-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
		"folke/tokyonight.nvim",
		priority = 1000, -- Make sure to load this before all the other start plugins.
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("tokyonight").setup({
				styles = {
					comments = { italic = false }, -- Disable italics in comments
				},
			})

			-- Load the colorscheme here.
			-- Like many other themes, this one has different styles, and you could load
			-- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
			vim.cmd.colorscheme("tokyonight-night")
		end,
	},

	-- Highlight todo, notes, etc in comments
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},

	{ -- Collection of various small independent plugins/modules
		"echasnovski/mini.nvim",
		config = function()
			-- Better Around/Inside textobjects
			--
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
			--  - ci'  - [C]hange [I]nside [']quote
			require("mini.ai").setup({ n_lines = 500 })

			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			--
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			require("mini.surround").setup()

			-- Simple and easy statusline.
			--  You could remove this setup call if you don't like it,
			--  and try some other statusline plugin
			local statusline = require("mini.statusline")
			-- set use_icons to true if you have a Nerd Font
			statusline.setup({ use_icons = vim.g.have_nerd_font })

			-- You can configure sections in the statusline by overriding their
			-- default behavior. For example, here we set the section for
			-- cursor location to LINE:COLUMN
			---@diagnostic disable-next-line: duplicate-set-field
			statusline.section_location = function()
				return "%2l:%-2v"
			end

			-- ... and there is more!
			--  Check out: https://github.com/echasnovski/mini.nvim
		end,
	},
	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		--		main = "nvim-treesitter.configs", -- Sets main module to use for opts
		-- [[ Configure Treesitter ]] See `:help nvim-treesitter`
		opts = {
			ensure_installed = {
				"bash",
				"c",
				"diff",
				"html",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"query",
				"vim",
				"vimdoc",
			},
			-- Autoinstall languages that are not installed
			auto_install = true,
			highlight = {
				enable = true,
				-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
				--  If you are experiencing weird indenting issues, add the language to
				--  the list of additional_vim_regex_highlighting and disabled languages for indent.
				additional_vim_regex_highlighting = { "ruby" },
			},
			indent = { enable = true, disable = { "ruby" } },
		},
		-- There are additional nvim-treesitter modules that you can use to interact
		-- with nvim-treesitter. You should go explore a few and see what interests you:
		--
		--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
		--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
		--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
	},

	-- autopairs.lua
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
}, {
	ui = {
		-- If you are using a Nerd Font: set icons to an empty table which will use the
		-- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})

-- Markdown ファイルを正しく認識させる設定
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.md",
	command = "set filetype=markdown",
})

-- switch.vim: 単語の切り替え設定
-- AndrewRadev/switch.vim プラグインが必要です
vim.g.switch_definitions = {
	{
		["YES"] = "NO",
		["NO"] = "YES",
	},
}
-- 「+」キーの割り当て (Vim関数をLuaから呼び出す安全な方法)
vim.keymap.set("n", "+", function()
	-- Vimscriptの関数 switch#Switch を直接呼び出す
	vim.fn["switch#Switch"](vim.g.variable_style_switch_definitions)
end, { silent = true, desc = "Custom Word Switch" })

-- 「-」キーの割り当て (標準の切り替え)
vim.keymap.set("n", "-", "<cmd>Switch<cr>", { silent = true, desc = "Default Switch" })

-- lua/custom/keymaps.lua に追加
-- Ctrl+e でファイルツリーをトグル（開閉）
vim.keymap.set("n", "<C-e>", "<cmd>Neotree toggle<cr>", { desc = "Toggle File Tree" })

-- open-browser.vim: gx でURLを開く
-- tyru/open-browser.vim プラグインが必要です
vim.g.netrw_nogx = 1 -- 標準のgxを無効化
vim.keymap.set("n", "gx", "<Plug>(openbrowser-smart-search)", { desc = "Open URL or Search" })
vim.keymap.set("v", "gx", "<Plug>(openbrowser-smart-search)", { desc = "Open URL or Search" })

-- Undotree: 編集履歴をビジュアル表示
-- mbbill/undotree プラグインが必要です
vim.g.undotree_WindowLayout = "topleft"
vim.g.undotree_SplitWidth = 35
vim.g.undotree_SetFocusWhenToggle = 1

-- リーダーキー + u で履歴ツリーを表示
vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<cr>", { desc = "Toggle Undotree" })

-- yanky.nvim を使う場合の Telescope 連携例
-- lua/custom/keymaps.lua
-- スペース + y でコピー履歴を一覧表示
vim.keymap.set("n", "<leader>y", "<cmd>Telescope yank_history<cr>", { desc = "Show Yank History" })

-- インデントガイドの設定 (indent-blankline.nvim を使用)
-- 起動時は表示せず、手動でトグルできるように設定
vim.g.indent_guides_enable_on_vim_startup = 0

-- Doxygenなどのドキュメント作成用
vim.opt.filetype = "on"

-- =============================================================================
-- 強力な置換マッピング (vim-overのロジックをネイティブ置換に移植)
-- =============================================================================

-- <leader>m: 置換コマンドラインを素早く呼び出す
vim.keymap.set("n", "<leader>m", ":%s/", { desc = "Substitution" })

-- sub: カーソル下の単語をファイル全体で置換
-- ※ Neovimの inccommand = "split" により、入力中にリアルタイムで置換結果が見えます
vim.keymap.set("n", "sub", ":%s/<C-r><C-w>//g<Left><Left>", { desc = "Replace word under cursor" })

-- subp: コピー（ヤンク）した文字列をファイル全体で置換 (特殊文字のエスケープ処理付き)
vim.keymap.set("n", "subp", function()
	local yanked = vim.fn.getreg('"')
	-- 特殊文字 ! をエスケープする kurenaifさん流の賢い処理
	local escaped = yanked:gsub("!", "\\!")
	vim.api.nvim_feedkeys(":%s!" .. escaped .. "!!gI" .. string.rep("<Left>", 3), "n", false)
end, { desc = "Replace yanked text" })

-- =============================================================================
-- コメントアウト (caw.vim の操作感を継承)
-- =============================================================================
-- Kickstartの mini.comment / Comment.nvim を kurenaifさんのキー <leader>c に割り当て
vim.keymap.set({ "n", "v" }, "<leader>c", "gc", { remap = true, desc = "Toggle comment" })

-- =============================================================================
-- 差分移動 (Signify -> gitsigns)
-- =============================================================================
-- <leader>gj / gk で変更箇所をジャンプする kurenaifさん流のキー
vim.keymap.set("n", "<leader>gj", "<cmd>Gitsigns next_hunk<CR>zz", { desc = "Next Git hunk" })
vim.keymap.set("n", "<leader>gk", "<cmd>Gitsigns prev_hunk<CR>zz", { desc = "Prev Git hunk" })
