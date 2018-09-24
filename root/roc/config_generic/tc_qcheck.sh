d=`date "+%Y-%m-%d-%H%M%S"`;
logfile=/data/roc/logs/%${d}_log.txt;
echo "# Checking status at $d " >> $logfile;
echo "" >> $logfile;

echo " Number of files in queue" >> $logfile;
ls -lt /data/roc/queue | wc -l >> $logfile;
echo "" >> $logfile;

d1=`date "+%Y%m%d"`;
echo " Number of files from today $d1: " >> $logfile;
ls -lt /data/roc/$d1/* | wc -l >> $logfile;
echo "" >> $logfile;

echo " Disk usage" >> $logfile;
du -hs /data/roc/queue >> $logfile;
du -hs /data/roc/logs >> $logfile;
echo "" >> $logfile;

echo " Configuration check" >> $logfile;
echo " config:" >> $logfile;
ls /etc/opt/roc/  >> $logfile;
echo "" >> $logfile;

echo " roc.conf:" >> $logfile;
cat /etc/opt/roc/roc.conf >> $logfile;
echo "" >> $logfile;

echo " zephyr.conf:" >> $logfile;
cat /etc/opt/roc/zephyr.conf >> $logfile;
echo "" >> $logfile;

echo " gps.conf:" >> $logfile;
cat /etc/opt/roc/gps.conf >> $logfile;
echo "" >> $logfile;

echo " config.txt links to:" >> $logfile;
ls -lt /etc/opt/roc/config.txt >> $logfile;
echo "" >> $logfile;

for fd in `ls -d */ `; do
  nf=`ls $fd | wc -l`;
  echo $fd has $nf files >> $logfile;
done;

cp $logfile /data/roc/queue;

