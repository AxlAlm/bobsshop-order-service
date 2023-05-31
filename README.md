# bobsshop-order-service

..

## setup

#### create ecr repository

`aws ecr create-repository --repository-name bobsshop-order-service`

to list the url

`aws ecr describe-repositories`

####

we need to make 2 policies

1 for deploying and packaging SAM: SamDeployerRole
one for lambda (lambdas execute role): LambdasExecutionRole
