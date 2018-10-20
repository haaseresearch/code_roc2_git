21-Sep-2018
-----------

New version of code in directory roc2.3_code_v037_2018_09_21

Fixed:

- Our code was not following the proper communications protocol at startup.
  We were sending IMR messages once per minute until we received an IM message
  telling us to go to FL mode. The correct protocol is to send IMR messages
  once per minute until you receive an IM message telling us to go into ANY
  mode, then stop sending IMR messages. We will receive future mode changes
  (including the switch to FL mode) from Zephyr automatically. This has been
  fixed in this release.
- roc_unwind program (09-21-18 version) handles new packet header format
  better.
  
Changes:

- Changed the software build date to "20180921,1152"
- Changed the software version number to "037"

Bugs:

- Sending commands to GPS receiver still fails once in a while.
- CRIT message packets may be transmitted in between the 2nd and
  3rd data files after startup until the system is able to discern the
  true rate of data file generation (the time between the 1st and 2nd
  data files is shorter than the time between the rest of them).

Upcoming Changes:

- Expand usage of TM packet headers to include:
  - # of satellites tracked
  - Linux board supply voltage
  - # of files in queue
  - Name of GPS config file
- Add more CRIT/WARN conditions to TM packets
- Add IPC between roc and zephyr modules
- Move software build date, sw version #, and hw version # to a single header file


20-Sep-2018
-----------

New version of code in directory roc2.1_code_2018_09_20

Fixed:

Changes:

- Changed the software build date to "20180920,1000"
- Changed the software version number to "036"
- Changed header format of TM packets:
  - StateFlag1 and StateMess1 fields have not changed
  - Added StateFlag2/StateFlag3 and StateMess2/StateMess3 fields for sending
    more status data
  - StateMess2 contains the percentage of free disk space on /data.
    1.00 = 100% free, 0.00 = 0% free.
  - StateFlag2 = FINE if % free > 50%, WARN if %free <50%, and
    CRIT if %free < 25%.
  - StateMess3 contains the software build date,time,version
  - StateFlag3 = CRIT if no data files have appeared in the queue within
    expected period of time, FINE otherwise.
- Maximum size of payload changed from 3800 bytes to 3700 bytes to 
  allow for larger TM packet headers.
- The time allowed for the first file to appear in the queue before
  triggering a CRIT alarm is 15 minutes.

Bugs:

- Sending commands to GPS receiver still fails once in a while.
- CRIT message packets may be transmitted in between the 2nd and
  3rd data files after startup until the system is able to discern the
  true rate of data file generation (the time between the 1st and 2nd
  data files is shorter than the time between the rest of them).

Upcoming Changes:

- Expand usage of TM packet headers to include:
  - # of satellites tracked
  - Linux board supply voltage
  - # of files in queue
  - Name of GPS config file
- Add more CRIT/WARN conditions to TM packets
- Change roc_unwind program as needed to deal with new TM packet headers
- Add IPC between roc and zephyr modules
- Move software build date, sw version #, and hw version # to a single header file


19-Sep-2018
-----------

New version of code in directory roc2.1_code_2018_09_19

Fixed:

- Fixed the data file names sometimes being 1 second later than expected.
- Added some error checking of the RMC message from GPS before using it
    to set the Linux clock.

Changes:

- Changed the software build date to "20180919,1200"
- Changed the software version number to "035"
- Changed the contents of the housekeeping TM packets.
  - Instrument mode is now shown as 2 letters instead of number 0-4.
- Changed the safety timeout from 600 seconds back to 7200 seconds as per
  spec	
- Added computation of free disk space but that data is not in packet
  headers yet.
  
Bugs:

- Sending commands to GPS receiver still fails once in a while.

Upcoming Changes:

- Expand usage of TM packet headers to include:
  - Software version number
  - Instrumet mode
  - Free disk space
  - # of satellites tracked
  - Linux board supply voltage
  - # of files in queue
  - Name of GPS config file
- Implement FINE/CRIT/WARN/UNKN flags in TM packet headers
  - First criteria is set flag to CRIT if age of last data file is 
    greater than file_length. This means that, if no IPC, zephyr module
	needs to discover file length on its own by looking at file names?
- Change roc_unwind program as needed to deal with new TM packet headers
- Add IPC between roc and zephyr modules


17-Sep-2018
-----------

New version of code in directory roc2.3_code_2018-09-17
Doing testing of roc2.1 & 2.3 with actual Zephyr instrument at LATMOS.

