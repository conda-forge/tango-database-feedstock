if [[ "$host_alias" != "$build_alias" ]]
then
  # We cannot use try_run when cross compiling
  ADDITIONAL_ARGS="-DMySQL_VERSION=unknown"
else
  ADDITIONAL_ARGS=""
fi

mkdir build
cd build
cmake ${CMAKE_ARGS} \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_VERBOSE_MAKEFILE=true \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      ${ADDITIONAL_ARGS} ..

make -j $CPU_COUNT
make install
