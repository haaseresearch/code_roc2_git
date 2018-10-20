d=`date "+%Y-%m-%d-%H%M%S"`;
logfile=/data/roc/logs/${d}_log.txt;
echo "# Starting reconfig at $d " >> $logfile;
echo "" >> $logfile;

rm -f /etc/opt/roc/config*.txt;
ln -s /root/roc/config_generic/config_standard_beidou.txt /etc/opt/roc/config.txt;
 
ls -lt /etc/opt/roc/config.txt >> $logfile;
cp $logfile /data/roc/queue;
sleep 5;
reboot;