Fixed:
- Think the bug that's causing files in the queue to be deleted
  while the instrument is in SB mode has been fixed.
  (Pending testing with zephyr/simulator)
- Fixed issue with data files sometimes being started 3 seconds later than
  expected. Although further testing shows files are still sometimes
  1 second late (see bug below).
- GPS RMC message now being read from correct serial port
- Linux clock now set based on the time read from the GPS at the start of
  each data file
- Restored behavior of sending "housekeeping" TM packets once per
  minute when in SB or LP mode

  
Changes:

- Changed the software build date to "20180917,1053"
- Changed the software version number to "034"
- Changed contents of housekeeping TM packet from "000" to "N", where
  N is 0-4 representing the current flight mode. 0=FL,1=SB,2=LP,3=SA,4=EF
- roc module now writes GPS startup commands and replies to log file

Bugs:

- Sometimes sending commands to the GPS receiver fails when the roc
  module is looking for the "COMx>" prompt from the receiver. When this
  happens it will resend the command but by the time it has resent the
  command the current time has changed from xx:00 to xx:01, which
  causes the name of the next data file to appear to be 1 second "late"
  (even though no data is lost). Currenty investigating why the 
  sending of GPS command fails sometimes. A quickk fix to this specific
  bug will be to move the GPS time set code to the end of the 
  OpenLogFile() function rather than the beginning of it.



13-Sep-2018 pm
--------------

New version of code released in directory roc2.2_code_2018-09-13
This version should be migrated to other ROC units but perhaps not until they
arrive in France in a couple of days. This build features cleaning up of some
debugging messages added earlier in the week and a couple of minor robustness
additions.

Changes:

- Changed the software build date to "20180913,2105"
- Changed the software version number to "033"
- Removed some of the Log entries that were previously recorded by roc module during
  testing earlier this week.

Bugs:

- zephyr module continues trying to transmit data files while in SB mode and
  does not require and ACK from Zephyr before deleting these files. This results
  in any files left in the queue being "transmitted" (even if there is no 
  receiver) and then being erased.
- RMC NMEA message from GPS receiver is not being sent to correct
  serial port so it is not recorded.


2018-09-13
----------

Modified by jhaase:
Version 20180913,1300 SWVersion 032

commented out lines 747 to 761 of zephyr.c
replaced line 763 with the line
	system(payload); // to get the roc to take a generic TC command

Updated config_generic with specific config options
Updated gps.conf to use the config_generic/config_standard_flight.txt


12-Sep-2018
-----------

New version of code released in directory roc2.2_code_2018-09-12

Fixed:

- (tentative) Think the bug we've been chasing for the past few
days may have been fixed finally. The roc module would crash after
it had been running long enough to generate a certain number of 
data files. That number was usually 1019 or 1020 files for the
versions of the code being tested prior to 10-Sep. It appears that
the roc process was crashing due to a memory leak in the function
TodaysDirectoryExists() due to failing to call closedir() to free
the memory allocated by the call to opendir(). Initial testing 
shows that over 1340 data files have been created without a crash.
The current test will continue overnight and should result in
over 10,000 data files if successful.

Changes:

- Changed the software build date to "20180912,2212"
- Changed the software version number to "031"

Bugs:

- RMC NMEA message from GPS receiver is not being sent to correct
  serial port so it is not recorded.
  
  
11-Sep-2018
-----------

Created a new version of the code in the roc2.2_code_2018-09-11
directory. This version adds a lot more messages logged in the 
log_log.txt file in an attempt to find where the program is 
crashing after it creates a fixed number of files. Haven't been
able to find it yet so this version of the code should not be
used.


10-Sep-2018 (evening entry)
-----------

Created a new version of the code in the roc2.2_code_2018-09-10b
directory. This version adds a lot more messages logged in the 
log_log.txt file in an attempt to find where the program is 
crashing after it creates a fixed number of files. Haven't been
able to find it yet so this version of the code should not be
used.


10-Sep-2018
-----------

Testing has shown that the roc module crashes after about 17 hours.
A version of the code was made that contains one change from yesterday's
release that might fix this. Released in roc2.2_code_2018-09-10.

Fixed:

- There was a bug in the code related to memory allocation when creating
new data files. The amount of memory allocated was previously equal to 
the length of the full path of the data file. It needs to be 1 greater
than this to also hold the null terminator of the string. This has been
fixed. Also, the code previously would allocate new memory for the string
containing the new file name every time a data file is created but it would
never free the previous memory. This would result in lots of "stale" memory
locations acculumating over time. Now the code only allocates memory if the
string variable is NULL, meaning it has not been previously allocated. Once
it has been allocated the same memory location can be reused for each new
file name as the length of the file name is constant.

