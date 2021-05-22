variable "access_key" {}
variable "secret_key" {}
variable "region" {}
# variable "alarms_email" {}

# CPU UTILIZATION
variable "dev_cpu_alarms_warning" {} 
variable "dev_cpu_alarms_high" {}
# MEMORY USAGE
variable "dev_memory_alarms_warning" {}
variable "dev_memory_alarms_high" {}
# DISK UTILIZATION
variable "dev_disk_root_alarms_warning" {}
variable "dev_disk_root_alarms_high" {}
variable "dev_disk_opt_alarms_warning" {}
variable "dev_disk_opt_alarms_high" {}
variable "dev_disk_var_alarms_warning" {}
variable "dev_disk_var_alarms_high" {}
# ELB Target Health Status
variable "dev_elb_tght_dev" {}
variable "dev_elb_tght_dev_internal" {}
# ELB Target Response time
variable "dev_elb_trt_dev" {}
variable "dev_elb_trt_dev_internal" {}
# ELB Target-4XX
variable "dev_elb_target_4XX_dev" {}
variable "dev_elb_target_4XX_dev_internal" {}
# ELB Target-5XX
variable "dev_elb_target_5XX_dev" {}
variable "dev_elb_target_5XX_dev_internal" {}
# ELB ELB-4XX
variable "dev_elb_elb_4XX_dev" {}
variable "dev_elb_elb_4XX_dev_internal" {}
# ELB ELB-5XX
variable "dev_elb_elb_5XX_dev" {}
variable "dev_elb_elb_5XX_dev_internal" {}

# for SNS 
/*
variable "sns_topic" {
type    = map(string)
default = {
   prod     = "terraform-alarms_prod"
   dev      = "terraform-alarms"
 }
}
*/