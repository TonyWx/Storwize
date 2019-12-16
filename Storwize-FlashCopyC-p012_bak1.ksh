#!/usr/bin/ksh93
####################################################################################
# Storwize-FlashCopyC-p012_bak1.ksh - Storwize Storage FlashCopy (Snapshot) Script
# Written By: TonyW {TWx} - https://github.com/TonyWx/Storwize
# Version 7.1.0.0
# Update 2019/12/15 -- New Release on AIX 7200-03-02-1845
#
# Compatibility:
# AIX 7.2 / AIX 7.1 / VIOS 2.2.6 / AIX 6.1 TL 2 Service Pack 5 (6100-02-05) or later
# Release History:
# v7.1.0.0 - 2019/12/15 - New Release.
#-----------------------------------------------------------------------------------
# Use the startfcconsistgrp command to start a FlashCopy consistency group
# of mappings. This command makes a point-in-time copy of the source
# volumes at the moment that the command is started.
####################################################################################

# Consistency group Name
ConsistGrp=p012_bak1

# Command prefix (ex: username@ip.address)
SshPre='/usr/bin/ssh pbancs01@192.168.200.6 '

# Information
ScriptName=$(basename $0)
PL="------------------------------------------------------------"
print
print "Start Storwize Script"
print $PL
print "Start Time \t\t= "`date +%Y-%m-%d-%H:%M:%S`
print "Script Name \t\t= $ScriptName"
print "Consistency Group \t= $ConsistGrp"
print $PL

# Check ConsisGrp
print "Check Consistency Group Status";print
BStatus=`$SshPre lsfcconsistgrp -nohdr -filtervalue name=$ConsistGrp | awk '{print $3}'`
if [ ! "$BStatus" = "" ]; then
  print "Current Status = $BStatus"
else
  print "!!  Status Error, Please Check Consistency Group [$ConsistGrp]  !!"
  print; exit 1
fi

# Start FlashCopy
print $PL
print "Start FlashCopy --"`date +%Y-%m-%d-%H:%M:%S`"--"; print
FStatus=`$SshPre "startfcconsistgrp -prep $ConsistGrp" 2>&1`
sleep 1
if [ ! "$FStatus" = "" ]; then
  print $FStatus; print; print "!!  FlashCopy Abort  !!"; print; exit 1
fi
GStatus=`$SshPre lsfcconsistgrp -nohdr -filtervalue name=$ConsistGrp | awk '{print $3}'`
print "Immediate Status = $GStatus"
print "Script Finished!!"
print $PL; print

exit 0