Changes:

- Changed the software build date to "20180910,1356"
- Changed the software version number to "029"
- Changed logging location to /data/roc/logs/ in zephyr.h and roc.h (jhaase)
- Changed /etc/init.d/roc to not create random roc_log.txt in root


09-Sep-2018
-----------

Copied 02-Sep-2018 code and made changes to enable logging of debug
messages to files located in /data/logs/. These files are named with the
date followed by _roc_log.txt or _zephyr_log.txt. These changes were
briefly tested on roc2.2 but need further verification on other systems
using Zephyr simulator. Currently the only messages generated are
startup messages for both modules, some error messages, and insturment
mode changes in the zephyr log.


02-Sep-2018
-----------

No changes to the actual code in this release but the /root/roc directory
has been restructed. The goal here was to make sure all of the files needed
for a full distribution of the ROC code are contained in the /root/roc
directory. Previously the startup scripts were only found in /etc/init.d
and the config files were only found in /etc/opt/roc. Those have now
been placed in appropriate directories underneath /root/roc. 

The makefile has also been modified so that it copies these files to the
correct system directories when run. Currently the startup scripts are
copied to /etc/init.d and the gpio script is copied to /opt/roc. The config
files are not copied yet until a reliable method for prompting the user can
be implemented. We don't want the makefile automatically overwriting existing
conf files with the generic versions so it needs to ask the user first. The
makefile is also smarter now about deleting existing files first. It checks
for the existance of .o files before compiling and removes them if they are
there. It also checks for the existance of the executables and removes them
if they are there.

Clean-up of ROC2.3 filesystem was done prior to making a full backup image to
use as the master image for other systems. Files removed include:

System logs in /var/log
System backup files in /var/backups
Typo files in /etc/wpa_supplicant
Unused compiler outputs in /root/roc (remnants of Windows-based development)
Unused 'occult' startup script in /etc/init.d

In addition to removing the system log files from /var/log the rsyslog service
has been disabled on ROC2.3 to prevent it from generating system logs in the
future. To re-enable this service in the future the command would be:

systemctl enable rsyslog


25-Jul-2018
-----------

Fixed:

- Fixed bug where the GPS receiver would not shut off when switching to low power
  mode. This bug only occurred when the software was started automatically at boot
  up. Cause of the bug was the system call to the "gpio" script that now handles
  digital I/O. That system call wasn't being specified as a full path to the 
  executable. That's why it worked when logged in but not when started without a
  terminal attached to it.

Changes:
- Changed the build date and time string to "20180725,2231" for both roc and zephyr
  modules.
- Changed the software version string to "027" for both roc and zephyr modules.

Bugs:
- The initialization commands need to be sent to the GPS receiver after turning
  power back on (when switching from LP mode to FL mode). Currently no way to do
  that until some form of IPC is implemented.


22-Jul-2018
-----------

Fixed:

- Minimum delay between messages sent from ROC was increased from 300ms to 1s
  if the zephyr module. The 300ms limit was sometimes allowing messages to be
  sent to the Zephyr instrument too quickly causing message acknowledgement
  errors.

Changes:
- Changed the build date and time string to "20180722,2225" for both roc and zephyr
  modules.
- Changed the software version string to "026" for both roc and zephyr modules.

Bugs:
- The initialization commands need to be sent to the GPS receiver after turning
  power back on (when switching from LP mode to FL mode). Currently no way to do
  that until some form of IPC is implemented.
- Bing has reported some problems with the latest code:
   - switching to LP mode doesn't shut down the GPS receiver (NOTE: UNABLE TO
     REPRODUCE THIS BUG).
   - Some sort of bug related to sending a telecommand to ROC? Need clarification
     on this one. See Bing's log entry "2018-06-29_tofix.txt"


17-Jul-2018
-----------

This folder contains no software changes, it is just a snapshot of the latest
version to be used as the basis for further updates.

Fixed:

Changes:
- Changed the build date and time string to "20180717,2327" for both roc and zephyr
  modules.
- Changed the software version string to "025" for both roc and zephyr modules.

Bugs:
- The initialization commands need to be sent to the GPS receiver after turning
  power back on (when switching from LP mode to FL mode). Currently no way to do
  that until some form of IPC is implemented.
