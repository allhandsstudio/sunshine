#
# openlava.sh:
#   Setup openlava environment variables
#

LSF_ENVDIR=/opt/openlava/etc
PATH=$PATH:/opt/openlava/bin
LSF_SERVERDIR=/opt/openlava/sbin
LSF_LIBDIR=/opt/openlava/lib
LSF_BINDIR=/opt/openlava/bin
MANPATH=$MANPATH:/opt/openlava/share/man

export LSF_ENVDIR PATH MANPATH LSF_SERVERDIR LSF_LIBDIR