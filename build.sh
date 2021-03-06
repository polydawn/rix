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
	reppl put hash  base-builder  QwPzkwQ88XokZt-KL-Qv88E1KqfxdukxDpxN2I5H3dnaoq5IAXY6DfzIzUQkT7WN  --warehouse="http+ca://repeatr.s3.amazonaws.com/assets/"
}

### Let's build bash!
reppl put hash  gawk-src  tUZmN1IEoZ_jVSZDv-2pDRQHneW2NqccCsWkyL88q0Cn-btLcTMvlS9WfNhmpgUO  --warehouse="http://ftp.gnu.org/gnu/gawk/gawk-4.1.4.tar.xz"
reppl eval formulary/gawk.frm
reppl eval formulary/gawk-test.frm
reppl put hash  kernel-src  oQ-G18xgeR0mXhb2pu7VieCt_cBUsQOpqewpRTE8pnimFZygKsOaA7qNJzWaL-Oa  --warehouse="https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.9.tar.xz"
reppl eval formulary/linux-headers.frm
reppl put hash  glibc-src  eSqmNRsnFdVR-AYY4e_BdIxI7Vs7iwLkoAREm8O1BPiVqn_fPd-fDTP_kwsHPpgY  --warehouse="http://ftp.gnu.org/gnu/glibc/glibc-2.25.tar.xz"
reppl eval formulary/libc.frm
exit
reppl put hash  bash-src  L-hQ2kqY4HbmS18RV06JsYXnCv27DbeC3yZt_ol4mIjb6txuqi7_QniYKxfqVnk2  --warehouse="http://ftp.gnu.org/gnu/bash/bash-4.4.tar.gz"
reppl eval formulary/bash.frm

