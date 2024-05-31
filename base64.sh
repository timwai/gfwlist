#!/bin/bash
echo " ---> pull remote"
git pull
cat /dev/null  > ./gfwlist.txt
gfwResult=`cat ./gfwlist_decode.txt|base64`
length=`expr ${#gfwResult} / 64 + 1`
echo " ---> loading，About a minute"
for((i=0;i<${length};i++));
do
    echo ${gfwResult:`expr ${i} \* 64`:64} >> ./gfwlist.txt
done
echo " ---> Synchronous remote"
git add .
git commit -m 'feat(gfwlist):update'
git push
echo " ---> done"
