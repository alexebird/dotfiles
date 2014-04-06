# copied from https://raw2.github.com/fish-shell/fish-shell/master/share/functions/fish_prompt.fish

# Set the default prompt command. Make sure that every terminal escape
# string has a newline before and after, so that fish will know how
# long it is.

function fish_prompt --description "Write out the prompt"

	# Just calculate these once, to save a few cycles when displaying the prompt
	if not set -q __fish_prompt_hostname
		set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
	end

	if not set -q __fish_prompt_normal
		set -g __fish_prompt_normal (set_color normal)
	end

	switch $USER

		case root

		if not set -q __fish_prompt_cwd
			if set -q fish_color_cwd_root
				set -g __fish_prompt_cwd (set_color $fish_color_cwd_root)
			else
				set -g __fish_prompt_cwd (set_color $fish_color_cwd)
			end
		end

		echo -n -s "$USER" @ "$__fish_prompt_hostname" ' ' "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" '# '

		case '*'

		if not set -q __fish_prompt_cwd
			set -g __fish_prompt_cwd (set_color $fish_color_cwd)
		end

		#if test -f ./Gemfile
			set -l __ruby_version ' '(set_color yellow)(ruby -v | awk '{ print $1, $2 }' | sed 's/ /-/')' '
		#else
			#set -g __ruby_version ' 'hi' '
		#end

		#echo (set_color yellow)"$__ruby_version"
		echo -n -s (set_color cyan) "$USER" @ "$__fish_prompt_hostname" "$__ruby_version" "$__fish_prompt_normal"  "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" '> '

	end
end

