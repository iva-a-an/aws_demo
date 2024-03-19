# aws_demo

## Solution comments
- So solution may look overcomplecated for the task, but it was made with intention to show some best practicies.
- The cost of the infrastructure and optimal region is not condidered due to time limitations.
- IAM policies are not fine tuned. 


## Requirements
- IAM User with "Admin access".    
- "pass" secret manager   
- [direnv](https://direnv.net/)  


## How to deploy
1. go to ./app annd build python applicaion:
```
    make install_dependencies
    make build_zip
```
2. got to ./terraform/dev   
3. Deploy "init" terraform project. It will create S3 backet for terrraform backend   
4. Deploy "demo" terraform project. 


## Task descriptioin with comments
Technical task using AWS resources prior to the interview as requested.
The details of the task are below, this task only uses AWS resources available in the AWS
free tier and should not incur any expenses for Ross.
Develop the following capability using AWS resources
1. [+] Capability is triggered every 5 minutes
2. [+] Capability utilises serverless technology
3. [+] Capability performs the following steps:   
    i) Fetches a random user from https://randomuser.me/api   
    ii) Fetched user data is stored in a location from which it can be retrieved   
    ### NOTES 
    Assumption of how steps 1,2,3 should be executed.   
    [+] Create lamba function that gets data from API endpoint and stores to AWS Secrets Manager   
    [+] Create triger to run function every 5 minutes    
    [+] app logic options:   
        - Create new user once    
        - Send messsage if secret already exist and exit with 0    

4. Capability includes an EC2 instance that can fetch and display the fetched user data    
   [+] Create IAM EC2 role and access policy to read the secret
5. Capability includes a second EC2 instance from which the fetched user data is secured,
i.e. attempting to fetch the data from this instance will be blocked
    [x] verify that acces policy workds
6. Capability resources can be re-deployed via automation
    [] create two environmnets??? Decide env separation level



## Improvements todo 
[] - lock terraform version
[] - review access policy for s3 (https://developer.hashicorp.com/terraform/language/settings/backends/s3)
[x] - enable log traces for Lambda fuction (CloudWatch?)
