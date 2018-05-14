# Forward all arguments to app
set OLD_PATH="$PATH"
set PATH="{{ latest_dir }}/bin:$OLD_PATH"

{{ latest_dir }}\bin\construct.sh "$@"

set PATH="$OLD_PATH"
unset OLD_PATH
