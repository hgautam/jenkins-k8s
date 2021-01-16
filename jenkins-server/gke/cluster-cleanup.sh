#! /bin/bash

# Set ZONE NAME
zone_name=us-west3-a
# Set LOG_FILE
LOG_FILE=gcloud.log

# Remove gcloud clusters

echo " Running gcloud container clusters list command" | tee -a $LOG_FILE

gcloud container clusters list > gcloud_cluster_list.log

for clustername in `awk '{if(NR>1)print}' gcloud_cluster_list.log | awk '{print $1}'`
 do
   echo "deleting cluster: $clustername" | tee -a $LOG_FILE
   gcloud container clusters delete $clustername --quiet --zone $zone_name
done

# Remove Compute Disks

echo "Running list compute disks command" | tee -a $LOG_FILE

gcloud compute disks list > compute_disks.log

for diskname in `awk '{if(NR>1)print}' compute_disks.log | awk '{print $1}'`
do
 echo "Deleting Compute Disk: $diskname" |  tee -a $LOG_FILE
 gcloud compute disks delete $diskname --quiet --zone $zone_name | tee -a $LOG_FILE
done