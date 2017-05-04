inputs:
	"/":          {tag: "base-builder"}
	"/src/bash":  {tag: "bash-src"}
action:
	command:
		- "/bin/bash"
		- "-c"
		- |
			#!/bin/bash
			set -euo pipefail

			cp /src/bash/*/* . -R
			configureOpts=()
			configureOpts+=("--prefix=/task/output")
			configureOpts+=("--without-bash-malloc") # bash ships a malloc that is reportedly buggy accoridng to LFS docs.
			time ./configure "${configureOpts[@]}"
			echo ---
			src="$(find)"
			time make
			echo ---
			diff -U 0 -- <(echo "$src") <(find) | grep -v "^@@"
outputs:
	"bash":
		tag: "bash"
		type: "tar"
		mount: "/task/output"
		silo: "file+ca://./wares/"
