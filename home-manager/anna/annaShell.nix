{  config, pkgs, ...}:
let
  gcloudOrNot = false; # TODO figure out condition for this
  bashExtra = ''
	eval "$(direnv hook bash)"
	'';
	zshExtra = ''
	eval "$(direnv hook zsh)" # makes direnv work
	'';
	shellExtra =  ''
		pathappend() {
			for ARG in "$@"
			do
				if [ -d "$ARG" ] && [[ ":$PATH:" != *":$ARG:"* ]]; then
					PATH="${"$PATH:"}$ARG"
				fi
			done
		}
		pathprepend() {
			for ARG in "$@"
			do
				if [ -d "$ARG" ] && [[ ":$PATH:" != *":$ARG:"* ]]; then
					PATH="$ARG${":$PATH"}"
				fi
			done
		}	# END FUNCTION
		alias ipy="type ipy && \
		nix-shell -p 'python3.withPackages (python-pkgs: with python-pkgs; [
						ipython
						matplotlib
						scipy
						scikit-learn
            pandas
            numpy
						requests
						pysocks
        ])' --run ipython"

		alias crontab-reboot-test="sudo rm /var/run/crond.reboot && sudo service cron restart"
		alias code=codium
		# click kill thing
		alias xkill="nix-shell -p xorg.xkill --run xkill"
		alias mkill="nix-shell -p xorg.xkill --run xkill"
		alias mousekill="nix-shell -p xorg.xkill --run xkill"
	
		# END ALIASES
		'';
		

in
{
	# BEGIN BASH
	programs.bash ={
		enable=true;
		historyControl = ["ignoredups"];
	}; # END BASH
	# BEGIN ZSH
	programs.zsh = {
		enable = true;
		enableAutosuggestions = true;
		syntaxHighlighting.enable = true;
		oh-my-zsh={
			enable = true;
			# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git
			# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/sudo
			# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/systemd
			# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/python
			plugins = [ "git" "sudo" "systemd" "python"];  # a bunch of aliases and a few functions
			theme = "agnoster";  # https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
			};
		initExtra = zshExtra + shellExtra;
	}; # END ZSH
}