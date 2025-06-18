{pkgs, ...}: let
	yazi-plugins = pkgs.fetchFromGitHub {
		owner = "yazi-rs";
		repo = "plugins";
    rev = "63f9650e522336e0010261dcd0ffb0bf114cf912";
    hash = "sha256-ZCLJ6BjMAj64/zM606qxnmzl2la4dvO/F5QFicBEYfU=";
	};
in {
	programs.yazi = {
		enable = true;
		enableZshIntegration = true;
		shellWrapperName = "y";

		settings = {
			manager = {
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
			bookmarks = "${yazi-plugins}/bookmarks";
		};

		initLua = ''
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
			];
		};
	};
}
