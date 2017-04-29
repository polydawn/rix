#!/bin/bash
set -euo pipefail
cd "$( dirname "${BASH_SOURCE[0]}" )"

[[ ! -d "wares" ]] && {
	>&2 echo "You must make a 'wares' directory, for storage of intermediates."
	>&2 echo "We recommand making it under some other filesystem, for convenience, like this:"
	>&2 echo "  mkdir /tmp/rix-wares && ln -s /tmp/rix-wares/ wares"
	exit 5
}

reppl init
