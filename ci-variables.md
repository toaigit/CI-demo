Environment pre-defined by gitlab runner:
*   CI_SERVER_HOST          : pssbxdev01.stanford.edu
*   GITLAB_USER_NAME        : toai vo
*   CI_PROJECT_URL          : https://pssbxdev01.stanford.edu/toaivo/submitjob
*   CI_PROJECT_DIR          : /usr/local/bin/builds/yBuTH7uN/0/toaivo/submitjob
*   CI_PIPELINE_ID          : 179
*   CI_JOB_ID               : 492
*   CI_COMMIT_SHORT_SHA     : f9d7b63e
*   CI_PROJECT_NAMESPACE    : toaivo
*   CI_JOB_STAGE            : deploy
*   CI_BUILD_NAME           : deploy_dev
*   CI_ENVIRONMENT_NAME     : of1dev
 
Variables passing using variable parameters in gitlab-ci.yml
*  FIRST_NAME:           Toai
*  LAST_NAME :           Vo
 
Variable defined in UI at the project level, and at the project namespace level.
*   AWS_DEFAULT_REGION: us-west-2
*   AWS_ACCESS_KEY_ID : AL3OLXE3J40FOSJFLSDF

All jobs in the same stage are run in parallel

Jobs of the next stage are run only previous jobs stage ran successfully.

```
In addition to sections stage, environment, script, only, variables, you can have tags section.  The tags section defines which runner can run this job (runner with the same tags).  For example, this job can only run in a gitlab-runner with has tags production and php:
tags:
    - production
    - php
```

Here is a sample of the gitlab-ci.yml
```
variables:
  GIT_STRATEGY: clone

stages:
  - deploy
  - test

deploy_dev:
  stage: deploy
  environment:
        name: of1dev
  script:
        - ./deploy.sh
  only:
      - master
  variables:
      FIRST_NAME: "Toai"
      LAST_NAME: "Vo"

deploy_uat:
  stage: deploy
  environment:
        name: of2uat
  script:
        - ./deploy.sh
  only:
      - master
  variables:
      FIRST_NAME: "Jane"
      LAST_NAME: "Doe"

deploy_prod:
  stage: deploy
  environment:
        name: production
  script:
        - ./deploy.sh
  only:
      - master
  variables:
      FIRSTNAME: "George"
      LASTNAME: "Washington"
  when:
      manual
      
test_servlet:
  stage: test
  environment:
        name: prd
  script:
        - ./test.sh
  ```