- Bing has reported some problems with the latest code:
   - Sometimes switching to SAFE mode is not acknowledged.
   - switching to LP mode doesn't shut down the GPS receiver.
   - Some sort of bug related to sending a telecommand to ROC? Need clarification
     on this one. See Bing's log entry "2018-06-29_tofix.txt"


12-Jun-2018
-----------

Fixed:

Changes:
- Created 'roc_gpio' startup script in /etc/init.d. This script configures GPIO
  pins correctly.
- Created script 'gpio' in /opt/bin. This script is called from the roc and
  zephyr modules to set the digital outputs rather than doing it manually in those
  modules. See source code for that script for details.
- Disabled script 'roc_led' in /etc/init.d since that functionality has been moved
  to script 'gpio'.
- Changed the build date and time string to "20180612,2312" for both roc and zephyr
  modules.
- Changed the software version string to "024" for both roc and zephyr modules.
- zephyr: Added 'hwversion' item to zephyr.conf file. The latest version of the
  interface board, completed June 2018, is version 3. Version 2 is the only prior
  version in use.
- zephyr: Reads hwversion from conf file and uses this to determine how to handle
  low power mode. HW version 3 allows software control of the power to the GPS
  receiver. GPS power is on at startup and only turned off when entering LP mode.
  Power turned back on when switching from LP mode to FL mode.
- zephyr: turn external LED to green if startup is successful, turn it red if not.
- roc: Added some of the code to eventually take over control of the external LED.
  Not active yet.

Bugs:
- The initialization commands need to be sent to the GPS receiver after turning
  power back on (when switching from LP mode to FL mode). Currently no way to do
  that until some form of IPC is implemented.


08-Mar-2018
-----------

Fixed:
- Fixed problem of data files growing forever and not being copied to queue.
- Fixed problem of data offload process stopping after a while when it boots normally.
  
Changes:
- Changed the build date and time string to "20180308,2301"
- Changed the software version string to "022"

Bugs:
- Sometimes the name of the file to offload becomes invalid. Either NULL or %. Code
  can't offload that file and doesn't know what to do about it, it just keeps trying.
- System crashed after running for about 10 minutes offloading data. Crash happened
  right when it received a TMAck and GPS message back to back, not sure if that was
  the cause.


07-Mar-2018
-----------

Fixed:
- ROC was sending IMR request repeatedly at startup even after it got an IM message
  putting it into SB mode. I assume it's supposed to stop sending IMR after it gets
  any IM message.
- Wasn't sending periodic housekeeping TM messages in LP mode. Now it does.
  
Changes:
- Added 'clear' telecommand that clears the data queue
- Changed the build date and time string to "20180307,1819"
- Changed the software version string to "021"

Bugs:
- Sometimes the name of the file to offload becomes invalid. Either NULL or %. Code
  can't offload that file and doesn't know what to do about it, it just keeps trying.
- System crashed after running for about 10 minutes offloading data. Crash happened
  right when it received a TMAck and GPS message back to back, not sure if that was
  the cause.
- Saw a behavior that Jen had noticed where the data files grew very large and were
  no longer being copied into the queue.
