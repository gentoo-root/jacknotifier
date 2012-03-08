.PHONY: first all clean install

SOURCES = main.c dbus.c notify.c gettext.c
OBJECTS = $(patsubst %.c,%.o,$(SOURCES))
DEPS = $(patsubst %.c,%.dep,$(SOURCES))

TRANSLATIONS = po/ru.po
TRANS_COMPILED = $(patsubst %.po,%.mo,$(TRANSLATIONS))

SHELL = sh
CC = gcc
LD = gcc
MSGFMT = msgfmt
INSTALL = install -v
RM = rm -f

CFLAGS = -O3 -Wall -fomit-frame-pointer `pkg-config --cflags dbus-1 libnotify`
LDFLAGS =
LIBS = `pkg-config --libs dbus-1 libnotify`

first: all

-include $(DEPS)

all:	jacknotifierd $(TRANS_COMPILED)

jacknotifierd:	$(OBJECTS)
	$(LD) $(LDFLAGS) $^ -o $@ $(LIBS)

%.dep:  %.c Makefile
	$(SHELL) -ec "$(CC) -x c $(CFLAGS) -MM $< | sed -re 's|([^:]+.o)( *:+)|$(<:.c=.o) $@\2|;'" > $@

%.o:	%.c %.dep Makefile
	$(CC) -x c $(CFLAGS) -c $< -o $@

%.mo:	%.po
	$(MSGFMT) $^ -o $@

clean:
	$(RM) jacknotifierd *.o *.dep po/*.mo

install:
	$(INSTALL) jacknotifierd /usr/bin
	cd po; for mo in *.mo; do $(INSTALL) -v $$mo /usr/share/locale/$${mo%.mo}/LC_MESSAGES/jacknotifier.mo; done

uninstall:
	$(RM) /usr/bin/jacknotifierd
