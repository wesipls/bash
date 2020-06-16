#!/bin/bash
#VERY SIMPLE LOG ROTATION, USES DAILY TIMESTAMP, CANNOT RUN TWICE ADAY
#TODO MORE ACCURATE TIMESTAMP, EXIT ERROR CODES
#CHANGE LOGPATH VARIABLE TO DIRECTORY WITH LOGS TO COMPRESS

logpath="logs/"

#change working directory to log folder
cd $logpath

#if packed:logs does not exist, create it
if [ ! -d "packed_logs" ]; then
	mkdir packed_logs
	echo "packed_logs directory has been created"
fi	

#move to-be packed files to a tmp folder
tarname=$(date '+%Y-%m-%d')
tmp_folder="${tarname}_packed_files"
mkdir $tmp_folder
for x in $(ls -t | grep -v packed_logs | tail -n 5)
do
	echo There is a match with $x
	mv $x $tmp_folder/
done

#pack files and cleanup
tarname=$(date '+%Y-%m-%d')
tar -czf "compressed_logs_$tarname.tar.gz" $tmp_folder
mv "compressed_logs_$tarname.tar.gz" packed_logs
rm -r $tmp_folder
echo "Logs have been compressed"

exit 0
