#export PATH=${PATH}:/usr/local:/usr/local/lib:/usr/local/bin
sh autogen.sh
CC=gcc8   \
CFLAGS="-Wall -Wmissing-prototypes -Wpointer-arith -Wdeclaration-after-statement -Wendif-labels -Wmissing-format-attribute -Wformat-security -fno-strict-aliasing -fwrapv -fexcess-precision=standard -Wno-format-trunc" \
 ./configure --with-libiconv=/usr/local --without-interrupt-tests
make clean
make
export PGUSER=postgres
export PGIS_REG_TMPDIR=~/tmp/pgis_reg_${BRANCH}
psql -c "DROP DATABASE IF EXISTS postgis_reg;"
make check RUNTESTFLAGS="-v"
sudo make install
make check RUNTESTFLAGS="-v --extension"
