PKG_CONFIG := pkg-config

prefix := /usr/local
libdir := ${prefix}/lib
systemunitdir != ${PKG_CONFIG} systemd --variable=systemdsystemunitdir

install:
	mkdir -p '${DESTDIR}${systemunitdir}'
	sed -e 's|@libdir@|${libdir}|g' 'tceaas@.service.in' \
	  > '${DESTDIR}${systemunitdir}/tceaas@.service'
	install -D -t '${DESTDIR}${libdir}' tceaas
