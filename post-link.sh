#!/bin/bash

if [ -z $ZPREFIX ]
  then
    echo "You need to set ZPREFIX to HLQ where ZIGI will be installed"  > $PREFIX/.messages.txt
  else


    tso "ALLOC DA('${ZPREFIX}.ZIGI.EXEC') DSORG(PO) SPACE(15,15) BLKSIZE(32720) TRACKS DIR(1) LRECL(80) RECFM(F,B) NEW  Dsntype(Library,2)";
    tso "ALLOC DA('${ZPREFIX}.ZIGI.PANELS') DSORG(PO) SPACE(35,15) BLKSIZE(32720) TRACKS DIR(1) LRECL(80) RECFM(F,B) NEW  Dsntype(Library,2)";

    cp -U -M $PREFIX/ZIGI.EXEC/* "//'${ZPREFIX}.ZIGI.EXEC'";
    cp -U -M $PREFIX/ZIGI.PANELS/* "//'${ZPREFIX}.ZIGI.PANELS'";

    # Setup for the 'git env file' so we can run safely from ZIGI
    INSTALL_DIR=$PREFIX
    MANPATH=$PREFIX/man
    PERL5LIB=$PREFIX/lib/perl5
    p5ver=`ls -mt $PERL5LIB | cut -d ',' -f 1`
    LIBPATH=$PREFIX/lib/perl5/$p5ver/os390/CORE
    GIT_SHELL=$PREFIX/bin/bash
    GIT_EXEC_PATH=$PREFIX/libexec/git-core
    GIT_TEMPLATE_DIR=$PREFIX/share/git-core/templates
    GIT_PAGER=more


    cat >$PREFIX/.zigienv <<EOF
# ZIGI - environment file for $PREFIX
#
# This file is needed so ZIGI is able to 'find' git and it's required dependencies.
# If you're going to be moving the 'conda environment' directory elsewhere, make sure to update this file.	 
#
# File Generated: $now
# wizardofzos 2021
export PATH=$INSTALL_DIR/bin:\$PATH
export MANPATH=\$MANPATH:$INSTALL_DIR/man
export PERL5LIB=$INSTALL_DIR/lib/perl5:\$PERL5LIB
export LIBPATH=$INSTALL_DIR/lib/perl5/5.24.0/os390/CORE:\$LIBPATH
export GIT_SHELL=$INSTALL_DIR/bin/bash
export GIT_EXEC_PATH=$INSTALL_DIR/libexec/git-core
export GIT_TEMPLATE_DIR=$INSTALL_DIR/share/git-core/templates
export GIT_PAGER=more
export _CEE_RUNOPTS="FILETAG(AUTOCVT,AUTOTAG) POSIX(ON)"
export _BPXK_AUTOCVT=ON
export _TAG_REDIR_ERR=txt
export _TAG_REDIR_IN=txt
export _TAG_REDIR_OUT=txt
EOF

echo "" >> $PREFIX/.messages.txt
echo "All setup.. you can run ZIGI from ${ZPREFIX}.ZIGI.EXEC(ZIGI)" >> $PREFIX/.messages.txt
echo "An example environment file (might want to add to ~/.profile?) prepared in $PREFIX/.zigienv" >> $PREFIX/.messages.txt
echo
fi

