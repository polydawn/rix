inputs:
	"/":             {tag: "base-builder"}
	"/src/gettext":  {tag: "gettext-src"}
action:
	command:
		- "/bin/bash"
		- "-c"
		- |
			#!/bin/bash
			set -euo pipefail

			cp /src/gettext/*/* . -R
			configureOpts=()
			configureOpts+=("--prefix=/task/build")
			time ./configure "${configureOpts[@]}" || cat config.log
			echo ---
			time make
			echo ---
			time make install
			echo ---
			find /task/build ! -type d | xargs ls -lah
