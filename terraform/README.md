# Steps to deploy on Terraform Cloud
## Installation of pre-requisites
- aws cli (version=aws-cli/1.18.68)
- kubectl
- terraform (version=v0.13.0)

## Deployment Steps
1. Deploy hashicorp vault on an ec2 instance manually
   https://learn.hashicorp.com/tutorials/vault/getting-started-install
-- refer Linux -> Ubuntu/Debian section on this page

2. Create secrets for Rancher and other domain names in vault
   vault kv put secret/rancher-cert -value=@<path to key-cert dir>/rancher.crt
   vault kv put secret/rancher-key -value=@<path to key-cert dir>/rancher.key
   vault kv put secret/testapp-host1-cert -value=@<path to key-cert dir>/testapp-host1.crt
   vault kv put secret/testapp-host1-key -value=@<path to key-cert dir>/testapp-host1.key

3. Connect terraform cloud to github and configure workspaces/submodules/variables etc.
   https://www.terraform.io/docs/cloud/vcs/github-app.html
   https://www.terraform.io/docs/cloud/workspaces/variables.html

4. Deploy the infrastrucure using terraform which will include
- VPC
- RDS
- EKS
- sample-app with zero replicas
# provide input values in terraform.auto.tfvars
  Configure terraform.auto.tfvars 
   - Modify value of route53-zone variable
   - Modify values of testapp-route53-hosts, testapp-route53-hostnames, testapp-crt-path, testapp-key-path according to your requirements.
   Note: Add the values to the list in order such that index for all values related to a single host is same.   
   - Modify other values accordingly.

```
terraform init
terraform plan -out plan.out
terraform apply plan.out
```

# Get cluster credentials using aws cli , if needed on any machine 
aws eks --region region-code update-kubeconfig --name cluster_name

5. build docker image and push to ecr created in above step. Follow step 2 and 5 in this guide:
   https://docs.aws.amazon.com/AmazonECR/latest/userguide/getting-started-cli.html

6. scale the app replicas from zero to desired value
   ```
   kubectl scale deployment testapp-testapp-war --replicas=1
   ```
## Clean-up Steps
1. terraform destroy -auto-approve
