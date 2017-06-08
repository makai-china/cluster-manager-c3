AC_INIT(src/cexec)

dnl ========= Get the actual C3 version from the VERSION file ========
VERSION=`./dist/get-version.sh ./VERSION --full`
VERSION_MAJOR=`./dist/get-version.sh ./VERSION --major`

AM_INIT_AUTOMAKE(c3,$VERSION)

dnl ================== Check if python is installed ==================

AM_PATH_PYTHON([2.4])

dnl ==================================================================

AC_OUTPUT(Makefile)

dnl ============ Update the C3 version in the Python code ============
echo "# This file has been automatically generated, do not modify" \
    > src/c3_version.py
echo "c3_version=\"$VERSION\"" >> src/c3_version.py
echo "c3_version_major=\"$VERSION_MAJOR\"" >> src/c3_version.py

dnl ============ Generate top-level C3-VERSION file ==================
echo "$VERSION" > "C3-VERSION"

dnl ============ Substitution into related .in file(s) ===============
C3_VERSION="$VERSION"
AC_SUBST(C3_VERSION)

AC_CONFIG_FILES([src/ckillnode], [chmod +x src/ckillnode])
AC_CONFIG_FILES([rpm/c3.spec],   [chmod +r rpm/c3.spec])
AC_OUTPUT

