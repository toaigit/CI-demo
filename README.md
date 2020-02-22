# CI-demo - Simple gitlab runner ci/cd job
This simple repos has the following files:
*  add.txt - a text file with a number in each line.  
*  run.sh - a shell script read each line of the file, sum it up and write the total.txt file to S3 bucket.
*  s3copy - a shell script to copy add.txt and run.sh to the S3 bucket.
*  deploy.sh - a shell script 
   *  clone the servlet repos
   *  run terraform init and apply to spawn servlet EC2 instance.  See servlet repo for detail
*  test.sh - a shell script
   *  check S3 bucket total.txt file.  If it exists, it will then terminate the servlet EC2 instance.
*  gitlab-ci.yml -  file to instruct gitlab-runner to run the deploy.sh and test.sh script.

NOTEs:
*  you need to spawn a gitlab runner instance using glrunner repos
*  you need to have your own servlet repos with appropriate configuration for your AWS environment
*  you need to have your own CI-demo repos
*  Trigger a CI/CD job of the CI-demo repo
   *  update add.txt file
   *  execute s3copy to push add.txt and run.sh to the S3 bucket
   *  git commit and git push 
   *  Check gitlab pipline to see the progress.  You will see two jobs - deploy and test.
   *  download total.txt file from the S3 bucket.  You should see the correct total in this file.
