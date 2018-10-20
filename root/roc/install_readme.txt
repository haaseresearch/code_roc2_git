Procedure for updating code only:
- tar -cvpf the /root /etc and /opt directories on source machine
- tar -cvpf /root directory only on source machine
- copy both tar files to dropbox
- create directory roc2.x_code-2018-MM-DD on dropbox
- tar -xvpf first tar file into the new dropbox directory
- copy 2nd tar file (/root only) onto destination roc
- from / on destination roc, tar -xvpf <tarfile>
- delete contents of /etc/opt/roc on target machine
- copy roc.conf and gps.conf from /root/roc/config_generic to /etc/opt/roc
- copy EITHER zephyr.conf or zephyr_hw2.conf from /root/roc/config_generic to /etc/opt/roc/zephyr.conf,
  depending on whether this ROC has version 2 or 3 of the interface board
- create link to the desired GPS configuration file:
  ln -s /root/roc/config_generic/<file.txt> /etc/opt/roc/config.txt
- from /root/roc execute "touch src/*.c"
- from /root/roc execute "make"
