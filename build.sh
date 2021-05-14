#!/bin/bash

# Well let's see...

# Need this here so the conda build will actually 'package' the MVS-datasets into the conda package...

# Panels and REXX
cp -R $SRC_DIR/ZIGI.EXEC $PREFIX/ZIGI.EXEC
cp -R $SRC_DIR/ZIGI.PANELS $PREFIX/ZIGI.PANELS

# .zigi folder, for ISPF stats and sizes
cp -R $SRC_DIR/.zigi $PREFIX/.zigi


# Support datasets and installer
cp -R $SRC_DIR/ZIGI.GPLLIC $PREFIX/ZIGI.GPLLIC
cp -R $SRC_DIR/ZIGI.README $PREFIX/ZIGI.README
cp -R $SRC_DIR/ZIGI.RELEASE $PREFIX/ZIGI.RELEASE
cp -R $SRC_DIR/zginstall.rex $PREFIX/zginstall.rex

