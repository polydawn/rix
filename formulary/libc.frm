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

			#find /src/gettext # does not actually contain a .h until after you "build" which requires autotools and a million miles of pain
			#cat  /usr/include/libintl.h
			#exit

			cp /src/glibc/*/* . -R
			mkdir build; cd build
			#find / -name libintl.h 2>/dev/null
			#exit
			#echo -----
			#find /task/include
			#echo -----
			#find  /include/kernel/include/
			#echo -----cping...
			#mkdir /tmp/include
			#cp -a /task/include/* /tmp/include
			#cp -a /include/kernel/include/* /tmp/include/
			#find /task/include
			#find /tmp/include -name libintl.h
			#echo -----
			#exit

			#export NO_GETTEXT=1 # doesn't matter
			configureOpts=()
			configureOpts+=("--prefix=/task/output")
			configureOpts+=("--enable-kernel=2.6.32")
			configureOpts+=("--with-headers=/include/kernel/include/")
			#configureOpts+=("--with-headers=/task/include/")
			#configureOpts+=("--with-headers=/tmp/include/")
			configureOpts+=("--host=x86_64-pc-linux-gnu") # i honestly have no idea what this string is for.
			configureOpts+=("--build=x86_64-rix-linux-gnu") # you can get this by also running `/src/glibc/*/scripts/config.guess` if you like.
			#configureOpts+=("--disable-nls") # avoid gettext dependency 'libintl.h' complaint. # this doesn't... work... for some reason
			#configureOpts+=("--with-clocale=generic") # prayers # doesn't matter
			time ../configure "${configureOpts[@]}" || cat config.log
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
