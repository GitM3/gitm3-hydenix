{pkgs, ...}: let
	yazi-plugins = pkgs.fetchFromGitHub {
	owner = "yazi-rs";
	repo = "plugins";
	rev = "63f9650e522336e0010261dcd0ffb0bf114cf912";
	hash = "sha256-ZCLJ6BjMAj64/zM606qxnmzl2la4dvO/F5QFicBEYfU=";
	};
	yazi-bookmark = pkgs.fetchFromGitHub {
	  owner="dedukun";
	  repo="bookmarks.yazi";
	  rev="9ef1254d8afe88aba21cd56a186f4485dd532ab8";
	  hash="sha256-GQFBRB2aQqmmuKZ0BpcCAC4r0JFKqIANZNhUC98SlwY=";
	};
in {
	programs.yazi = {
		enable = true;
		enableZshIntegration = true;
		shellWrapperName = "y";

		settings = {
			mgr = {
				show_hidden = true;
			};
			preview = {
				max_width = 1000;
				max_height = 1000;
			};
		};

		plugins = {
			chmod = "${yazi-plugins}/chmod.yazi";
			diff = "${yazi-plugins}/diff.yazi";
			git = "${yazi-plugins}/git.yazi";
			toggle-pane = "${yazi-plugins}/toggle-pane.yazi";
			bookmarks   = "${yazi-bookmark}";
		};

		initLua = ''
			require("bookmarks"):setup({
			last_directory = { enable = true, persist = false, mode="jump" },
			persist = "vim", --Capital letters are saved persistently.
			desc_format = "full",
			file_pick_mode = "parent",
			custom_desc_input = false,
			show_keys = true,
			notify = {
				enable = true,
				timeout = 1,
				message = {
					new = "New bookmark '<key>' -> '<folder>'",
					delete = "Deleted bookmark in '<key>'",
					delete_all = "Deleted all bookmarks",
					},
				},
			})
			'';
		keymap = {
			mgr.prepend_keymap = [
				{
					on = "T";
					run = "plugin toggle-pane max-preview";
					desc = "Maximize or restore the preview pane";
				}
				{
					on = ["c" "d"];
					run = "plugin diff";
					desc = "Diff selected file with hovered file";
				}
				{
					on = ["c" "m"];
					run = "plugin chmod";
					desc = "Chmod on selected files";
				}
				{
				on = [ "m" ];
				run = "plugin bookmarks save";
				desc = "Save current position as a bookmark";
				}
				{
				on = [ "'" ];
				run = "plugin bookmarks jump";
				desc = "Jump to a bookmark";
				}
				{
				on = [ "b" "d" ];
				run = "plugin bookmarks delete";
				desc = "Delete a bookmark";
				}
				{
				on = [ "b" "D" ];
				run = "plugin bookmarks delete_all";
				desc = "Delete all bookmarks";
				}
			];
		};
	};
}
