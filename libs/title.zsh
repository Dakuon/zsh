# Window Title
#--------------------

# Percent encode
function pct_encode {
	# Collect all arguments into a single string.
	local input="$(echo $@)"

	# Process the input byte-by-byte.
	local LC_ALL=C

	# Percent encode the input.
	local output=''
	local i ch hexch
	for i in {1..${#input}}; do
		ch="${input[i]}"
		if [[ "${ch}" =~ [/._~A-Za-z0-9-] ]]; then
			output+="${ch}"
		else
			hexch=$(printf "%02X" "'${ch}")
			output+="%${hexch}"
		fi
	done
	echo "${output}"
}

# Get the pwd as a `file://` URL, including the hostname.
function pwurl {
	echo "file://${HOST}$(pct_encode ${PWD})"
}

# Present working directory as a `file://` URL.
# This is updated by the chpwd hook.
export PWURL=$(pwurl)

# Sets the title to whatever is passed as $1
function set-term-title {
	# Escape the argument for printf formatting.
	local title=$1
	title=${title//\\/\\\\}
	title=${title//\"/\\\"}
	title=${title//\%/\%\%}

	# OSC 0, 1, and 2 are the portable escape codes for setting window titles.
	printf "\e]0;$title\a"  # Both tab and window
	printf "\e]1;$title\a"  # Tab title
	printf "\e]2;$title\a"  # Window title

	# OSC 6 and 7 are used on macOS to advertise host and pwd.
	# These codes may foobar other terminals on Linux, like gnome-terminal.
	if [[ ${TERM_PROGRAM} == 'Apple_Terminal' || ${TERM_PROGRAM} == 'iTerm.app' ]]; then
		print -n "\e]6;${PWURL}\a"  # Current document as a URL (Terminal.app)
		print -n "\e]7;${PWURL}\a"  # PWD as a URL (Terminal.app and iTerm2)
	fi

	# Also set window name in tmux.
	if [[ ${TMUX} ]]; then
		tmux rename-window $title
	fi
}

# At the prompt, we set the title to "$HOST : $PWD".
function precmd-title {
	set-term-title "$(print -P %n@%m: %~)"
}

# When running a command, set the title to "$HOST : $COMMAND"
function preexec-title {
	set-term-title "$(print -P '%n@%m: $1')"
}

# Update PWURL whenever we change PWD
function chpwd-chpwurl {
	export PWURL=$(pwurl)
}

# Setup the hooks
autoload add-zsh-hook
add-zsh-hook precmd precmd-title
add-zsh-hook preexec preexec-title
add-zsh-hook chpwd chpwd-chpwurl
