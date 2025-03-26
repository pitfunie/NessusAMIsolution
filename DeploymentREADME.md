##AWS InFrastructure Automation with Terraform, Packer, and Lambda##

## This repository automates the deployment of a Nessus AMI and associated AWS infrastructure using Terraform, Packer, and an event-driven AWS Lambda function. It supports multi-region deployment and includes modular Terraform code, Python scripts for automation, and a GitLab CI/CD pipeline for continuous integration and delivery.


##Features##

    Nessus AMI Creation: Build a customized AMI with Nessus (a vulnerability assessment tool) using Packer.

    Multi-Region Terraform Deployment: Deploy VPCs, subnets, and security groups across multiple AWS regions using modular Terraform.

    Event-Driven Lambda: Trigger infrastructure deployment and AMI creation with an AWS Lambda function.

    GitLab CI/CD Integration: Automate the entire deployment process through a gitlab-ci.yml pipeline.

    Compliance and Security: Integrated with AWS Control Tower, IAM, GuardDuty, and SCPs for PCI DSS compliance.

    Real-Time Monitoring: Use AWS services like CloudWatch, AWS Config, and WAF for governance and logging.


##1. Prerequisites##

    Install Required Tools:
    1. Terraform (≥ v1.0)
    2. Packer
    3. Python (≥ 3.7)
       boto3
       Subprocess
       traceback
    AWS CLI for setting up credentials and configurations.

##2. AWS Account Setup:##

    Set up AWS credentials:
    Ensure sufficient permissions for:

      EC2: Create instances, manage AMIs.
      IAM: Roles, policies, SCPs.
      S3: Manage buckets for state files.
      Lambda: Deploy and trigger Lambda functions.

##3. GitLab Runner:##

    Configure a runner for executing CI/CD pipelines.**



##Step-by-Step Execution##


##1.  Clone the Repository##

git clone https://github.com/your-repo/aws-automation
cd aws-automation


##2. Configure Terraform Variables##
Create a terraform.tfvars file to specify deployment regions and other variables:

region         = "us-east-1"
cidr_block     = "10.0.0.0/16"
public_subnet_cidr = "10.0.1.0/24"
private_subnet_cidr = "10.0.2.0/24"
tags = {
  Environment = "Production"
}


##3. Generate a Nessus AMI with Packer##
Run Packer to build a custom AMI:

packer validate packer-template.json
packer build packer-template.json


##4. Deploy AWS Infrastructure with Terraform##
Format, validate, and deploy infrastructure:

python terraform_automation.py

This will:

    Format Terraform files (terraform fmt).

    Validate the configuration (terraform validate).

    Generate a plan (terraform plan).

    Apply the infrastructure changes (terraform apply).


##GitLab CI/CD Pipeline##

Add the following gitlab-ci.yml to your GitLab repository for automated builds and deployments:

stages:
  - packer
  - terraform

packer_build:
  image: hashicorp/packer:latest
  script:
    - packer validate packer-template.json
    - packer build packer-template.json
  artifacts:
    paths:
      - ami_generated_output.txt

terraform_deploy:
  image: hashicorp/terraform:latest
  dependencies:
    - packer_build
  script:
    - terraform init
    - terraform validate
    - terraform plan
    - terraform apply -auto-approve
    

##Push your code to trigger the pipeline:##

git add .
git commit -m "Add GitLab CI/CD pipeline"
git push origin main


##Example: Deploying to Multiple Regions#

##Modify terraform.tfvars for additional regions:##

region         = "us-west-2"
cidr_block     = "10.1.0.0/16"
public_subnet_cidr = "10.1.1.0/24"
private_subnet_cidr = "10.1.2.0/24"
tags = {
  Environment = "Staging"
}


##Run Terraform Deployment:##

AWS_REGION=us-west-2 python terraform_automation.py


##Troubleshooting##
Common Issues

    IAM Permission Failures:

        Ensure your credentials have the necessary permissions for EC2, IAM, Lambda, and S3 services.

    Packer Build Errors:

        Verify the base AMI is correct and accessible in the specified region.

        Check for connectivity issues while downloading Nessus RPMs.

    Terraform Errors:

        Ensure your backend S3 bucket for Terraform state exists if using terraform init.

    Lambda Execution Errors:

        Check Lambda execution roles for permissions to invoke Packer and Terraform commands.

##Logs and Debugging##

    Use AWS CloudWatch for monitoring Lambda executions.

    Check output files in output/ for AMI build results and deployment logs.

##License##

This project is licensed under the MIT License.








  



