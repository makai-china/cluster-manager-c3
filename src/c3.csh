# $Id: c3.csh 186 2011-01-21 23:07:00Z tjn $

if ( $?PATH == 0 ) then
    setenv PATH "/opt/c3-5/"
else
    setenv PATH "${PATH}:/opt/c3-5/"
endif

if ( $?MANPATH == 0 ) then
    setenv MANPATH "/opt/c3-5/man"
else
    setenv MANPATH "${MANPATH}:/opt/c3-5/man"
endif

# vim:tabstop=4:shiftwidth=4:noexpandtab:textwidth=76
