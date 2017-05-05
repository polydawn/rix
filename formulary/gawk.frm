inputs:
	"/":      {tag: "base-builder"}
	"/task":  {tag: "gawk-src"}
action:
	command:
		- "/bin/bash"
		- "-c"
		- |
			#!/bin/bash
			set -euo pipefail

			cd *
			configureOpts=()
			configureOpts+=("--prefix=/task/output")
			time ./configure "${configureOpts[@]}" || cat config.log
			echo ---
			time make
			echo ---
			time make install
			echo ---
			find /task/output -type f | xargs ls -lah
outputs:
	"/task/output/bin":
		tag: "gawk"
		type: "tar"
		silo: "file+ca://./wares/"