- System stops offloading data after some number of minutes when it boots on its
  own (doesn't do it when run from the cmd line)
  

06-Mar-2018
-----------

Fixed:
- REALLY think I fixed the unreliable comms now. Had to increase gap between ROC
  messages from 1 second to 2 seconds. Seems to work well now so far.
- Fixed a bug that caused ROC to miss the 2nd message if two messages arrived
  simultaneously.
  
Changes:
- Re-added reboot command via TC
- Increased max size of TM payload to 3800 bytes. The maximum amount of data that
  linux will send in a single write is ~4100 bytes. If our packets are bigger than
  that we need to transmit them using multiple write commands. But when I do this
  the Zephyr simulator crashes. I'm probably not splitting up the buffer properly
  when I do it in multiple parts.
- Changed the build date and time string to "20180306,1859"
- Changed the software version string to "020"

Bugs:
- Sometimes the name of the file to offload becomes invalid. Either NULL or %. Code
  can't offload that file and doesn't know what to do about it, it just keeps trying.
- System crashed after running for about 10 minutes offloading data. Crash happened
  right when it received a TMAck and GPS message back to back, not sure if that was
  the cause.

  
01-Mar-2018
-----------

Fixed:
- Probably fix for the 5 second delay between sending of TM messages during
  data transfer. This should increase our throughput dramatically. Need to test
  though.

Changes:
- Changed the contents of the TM packet header. If the packet contains a data payload
  (we're transmitting a data file) the StateMess1 field of the header now contains
  the name of the file being transferred, the current part number, and the total number
  of parts. The format is name,part,totalparts. This information is needed to 
  recombine the individual parts back into the original files on the receiving end.
- Removed some debug messages added previously.
- Changed the build date and time string to "20180301,2316"
- Changed the software version string to "019"

Bugs:
- Sometimes the name of the file to offload becomes invalid. Either NULL or %. Code
  can't offload that file and doesn't know what to do about it, it just keeps trying.
- System crashed after running for about 10 minutes offloading data. Crash happened
  right when it received a TMAck and GPS message back to back, not sure if that was
  the cause.

  
  
27-Feb-2018
-----------

Fixed:
- Fixed bug in the setting of the SAFE output signal
- Definitely fixed the back-to-back msgs
- Fixed a bug causing problems when Zephyr acknowledged the receipt of a housekeeping
  TM message. 

Changes:
- No longer try to reset GPS receiver when coming out of LP mode since it doesn't work
- Changed the only TC command that we listen to. If the command contains "ls" in it, the
  system will do "ls -l" on the download queue and put the results into a file called
  "~list.txt" and place that file into the queue directory. The ~ in the file name should
  cause it to be the next file offloaded.
- Data files after the 1st file are started/stopped on even boundaries of the file length
- Changed the build date and time string to "20180227,2222"
- Changed the software version string to "018"

Bugs:
- Sometimes the name of the file to offload becomes invalid. Either NULL or %. Code
  can't offload that file and doesn't know what to do about it, it just keeps trying.
- System crashed after running for about 10 minutes offloading data. Crash happened
  right when it received a TMAck and GPS message back to back, not sure if that was
  the cause.
  

26-Feb-2018
-----------

Fixed:
- Maybe fixed the timing so no more-back-to-back msgs?

Changes:
- Removed .conf files from /root/roc
- SWVersion and SWDate printed at startup.
- ROC now sends an "S" msg every time Zephyrs sends us IM-S message as required.
- Changed the build date and time string to "20180226,1159"
- Changed the software version string to "017"


20-Feb-2018
-----------

Fixed:
  
Changes:
- No longer shuts down when it receives the command to change to EF mode. It just
  does nothing now. The program remains running so that it can listen for further
  mode change commands.
- SAFE digital output now set to HI when in safe mode.
- Housekeeping TM messages sent once/min when in SB mode.
- Changed the build date and time string to "20180220,2127"
- Changed the software version string to "016"


14-Feb-2018
-----------

Fixed:
- Fixed bug causing ROC to enter Safe mode at startup.
- Got rid of compiler warnings.
- Fixed crash caused by sending TC message to ROC.
- Fixed GPS receiver sleep when entering LP mode.

Changes:
- Can no longer send messages faster than once/second. Currently an inefficient
  solution.
- Now correctly sends TCAck message in response to receiving TC message.
- A TC message that contains the string "reboot" (without the quotes) anywhere in
  the payload will initiate a reboot.
- Changed the build date and time string to "20180214,0016"
- Changed the software version string to "015"


13-Feb-2018
-----------

Fixed:
- Fixed bug in how GPS receiver was being put into standby mode. Had the
  wrong serial port specified.
  
Changes:
- No longer starts sending IMR messages when entering SB mode after being
  in another mode. Only sends IMR messages at startup.
- Switching to EF mode now causes system to shutdown.
- Changed the build date and time string to "20180213,0001"
- Changed the software version string to "014"


12-Feb-2018
-----------

Changes:
- Sends command to put GPS receiver into StandBy mode when Zephyr tells
  ROC to enter Low Power mode.
- Toggled nRESET pin on GPS receiver (pin #10) when switching from Low
  Power mode to Flight Mode.
- Changed the build date and time string to "20180212,0001"
- Changed the software version string to "013"


11-Feb-2018
-----------

Changes:
- Now responds correctly to End-of-FLight mode change. Stops all comms
  with Zephyr. GPS data collection continues.
- Should now correctly enter Safety mode if no comms have been received
  from Zephyr in over 2 hours. Does not toggle SAFE digital output yet
  though when entering Safety mode, either by 2 hour timeout or by IM
  change request.
- Changed the build date and time string to "20180211,2324"
- Changed the software version string to "012"

