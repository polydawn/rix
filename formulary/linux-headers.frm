## Unpack kernel headers.
##  http://www.linuxfromscratch.org/lfs/view/stable/chapter05/linux-headers.html
inputs:
	"/":            {tag: "base-builder"}
	"/src/kernel":  {tag: "kernel-src"}
action:
	command:
		- "/bin/bash"
		- "-c"
		- |
			set -euo pipefail

			cp /src/kernel/*/* . -R
			make mrproper
			make INSTALL_HDR_PATH=/task/output/include headers_install
			find /task/output ! -type d | xargs ls -lah
outputs:
	"/task/output/include":
		tag: "linux-headers"
		type: "tar"
		silo: "file+ca://./wares/"
