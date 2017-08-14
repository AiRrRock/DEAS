EXTRA_DIST = DEASGUI.glade
dist_data_DATA =DEASGUI.glade crutch30.jpg
AM_CPPFLAGS = -DPACKAGE_DATA_DIR=\""$(datadir)"\"

bin_PROGRAMS = DEAS
DEAS_SOURCES = DEAS.vala CommandHolder.vala Command.vala CommandInterface.vala AwkRegExp.vala SedRegExp.vala ParallelCommand.vala CommandExecutor.vala Preset.vala Date.vala RegExp.vala DEASGUI.glade

## Process this file with automake to generate a Makefile.in
## To build all programs with GTK+ uncomment these lines.

## Only our GUI program uses GTK+ at the moment.
DEAS_VALAFLAGS = --pkg gtk+-3.0
DEAS_LDADD = $(DEAS_LIBS) -lm

CLEANFILES = *.h *.c *.vapi *.stamp


