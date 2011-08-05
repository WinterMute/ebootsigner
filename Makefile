CFLAGS	:=	-O2

UNAME	:=	$(shell uname -s)

ifneq (,$(findstring Darwin,$(UNAME)))
	SDK	:=	/Developer/SDKs/MacOSX10.4u.sdk
	CFLAGS	+= -mmacosx-version-min=10.4 -isysroot $(SDK) -arch i386 -arch ppc
	LDFLAGS		+= -mmacosx-version-min=10.4 -Wl,-syslibroot,$(SDK) -arch i386 -arch ppc
endif

all: ebootsign
ebootsign: ebootsign.o crypto.o kirk_engine.o pack-pbp.o unpack-pbp.o fix-realocations.o

install: ebootsign
	install $^ $(shell psp-config --pspdev-path)/bin

clean:
	$(RM) ebootsign
	$(RM) *.o
	$(RM) *~
