#!/bin/bash 

##
## build.sendmail.sh
##
## root@lido:/etc/mail# /usr/local/sbin/sendmail -d0.1 -bv
## Version 8.15.2
## Compiled with: DNSMAP IPV6_FULL LOG MATCHGECOS MILTER MIME7TO8 MIME8TO7
## NAMED_BIND NETINET NETUNIX NEWDB PIPELINING SASLv2 SCANF
## STARTTLS USERDB XDEBUG
##
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
NAME=sendmail
VERSION=8.15.2
URL=http://ftp.sendmail.org/${NAME}.${VERSION}.tar.gz

## create users and group
if getent group floppy > /dev/null 2>&1; then
  groupdel floppy
  groupadd -g 25 smmsp
  useradd -u 25 -g 25 -d /var/spool/clientmqueue -s /bin/false smmsp
fi

## fetch tarball
if [ ! -e ${NAME}.${VERSION}.tar.gz ]; then
  wget $URL
fi
tar xzvf ${NAME}.${VERSION}.tar.gz

## build libmilter as shared object, not working
#cp ${SRCDIR}/sharedlibrary.m4 ${NAME}-${VERSION}/devtools/M4/UNIX
#cd ${NAME}-${VERSION} && rsync -av libmilter/ libsharedmilter
#cd libsharedmilter && perl -p -i -e 's/library/sharedlibrary/g' Makefile.m4

## create package directory structure
for MYDIR in bin sbin lib include libexec share; do
  if [ ! -d /usr/local/${MYDIR} ]; then
    mkdir -p usr/local/${MYDIR}
  fi
done

## man folders
for MANDIR in man1 man5 man8; do
  if [ ! -d /usr/local/share/man/${MYDIR} ]; then
    mkdir -p /usr/local/share/man/${MANDIR}
  fi
done

## configuration directory
mkdir -p /etc/mail

## compile
cp site.config.m4 ${NAME}-${VERSION}/devtools/Site/site.config.m4
cd ${NAME}-${VERSION}
./Build
./Build install

cd libmilter
./Build
./Build install
cd ..

## man pages
for manpage in sendmail editmap mailstats makemap praliases smrsh; do
  install -v -m644 $manpage/$manpage.8 /usr/local/share/man/man8
done
install -v -m644 sendmail/aliases.5 /usr/local/share/man/man5
install -v -m644 sendmail/mailq.1 /usr/local/share/man/man1
install -v -m644 sendmail/newaliases.1 /usr/local/share/man/man1
install -v -m644 vacation/vacation.1 /usr/local/share/man/man1

## cleanup
cd ..
rm -rf ${NAME}-${VERSION}*
rm -rf ${NAME}.${VERSION}*


