# mom-terraform-bg-demo
Configure AWS Credentials
https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html

Build the AMI--------------
  1. cd ./p_apache
Requires some AWS resources for AWS provisioner (could be done locally using VirtualBox or similar). Build AWS resources with Terraform:
  2. terraform apply
Build the AMI image:
  3. packer build .
  4. Note/Record the AMI Image ID (this could be configured to be passed dynamically via artifacts)

Build the B/G deployment groups:
  1. Terraform apply
 
Note:
SSL certificate was manually provisioned but because it's an AWS certificate through AWS Certificate Manager and linked to an AWS Application Load Balancer, it's free and will benefit from automatic renewal.
Certificate could also be provisioned with Terraform, I just already had a certificate in place.
