Terraform v0.13.4
# some instruction for cpu, memory and disk alarm creation.
we created two workspce as dev & prod.
we used same varible mentioned in variable.tf for both dev.tfvars & prod.tfvars.
command:
dev
terraform workspace select dev
terraform plan -var-file="dev.tfvars"
prod
terraform workspace select prod
terraform plan -var-file="prod.tfvars"
Import:
terraform import aws_cloudwatch_metric_alarm.test1 "Evelyn2_Dev - Warning - CPU Utilization - DS"
 





