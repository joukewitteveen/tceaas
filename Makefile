PKG_CONFIG := pkg-config

prefix := /usr/local
bindir := ${prefix}/bin
libdir := ${prefix}/lib
systemunitdir != ${PKG_CONFIG} systemd --variable=systemdsystemunitdir

.PHONY: install
install:
	mkdir -p '${DESTDIR}${systemunitdir}'
	sed -e 's|@libdir@|${libdir}|g' 'tceaas@.service.in' \
	  > '${DESTDIR}${systemunitdir}/tceaas@.service'
	install -D -t '${DESTDIR}${libdir}' tceaas
	install -D -t '${DESTDIR}${bindir}' tce-load tce-unload
