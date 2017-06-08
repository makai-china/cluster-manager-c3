# $Id: c3.sh 186 2011-01-21 23:07:00Z tjn $

if ! echo $PATH | /bin/grep -q "/opt/c3-5" ; then
  PATH="$PATH:/opt/c3-5/"
fi

if ! echo $MANPATH | /bin/grep -q "/opt/c3-5/man" ; then
  MANPATH="$MANPATH:/opt/c3-5/man/"
fi

# vim:tabstop=4:shiftwidth=4:noexpandtab:textwidth=76
