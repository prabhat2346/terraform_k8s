variable "access_key" {}
variable "secret_key" {}
variable "region" {}
variable "alarms_email" {}
variable "evelyn_ec2_instance_id_cpu" {}
variable "metric_alarm_name_cpu_warning" {}
variable "metric_alarm_name_cpu_high" {}
variable "evelyn_ec2_instance_id_memory" {}
variable "metric_alarm_memory_warning" {}
variable "metric_alarm_memory_high" {}
variable "ami_id_memory" {}
variable "instance_type_memory" {}
variable "evelyn_ec2_instance_root_id" {}
variable "metric_alarm_name_disk_root_warning" {}
variable "metric_alarm_name_disk_root_high" {}
variable "ami_id_root" {}
variable "path_name_root" {}
variable "device_name_root" {}
variable "instance_type_root" {}
variable "fstype_name_root" {}
variable "evelyn_ec2_instance_opt_id" {}
variable "metric_alarm_name_disk_opt_warning" {}
variable "metric_alarm_name_disk_opt_high" {}
variable "ami_id_opt" {}
variable "path_name_opt" {}
variable "device_name_opt" {}
variable "instance_type_opt" {}
variable "fstype_name_opt" {}
variable "evelyn_ec2_instance_var_id" {}
variable "metric_alarm_name_disk_var_warning" {}
variable "metric_alarm_name_disk_var_high" {}
variable "ami_id_var" {}
variable "path_name_var" {}
variable "device_name_var" {}
variable "instance_type_var" {}
variable "fstype_name_var" {}
/*
# Dev----------------------------#
# variable used for ELB(target)
variable "target_group" {}
variable "LB_Evelyn2_Dev" {}
variable "LB_Evelyn2_Dev_Internal" {}
variable "Evelyn2_Dev_ELB_Alarm_Name" {}
variable "Evelyn2_Dev_Internal_ELB_Alarm_Name" {}
variable "Evelyn2_Dev_Availability_zone" {}
variable "LB_Evelyn2_Dev_4xx" {}
variable "LB_Evelyn2_Dev_Internal_4xx" {}
variable "Evelyn2_Dev_ELB_Alarm_Name_4xx" {}
variable "Evelyn2_Dev_Internal_ELB_Alarm_Name_4xx" {}
variable "Evelyn2_Dev_Availability_zone_4xx" {}
# for ELB 5xx
variable "LB_Evelyn2_Dev_elb" {}
variable "LB_Evelyn2_Dev_Internal_elb" {}
variable "Evelyn2_Dev_ELB_Alarm_Name_elb" {}
variable "Evelyn2_Dev_Internal_ELB_Alarm_Name_elb" {}
variable "Evelyn2_Dev_Availability_zone_elb" {}
# for ELB 4xx
variable "LB_Evelyn2_Dev_4xx_elb" {}
variable "LB_Evelyn2_Dev_Internal_4xx_elb" {}
variable "Evelyn2_Dev_ELB_Alarm_Name_4xx_elb" {}
variable "Evelyn2_Dev_Internal_ELB_Alarm_Name_4xx_elb" {}
variable "Evelyn2_Dev_Availability_zone_4xx_elb" {}

#  # ELB target Resoponse time.
variable "LB_Evelyn2_Dev_trt" {}
 variable "LB_Evelyn2_Dev_Internal_trt" {}
variable "Evelyn2_Dev_ELB_Alarm_Name_trt" {}
 variable "Evelyn2_Dev_Internal_ELB_Alarm_Name_trt" {}
variable "Evelyn2_Dev_Availability_zone_trt" {}
*/

############### Prod###############

# variable used for ELB(target)
variable "target_group_prod" {}
variable "LB_Evelyn2_sh" {}
variable "LB_Evelyn2_cribl" {}
variable "LB_Evelyn2_cribl_Internal" {}
variable "Evelyn2_sh_ELB_Alarm_Name" {}
variable "Evelyn2_cribl_ELB_Alarm_Name" {}
variable "Evelyn2_cribl_Internal_ELB_Alarm_Name" {}
variable "Evelyn2_prod_Availability_zone" {}
variable "LB_Evelyn2_sh_4xx" {}
variable "LB_Evelyn2_cribl_4xx" {}
variable "LB_Evelyn2_cribl_Internal_4xx" {}
variable "Evelyn2_sh_ELB_Alarm_Name_4xx" {}
variable "Evelyn2_cribl_ELB_Alarm_Name_4xx" {}
variable "Evelyn2_cribl_Internal_ELB_Alarm_Name_4xx" {}
variable "Evelyn2_Prod_Availability_zone_4xx" {}
# for ELB 5xx
variable "LB_Evelyn2_sh_elb" {}
variable "LB_Evelyn2_cribl_elb" {}
variable "LB_Evelyn2_cribl_Internal_elb" {}
variable "Evelyn2_sh_ELB_Alarm_Name_elb" {}
variable "Evelyn2_cribl_ELB_Alarm_Name_elb" {}
variable "Evelyn2_cribl_Internal_ELB_Alarm_Name_elb" {}
variable "Evelyn2_prod_Availability_zone_elb" {}
# for ELB 4xx
variable "LB_Evelyn2_sh_4xx_elb" {}
variable "LB_Evelyn2_cribl_4xx_elb" {}
variable "LB_Evelyn2_cribl_Internal_4xx_elb" {}
variable "Evelyn2_sh_ELB_Alarm_Name_4xx_elb" {}
variable "Evelyn2_cribl_ELB_Alarm_Name_4xx_elb" {}
variable "Evelyn2_cribl_Internal_ELB_Alarm_Name_4xx_elb" {}
variable "Evelyn2_prod_Availability_zone_4xx_elb" {}

#  # ELB target Resoponse time.
variable "LB_Evelyn2_sh_trt" {}
variable "LB_Evelyn2_cribl_trt" {}
 variable "LB_Evelyn2_cribl_Internal_trt" {}
variable "Evelyn2_sh_ELB_Alarm_Name_trt" {}
variable "Evelyn2_cribl_ELB_Alarm_Name_trt" {}
 variable "Evelyn2_cribl_Internal_ELB_Alarm_Name_trt" {}
variable "Evelyn2_prod_Availability_zone_trt" {}

# for SNS 
variable "sns_topic" {
type    = map(string)
default = {
   prod     = "terraform-alarms_prod"
   dev      = "terraform-alarms"
 }
}





