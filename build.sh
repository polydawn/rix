#!/bin/bash
set -euo pipefail
cd "$( dirname "${BASH_SOURCE[0]}" )"

[[ ! -d "wares" ]] && {
	>&2 echo "You must make a 'wares' directory, for storage of intermediates."
	>&2 echo "We recommand making it under some other filesystem, for convenience, like this:"
	>&2 echo "  mkdir /tmp/rix-wares && ln -s /tmp/rix-wares/ wares"
	exit 5
}

reppl init

### Blessed artifacts from outer space.
{
	# A snapshot of a fairly minimal ubuntu image.  Libc, bash, etc.  No build tools.
	reppl put hash  base-foreign  aLMH4qK1EdlPDavdhErOs0BPxqO0i6lUaeRE4DuUmnNMxhHtF56gkoeSulvwWNqT  --warehouse="http+ca://repeatr.s3.amazonaws.com/assets/"
	# A snapshot of an image with a C compiler.  This one happens to have musl libc as well.
	reppl put hash  base-builder  FZLEqXTEPMCW9fey40kmwrLFsRV0sLUzq9tolC1AwxXcXPnXHyihkBR2no38Eo9L  --warehouse="file+ca://../formulary/formulas/rhone/wares/"
}

### Let's build bash!
reppl put hash  bash-src  L-hQ2kqY4HbmS18RV06JsYXnCv27DbeC3yZt_ol4mIjb6txuqi7_QniYKxfqVnk2  --warehouse="http://ftp.gnu.org/gnu/bash/bash-4.4.tar.gz"
reppl eval formulary/bash.frm

