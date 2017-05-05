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
			configureOpts+=("--prefix=/task/build")
			export CFLAGS="-static"
			time ./configure "${configureOpts[@]}" || cat config.log
			echo ---
			time make
			echo ---
			time make install
			echo ---
			find /task/build ! -type d | xargs ls -lah
			echo ---
			### Now we re-arrange some files for our own packaging idioms
			mkdir /task/output
			mkdir /task/output/ship
			mv /task/build/bin /task/output/ship
outputs:
	"/task/output/ship":
		tag: "gawk"
		type: "tar"
		silo: "file+ca://./wares/"
