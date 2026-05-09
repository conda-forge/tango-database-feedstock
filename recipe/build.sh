if [[ "$host_alias" != "$build_alias" ]]
then
  # We cannot use try_run when cross compiling
  ADDITIONAL_ARGS="-DMySQL_VERSION=unknown"
else
  ADDITIONAL_ARGS=""
fi

cmake ${CMAKE_ARGS} \
      -G Ninja \
      -DCMAKE_BUILD_TYPE=RelWithDebInfo \
      -DCMAKE_VERBOSE_MAKEFILE=true \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      ${ADDITIONAL_ARGS} \
      -S . \
      -B build

cmake --build build
cmake --install build

if [ -n "${OBJCOPY}" ]
then
  mkdir -p ${PREFIX}/lib/debug
  ${OBJCOPY} --only-keep-debug ${PREFIX}/bin/Databaseds ${PREFIX}/lib/debug/Databaseds.dbg
  chmod 664 ${PREFIX}/lib/debug/Databaseds.dbg
  ${OBJCOPY} --strip-debug ${PREFIX}/bin/Databaseds
  ${OBJCOPY} --add-gnu-debuglink=${PREFIX}/lib/debug/Databaseds.dbg ${PREFIX}/bin/Databaseds
fi
