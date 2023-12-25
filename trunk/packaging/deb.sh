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

# trap 'rm -rf '`pwd`/tmp'; exit $?' EXIT SIGHUP SIGINT SIGTERM
mkdir -p tmp/trunk
cp -a ./* tmp/trunk/
# find tmp/trunk/3rdparty -type d \( -name st-srs -o -name signaling \) -prune -o -exec rm -rf {} +
rm -r tmp/trunk/3rdparty/ffmpeg-4-fit
rm -r tmp/trunk/3rdparty/gperftool-2-fit
rm -r tmp/trunk/3rdparty/gprof
rm -r tmp/trunk/3rdparty/gtest-fit
rm -r tmp/trunk/3rdparty/httpx-static
rm -r tmp/trunk/3rdparty/libsrtp-2-fit
rm -r tmp/trunk/3rdparty/openssl-1.1-fit
rm -r tmp/trunk/3rdparty/patches
rm -r tmp/trunk/3rdparty/srs-bench
rm -r tmp/trunk/3rdparty/srt-1-fit
rm -r tmp/trunk/3rdparty/openssl-OpenSSL_1_0_2u.tar.gz
rm -r tmp/trunk/3rdparty/opus-1.3.1.tar.gz

cd tmp
tar -czvf "${PACKAGE}_${VERSION}+dfsg.1.orig.tar.gz" *
cd trunk

# Debian has very specific requirements about the naming of build directories
cp -a "packaging/deb" "debian"

# Now, we can call Debian's standard build tool
debuild

echo
echo "The Debian package build finished."
