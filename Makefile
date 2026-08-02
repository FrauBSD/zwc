# zwc — wc(1) for compressed files
#
PREFIX?=	/usr/local
BINDIR?=	${PREFIX}/bin
MANDIR?=	${PREFIX}/share/man/man1

PROG=		zwc
MAN=		zwc.1
MANGZ=		${MAN}.gz

GZIP?=		gzip
GZIP_ARGS?=	-cn

all: ${MANGZ}

${MANGZ}: ${MAN}
	${GZIP} ${GZIP_ARGS} ${.ALLSRC} > ${.TARGET}

install: ${PROG} ${MANGZ}
	mkdir -p ${DESTDIR}${BINDIR} ${DESTDIR}${MANDIR}
	install -m 755 ${PROG} ${DESTDIR}${BINDIR}/${PROG}
	install -m 644 ${MANGZ} ${DESTDIR}${MANDIR}/${MANGZ}

clean:
	rm -f ${MANGZ}

.PHONY: all install clean
