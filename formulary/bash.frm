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
			time make
			echo ---
			time make install
			echo ---
			find ./output -type f | xargs ls -lah
outputs:
	"bash":
		tag: "bash"
		type: "tar"
		mount: "/task/output"
		silo: "file+ca://./wares/"
