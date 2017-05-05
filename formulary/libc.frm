inputs:
	"/":           {tag: "base-builder"}
	"/app/gawk":   {tag: "gawk"}
	"/src/glibc":  {tag: "glibc-src"}
action:
	command:
		- "/bin/bash"
		- "-c"
		- |
			#!/bin/bash
			set -euo pipefail
			export PATH=/app/gawk/bin/:$PATH

			configureOpts=()
			configureOpts+=("--prefix=/task/output")
			time /src/glibc/*/configure "${configureOpts[@]}" || cat config.log
			echo ---
			time make
			echo ---
			time make install
			echo ---
			find ./output -type f | xargs ls -lah
outputs:
	"/task/output/dynamic":
		tag: "libc-shared"
		type: "tar"
		silo: "file+ca://./wares/"
	"/task/output/static":
		tag: "libc-static"
		type: "tar"
		silo: "file+ca://./wares/"
