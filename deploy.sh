#!/bin/bash

set -e
if [ "$BRANCH_NAME" = "if-production" ]
then
    stagevar=prod
elif [ "$BRANCH_NAME" = "staging" ]
then
    stagevar=staging
elif [[ $BRANCH_NAME == iftihor-* ]]
then
    stagevar=dev
fi

echo "value of stagevar is $stagevar"

# if stage is equal to dev or staging, then build and push image as well
if [ "$stagevar" = "dev" ] || [ "$stagevar" = "staging" ]
then
    cd web/
    make build stage=$stagevar
    make push stage=$stagevar
    cd ..
    cd api/
    make build stage=$stagevar
    make push stage=$stagevar
    cd .. 
fi

# deploy image regardless of stage
cd web/
make deploy stage=$stagevar
cd ..
cd api/
make deploy stage=$stagevar
cd .. 