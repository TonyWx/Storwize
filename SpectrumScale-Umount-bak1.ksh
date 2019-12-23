#!/usr/bin/ksh93
####################################################################################
# SpectrumScale-Umount-bak1.ksh - SpectrumScale Umount (Snapshot) Script
# Written By: TonyW {TWx} - https://github.com/TonyWx/Storwize
# Version 7.1.0.0
# Update 2019/12/15 -- New Release on AIX 7200-03-02-1845
#
# Compatibility:
# AIX 7.2 / AIX 7.1 / VIOS 2.2.6 / AIX 6.1 TL 2 Service Pack 5 (6100-02-05) or later
# Release History:
# v7.1.0.0 - 2019/12/15 - New Release.
####################################################################################

if [ $(id -u) != 0 ]; then
  print; print "!! Note: This command can only be executed by root. !!"; print
  exit 1
fi

export PATH=/usr/lpp/mmfs/bin:/usr/sbin:$PATH
# Filesystem Name p012bandvol p012redovol
# Fuser Point : # mmdsh -N all fuser -xkuc /oradata/p012band /oradata/p012redo

# Information
ScriptName=$(basename $0)
PL="------------------------------------------------------------"
print
print "Identifies & Clear processes using a filesystem."
mmdsh -N all fuser -xkuc /oradata/p012band /oradata/p012redo
print "Start Filesystem Umount."
print $PL
print "Start Time \t\t= "`date +%Y-%m-%d-%H:%M:%S`
print "Script Name \t\t= $ScriptName"
print $PL
# Start Umount.
mmumount p012bandvol -a
mmumount p012redovol -a
print
print "Script Finished!!"
print $PL; print

exit 0