#!/bin/sh
#
# Copyright (c) 2004-2005 The Trustees of Indiana University and Indiana
#                         University Research and Technology
#                         Corporation.  All rights reserved.
# Copyright (c) 2004-2005 The University of Tennessee and The University
#                         of Tennessee Research Foundation.  All rights
#                         reserved.
# Copyright (c) 2004-2005 High Performance Computing Center Stuttgart, 
#                         University of Stuttgart.  All rights reserved.
# Copyright (c) 2004-2005 The Regents of the University of California.
#                         All rights reserved.
# Copyright (c) 2007	  Oak Ridge National Laboratory.  All rights reserved.
# $COPYRIGHT$
# 
# Additional copyrights may follow
# 
# $HEADER$
#
# TJN: (25jan2011) Adjust to always return at least 3 octets (a.b.c),
#                  even if the 'c' (release) value is zero.
#

srcfile="$1"
option="$2"

case "$option" in
    # svnversion can take a while to run.  If we don't need it, don't run it.
    --major|--minor|--release|--greek|--base|--help)
        C3_NEED_SVN=0
        ;;
    --nightly|*)
        C3_NEED_SVN=1
esac


if test "$srcfile" = ""; then
    option="--help"
else
    C3_MAJOR_VERSION="`cat $srcfile | egrep '^major=' | cut -d= -f2`"
    C3_MINOR_VERSION="`cat $srcfile | egrep '^minor=' | cut -d= -f2`"
    C3_RELEASE_VERSION="`cat $srcfile | egrep '^release=' | cut -d= -f2`"
    C3_GREEK_VERSION="`cat $srcfile | egrep '^greek=' | cut -d= -f2`"
    C3_WANT_SVN="`cat $srcfile | egrep '^want_svn=' | cut -d= -f2`"
    C3_SVN_R="`cat $srcfile | egrep '^svn_r=' | cut -d= -f2`"

	C3_VERSION="$C3_MAJOR_VERSION.$C3_MINOR_VERSION.$C3_RELEASE_VERSION"
	C3_SVN_TAG="c3-$C3_MAJOR_VERSION-$C3_MINOR_VERSION-$C3_RELEASE_VERSION"

    C3_VERSION="${C3_VERSION}${C3_GREEK_VERSION}"

    if test "$C3_GREEK_VERSION" != "0" -a "$C3_GREEK_VERSION" != ""; then
		#
		# XXX: we need tildes "~" in Debian versioning schemes 
		#      for the alpha/beta (greek) field.  For the tags
		#      we'll prune those tildes out to keep svn-tags clean.
		#
		C3_GREEK_VERSION_NOTILDE=`echo $C3_GREEK_VERSION | tr -d -- '~'`
        C3_SVN_TAG="$C3_SVN_TAG-$C3_GREEK_VERSION_NOTILDE"
    fi

    C3_BASE_VERSION="$C3_VERSION"

    C3_DATE=`date '+%Y%m%d'`

    if test "$C3_WANT_SVN" = "1" -a "$C3_NEED_SVN" = "1" ; then
        if test "$C3_SVN_R" = "-1"; then
            if test -d .svn; then
                ver="r`svnversion .`"
            else
                ver="svn`date '+%m%d%Y'`"
            fi
            C3_SVN_R="$ver"
        fi
	C3_VERSION="${C3_VERSION}$C3_SVN_R"
    fi

    if test "$option" = ""; then
	option="--full"
    fi
fi

case "$option" in
    --full|-v|--version)
	echo $C3_VERSION
	;;
    --major)
	echo $C3_MAJOR_VERSION
	;;
    --minor)
	echo $C3_MINOR_VERSION
	;;
    --release)
	echo $C3_RELEASE_VERSION
	;;
    --greek)
	echo $C3_GREEK_VERSION
	;;
    --svn)
	echo $C3_SVN_R
	;;
    --svn-tag)
	echo ${C3_SVN_TAG}
	;;
    --base)
        echo $C3_BASE_VERSION
        ;;
    --all)
        echo ${C3_VERSION} ${C3_MAJOR_VERSION} ${C3_MINOR_VERSION} ${C3_RELEASE_VERSION} ${C3_GREEK_VERSION} ${C3_SVN_R}
        ;;
    --nightly)
	echo ${C3_VERSION}nightly-${C3_DATE}
	;;
    -h|--help)
	cat <<EOF
$0 <srcfile> [<option>]

<srcfile> - Text version file
<option>  - One of:
    --full    - Full version number
    --major   - Major version number
    --minor   - Minor version number
    --release - Release version number
    --greek   - Greek (alpha, beta, etc) version number
    --svn     - Subversion repository number
    --svn-tag - Subversion tagging string (C3 release tags)
    --all     - Show all version numbers, separated by :
    --base    - Show base version number (no svn number)
    --nightly - Return the version number for nightly tarballs
    --help    - This message
EOF
        ;;
    *)
        echo "Unrecognized option $option.  Run $0 --help for options"
        ;;
esac

# All done

exit 0
