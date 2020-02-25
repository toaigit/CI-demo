# CI-demo - Simple gitlab runner ci/cd job
You will learn how to 
*  create/install a gitlab runner by reviewing the glrunner repos
*  Review the gitlab-ci.yml  configuration (stages, variables)
*  See a simple ci/cd job in action.
   *  You have a data text file and want to run a script to performance number crunching on this data.
   *  This jobs just need to run once a month or once a week on demand.
   *  Your idea is to spawn an EC2 instance, copy the data to the instance, run the number crunching script, save the result to somewhere and terminate the EC2 instance.
This simple repos (ci-demo) has the following files:
*  add.txt - a text file with a number in each line.  
*  run.sh - a shell script read each line of the file, sum it up and write the total.txt file to S3 bucket.
*  s3copy - a shell script to copy add.txt and run.sh to the S3 bucket before triggering the job.
*  deploy.sh - a shell script 
   *  clone/pull down the servlet repos
   *  run terraform init and apply to spawn servlet EC2 instance.  See servlet repo for detail
   *  So you have a EC2 gitlab runner, spawn an EC2 called servlet EC2 (have you ever done this?)
*  test.sh - a shell script
   *  check S3 bucket total.txt file.  If it exists, it will then terminate the servlet EC2 instance.
*  gitlab-ci.yml -  file to instruct gitlab-runner to run the deploy.sh and test.sh script.

NOTEs:
*  you need to spawn a gitlab runner instance using glrunner repos
*  you need to have your own servlet repos with appropriate configuration for your AWS environment
*  you need to have your own CI-demo repos.  You may want to call this repos job1, job2 etc...
*  Update data and Script
   *  update add.txt file
   *  execute s3copy to push add.txt and run.sh to the S3 bucket
*  Trigger CI/CD job
   *  git add run.sh, git commit -m "Update Run.sh" run.sh, and git push origin master 
*  Check gitlab pipline to see the progress.  You will see two jobs - deploy and test.
   *  download total.txt file from the S3 bucket.  You should see the correct total in this file.
