#!/bin/bash
#Purpose = Monitor the opt filesystem
#Created on 2019-10-31
#Author = Edgar Adrian Sanchez Ruiz
#Email = edgsanchez@contractor.ea.com
#Version 1.0
#START

unset n
unset m
unset i
for i in $(cat hosts.txt)
do
n=$(($n+1))
ssh -oStrictHostKeyChecking=no $i "df /opt | cut -f1 -d '%' | tail -n 1 " | awk '{ print $5 }' >> m20prod-cfm-bm-$n
done

for i in {1..12}
do
m=$(($m+1))
val=$(cat m20prod-cfm-bm-$m)
if [ $val -ge 65 ]; then
if [ $m -lt 10 ]; then
echo "The host m20prod-cfm-bm-0$m.iad1.infery.com is alerted with /opt: $val %"
else
echo "The host m20prod-cfm-bm-$m.iad1.infery.com is alerted with /opt: $val %"
fi
echo "There are not issues with /opt"
fi
done
rm m20prod-*
#END
