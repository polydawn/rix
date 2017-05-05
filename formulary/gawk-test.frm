inputs:
	"/":          {tag: "base-foreign"}
	"/app/gawk":  {tag: "gawk"}
action:
	command:
		- "/bin/bash"
		- "-c"
		- |
			#!/bin/bash
			set -euo pipefail
			set -x

			find /app/gawk -type d | xargs ls -lah
			ldd /app/gawk/bin/gawk
			/app/gawk/bin/gawk -h
