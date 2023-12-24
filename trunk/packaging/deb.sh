PACKAGE="srs-server"
VERSION="$1"

# We can only build Debian packages, if the Debian build tools are installed
if [ \! -x /usr/bin/debuild ]; then
  echo "Cannot find /usr/bin/debuild. Not building Debian packages." 1>&2
  exit 0
fi

# Double-check we're in the packages directory, just under rootdir
if [ \! -x ./configure ]; then
  echo "Must run $0 in the 'trunk' directory, under the root directory." 1>&2
  exit 0
fi


# make tar.gz
rm -rf tmp
rm -f "${PACKAGE}_${VERSION}.tar.gz"
tar -czvf "${PACKAGE}_${VERSION}.tar.gz" *


# trap 'rm -rf '`pwd`/tmp'; exit $?' EXIT SIGHUP SIGINT SIGTERM

rm -rf tmp
mkdir -p tmp/trunk
cd tmp

ln -s ../"${PACKAGE}_${VERSION}.tar.gz" "${PACKAGE}_${VERSION}+dfsg.1.orig.tar.gz"
tar -xzvf "../${PACKAGE}_${VERSION}.tar.gz" -C trunk
cd trunk

# Debian has very specific requirements about the naming of build directories
cp -a "packaging/deb" "debian"

# Now, we can call Debian's standard build tool
debuild

echo
echo "The Debian package build finished."
