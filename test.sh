#!/bin/bash
#  test.sh 
#  This script checks if the job running on the servlet EC2 is done.  
#  If so, it will terminate the instance.....

#  wait till the server is ready doing its job .... it takes time for AWS EC2 instance
#  to be ready even if it is "running" state during the EC2 creating step (deploy.sh)

sleep 120

#  sleep time for the loop
sleeptime=30

#  set the job max time is 60x30s = 30 mins
maxloop=60  

export AWS_DEFAULT_REGION=us-west-2
export JOBFLAG_S3="s3://toai-test.s.e/job.done"
export INSTID_S3="s3://toai-test.s.e/instantid.txt"
export YOUREMAIL="janedoe@janedoe.io"

# get the servlet instance-id (created by servlet EC2 on the way up)

aws s3 cp $INSTID_S3 /tmp/instantid.txt
chmod 700 /tmp/instantid.txt
export INSTID=`cat /tmp/instantid.txt`
echo "DEBUG: Instant-ID $INSTID"

# get the autoscale group of the servlet EC2 instance 
# this information will be use to terminate the instance later

export ACS=`aws autoscaling describe-auto-scaling-instances --instance-ids $INSTID --output text --query 'AutoScalingInstances[*].AutoScalingGroupName'`
echo "DEBUG: AutoScaling Group $ACS"

#  Loop until it is done ...
while [ $counter -lt $maxloop ]
do
   echo "DEBUG: Looping $counter ..."
   sleep $sleeptime
   echo "DEBUG: Current Directory $PWD ..."
   ls -ltr
   aws s3 cp $JOBFLAG .
   if [ $? -eq 0 ] ; then
      echo "DEBUG: going to destroy the servlet instance ..."
      echo "DEBUG: instantID $INSTID  AutoScale Group: $ACS"
      echo "DEBUG: Deleting AutoScale group (terminating instance) $INSTID"
      aws autoscaling delete-auto-scaling-group --auto-scaling-group-name $ACS  --force-delete 
      echo "DEBUG:  Test Completed"
      exit 0
   fi
   counter=$(( $counter + 1 ))
done

echo "DEBUG: Test Error"
#mailx -s "URGENT: job is still running" $YOUREMAIL < /dev/null
