#
# cshrc.lsf:
#     Sets the C shell user environment for openlava commands
#
setenv LSF_ENVDIR /opt/openlava/etc
setenv LSF_SERVERDIR /opt/openlava/sbin
setenv LSF_LIBDIR /opt/openlava/lib
setenv LSF_BINDIR /opt/openlava/bin
set path = ($path /opt/openlava/bin)
if ( ${?MANPATH} ) then
  setenv MANPATH ${MANPATH}:/opt/openlava/share/man
else
  setenv MANPATH :/opt/openlava/share/man
endif