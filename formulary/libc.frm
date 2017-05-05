inputs:
	"/":                {tag: "base-builder"}
	"/app/gawk":        {tag: "gawk"}
	"/include/kernel":  {tag: "linux-headers"}
	"/src/glibc":       {tag: "glibc-src"}
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
			configureOpts+=("--enable-kernel=2.6.32")
			configureOpts+=("--with-headers=/include/kernel/include/")
			#configureOpts+=("--host=x86_64-rix-linux-gnu")
			configureOpts+=("--build=x86_64-pc-linux-gnu") # you can get this by also running `/src/glibc/*/scripts/config.guess` if you like.
			time /src/glibc/*/configure "${configureOpts[@]}" || cat config.log
			echo ---
			export MAKEFLAGS="-j 8"
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
