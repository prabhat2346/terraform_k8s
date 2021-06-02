/*# Threshold value 
locals {
  thresholds = {
    CPUUtilizationThreshold   = "${min(max(var.cpu_utilization_threshold, 50), 80)}"
  }
}*/
# Alarm for cpu utilization 
resource "aws_cloudwatch_metric_alarm" "cpu_warning" {
  count               = length(var.evelyn_ec2_instance_id_cpu)
  alarm_name          = var.metric_alarm_name_cpu_warning[count.index]
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "10"
  datapoints_to_alarm = "8"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "50"
  alarm_description   = "This metric monitors ec2 cpu utilization"
  alarm_actions       = ["${aws_sns_topic.alarm.arn}"]
  ok_actions          = ["${aws_sns_topic.alarm.arn}"]

  dimensions = {
    InstanceId = var.evelyn_ec2_instance_id_cpu[count.index]
  }
}
resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  count               = length(var.evelyn_ec2_instance_id_cpu)
  alarm_name          = var.metric_alarm_name_cpu_high[count.index]
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "10"
  datapoints_to_alarm = "8"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric monitors ec2 cpu utilization"
  alarm_actions       = ["${aws_sns_topic.alarm.arn}"]
  ok_actions          = ["${aws_sns_topic.alarm.arn}"]

  dimensions = {
    InstanceId = var.evelyn_ec2_instance_id_cpu[count.index]
  }
}
# alarm for memory uses.
resource "aws_cloudwatch_metric_alarm" "memory_warning" {
  count               = length(var.evelyn_ec2_instance_id_memory)
  alarm_name          = var.metric_alarm_memory_warning[count.index]
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "10"
  datapoints_to_alarm = "8"
  metric_name         = "mem_used_percent"
  namespace           = "CWAgent"
  period              = "60"
  statistic           = "Average"
  threshold           = "50"
  alarm_description   = "This metric monitors ec2 disk utilization"
  alarm_actions       = ["${aws_sns_topic.alarm.arn}"]
  ok_actions          = ["${aws_sns_topic.alarm.arn}"]

  dimensions = {
    InstanceId   = var.evelyn_ec2_instance_id_memory[count.index]
    ImageId      = var.ami_id_memory[count.index]
    InstanceType = var.instance_type_memory[count.index]
  }
}
resource "aws_cloudwatch_metric_alarm" "memory_high" {
  count               = length(var.evelyn_ec2_instance_id_memory)
  alarm_name          = var.metric_alarm_memory_high[count.index]
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "10"
  datapoints_to_alarm = "8"
  metric_name         = "mem_used_percent"
  namespace           = "CWAgent"
  period              = "60"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric monitors ec2 disk utilization"
  alarm_actions       = ["${aws_sns_topic.alarm.arn}"]
  ok_actions          = ["${aws_sns_topic.alarm.arn}"]

  dimensions = {
    InstanceId   = var.evelyn_ec2_instance_id_memory[count.index]
    ImageId      = var.ami_id_memory[count.index]
    InstanceType = var.instance_type_memory[count.index]
  }
}
# alarm for disk of root 
resource "aws_cloudwatch_metric_alarm" "disk_root_warning" {
  count               = length(var.evelyn_ec2_instance_root_id)
  alarm_name          = var.metric_alarm_name_disk_root_warning[count.index]
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "10"
  datapoints_to_alarm = "8"
  metric_name         = "disk_used_percent"
  namespace           = "CWAgent"
  period              = "60"
  statistic           = "Average"
  threshold           = "50"
  alarm_description   = "This metric monitors ec2 disk utilization"
  alarm_actions       = ["${aws_sns_topic.alarm.arn}"]
  ok_actions          = ["${aws_sns_topic.alarm.arn}"]

  dimensions = {
    path         = var.path_name_root[count.index]
    InstanceId   = var.evelyn_ec2_instance_root_id[count.index]
    ImageId      = var.ami_id_root[count.index]
    InstanceType = var.instance_type_root[count.index]
    device       = var.device_name_root[count.index]
    fstype       = var.fstype_name_root[count.index]

  }
}
resource "aws_cloudwatch_metric_alarm" "diskdisk_root_high" {
  count               = length(var.evelyn_ec2_instance_root_id)
  alarm_name          = var.metric_alarm_name_disk_root_high[count.index]
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "10"
  datapoints_to_alarm = "8"
  metric_name         = "disk_used_percent"
  namespace           = "CWAgent"
  period              = "60"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric monitors ec2 disk utilization"
  alarm_actions       = ["${aws_sns_topic.alarm.arn}"]
  ok_actions          = ["${aws_sns_topic.alarm.arn}"]

  dimensions = {
    path         = var.path_name_root[count.index]
    InstanceId   = var.evelyn_ec2_instance_root_id[count.index]
    ImageId      = var.ami_id_root[count.index]
    InstanceType = var.instance_type_root[count.index]
    device       = var.device_name_root[count.index]
    fstype       = var.fstype_name_root[count.index]

  }
}
# alarm for disk of opt
resource "aws_cloudwatch_metric_alarm" "disk_opt_warning" {
  count               = length(var.evelyn_ec2_instance_opt_id)
  alarm_name          = var.metric_alarm_name_disk_opt_warning[count.index]
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "10"
  datapoints_to_alarm = "8"
  metric_name         = "disk_used_percent"
  namespace           = "CWAgent"
  period              = "60"
  statistic           = "Average"
  threshold           = "50"
  alarm_description   = "This metric monitors ec2 disk utilization"
  alarm_actions       = ["${aws_sns_topic.alarm.arn}"]
  ok_actions          = ["${aws_sns_topic.alarm.arn}"]

  dimensions = {
    path         = var.path_name_opt[count.index]
    InstanceId   = var.evelyn_ec2_instance_opt_id[count.index]
    ImageId      = var.ami_id_opt[count.index]
    InstanceType = var.instance_type_opt[count.index]
    device       = var.device_name_opt[count.index]
    fstype       = var.fstype_name_opt[count.index]

  }
}
resource "aws_cloudwatch_metric_alarm" "diskdisk_opt_high" {
  count               = length(var.evelyn_ec2_instance_opt_id)
  alarm_name          = var.metric_alarm_name_disk_opt_high[count.index]
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "10"
  datapoints_to_alarm = "8"
  metric_name         = "disk_used_percent"
  namespace           = "CWAgent"
  period              = "60"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric monitors ec2 disk utilization"
  alarm_actions       = ["${aws_sns_topic.alarm.arn}"]
  ok_actions          = ["${aws_sns_topic.alarm.arn}"]

  dimensions = {
    path         = var.path_name_opt[count.index]
    InstanceId   = var.evelyn_ec2_instance_opt_id[count.index]
    ImageId      = var.ami_id_opt[count.index]
    InstanceType = var.instance_type_opt[count.index]
    device       = var.device_name_opt[count.index]
    fstype       = var.fstype_name_opt[count.index]

  }
}
# alarm for disk of var
resource "aws_cloudwatch_metric_alarm" "disk_var_warning" {
  count               = length(var.evelyn_ec2_instance_var_id)
  alarm_name          = var.metric_alarm_name_disk_var_warning[count.index]
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "10"
  datapoints_to_alarm = "8"
  metric_name         = "disk_used_percent"
  namespace           = "CWAgent"
  period              = "60"
  statistic           = "Average"
  threshold           = "50"
  alarm_description   = "This metric monitors ec2 disk utilization"
  alarm_actions       = ["${aws_sns_topic.alarm.arn}"]
  ok_actions          = ["${aws_sns_topic.alarm.arn}"]

  dimensions = {
    path         = var.path_name_var[count.index]
    InstanceId   = var.evelyn_ec2_instance_var_id[count.index]
    ImageId      = var.ami_id_var[count.index]
    InstanceType = var.instance_type_var[count.index]
    device       = var.device_name_var[count.index]
    fstype       = var.fstype_name_var[count.index]

  }
}
resource "aws_cloudwatch_metric_alarm" "diskdisk_var_high" {
  count               = length(var.evelyn_ec2_instance_var_id)
  alarm_name          = var.metric_alarm_name_disk_var_high[count.index]
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "10"
  datapoints_to_alarm = "8"
  metric_name         = "disk_used_percent"
  namespace           = "CWAgent"
  period              = "60"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric monitors ec2 disk utilization"
  alarm_actions       = ["${aws_sns_topic.alarm.arn}"]
  ok_actions          = ["${aws_sns_topic.alarm.arn}"]

  dimensions = {
    path         = var.path_name_var[count.index]
    InstanceId   = var.evelyn_ec2_instance_var_id[count.index]
    ImageId      = var.ami_id_var[count.index]
    InstanceType = var.instance_type_var[count.index]
    device       = var.device_name_var[count.index]
    fstype       = var.fstype_name_var[count.index]
  }
}

# alarm for HTTPCode_Target_4XX_Count

# alarm for ELB/NLB
resource "aws_cloudwatch_metric_alarm" "elb5xx_Zone_1a" {
  count               = length(var.Evelyn2_Dev_ELB_Alarm_Name)
  alarm_name          = var.Evelyn2_Dev_ELB_Alarm_Name[count.index]
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  datapoints_to_alarm = "1"
  metric_name         = "HTTPCode_Target_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = "900"
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"
  threshold           = "50"
  alarm_description   = "ELB5xxx count in last 15min"
  actions_enabled     = "true"
  alarm_actions       = ["${aws_sns_topic.alarm.arn}"]
  ok_actions          = ["${aws_sns_topic.alarm.arn}"]
  dimensions = {
    AvailabilityZone =  var.LB_Evelyn2_Dev_Internal[count.index]
    LoadBalancer = var.LB_Evelyn2_Dev[count.index]
  }
}
# alarm for dev-internal
resource "aws_cloudwatch_metric_alarm" "elb5xx_Zone_1a_Internal" {
  count               = length(var.Evelyn2_Dev_Internal_ELB_Alarm_Name)
  alarm_name          = var.Evelyn2_Dev_Internal_ELB_Alarm_Name[count.index]
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  datapoints_to_alarm = "1"
  metric_name         = "HTTPCode_Target_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = "900"
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"
  threshold           = "50"
  alarm_description   = "ELB5xxx count in last 15min"
  actions_enabled     = "true"
  alarm_actions       = ["${aws_sns_topic.alarm.arn}"]
  ok_actions          = ["${aws_sns_topic.alarm.arn}"]
  dimensions = {
    AvailabilityZone =  var.Evelyn2_Dev_Availability_zone [count.index] 
    LoadBalancer = var.LB_Evelyn2_Dev_Internal[count.index]
  }
}
# # alarm for ELB/NLB
resource "aws_cloudwatch_metric_alarm" "elb4xx_Zone_1a" {
  count               = length(var.Evelyn2_Dev_ELB_Alarm_Name_4xx)
  alarm_name          = var.Evelyn2_Dev_ELB_Alarm_Name_4xx[count.index]
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  datapoints_to_alarm = "1"
  metric_name         = "HTTPCode_Target_4XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = "900"
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"
  threshold           = "50"
  alarm_description   = "ELB5xxx count in last 15min"
  actions_enabled     = "true"
  alarm_actions       = ["${aws_sns_topic.alarm.arn}"]
  ok_actions          = ["${aws_sns_topic.alarm.arn}"]
  dimensions = {
    AvailabilityZone =  var.LB_Evelyn2_Dev_Internal_4xx[count.index]
    LoadBalancer = var.LB_Evelyn2_Dev_4xx[count.index]
  }
}
# alarm for dev-internal
resource "aws_cloudwatch_metric_alarm" "elb4xx_Zone_1a_Internal" {
  count               = length(var.Evelyn2_Dev_Internal_ELB_Alarm_Name_4xx)
  alarm_name          = var.Evelyn2_Dev_Internal_ELB_Alarm_Name_4xx[count.index]
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  datapoints_to_alarm = "1"
  metric_name         = "HTTPCode_Target_4XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = "900"
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"
  threshold           = "50"
  alarm_description   = "ELB5xxx count in last 15min"
  actions_enabled     = "true"
  alarm_actions       = ["${aws_sns_topic.alarm.arn}"]
  ok_actions          = ["${aws_sns_topic.alarm.arn}"]
  dimensions = {
    AvailabilityZone =  var.Evelyn2_Dev_Availability_zone_4xx [count.index] 
    LoadBalancer = var.LB_Evelyn2_Dev_Internal_4xx[count.index]
  }
}
# ===========================================================================================================================
# alarm for ELB/NLB
resource "aws_cloudwatch_metric_alarm" "elb5xx_Zone_1a_elb" {
  count               = length(var.Evelyn2_Dev_ELB_Alarm_Name_elb)
  alarm_name          = var.Evelyn2_Dev_ELB_Alarm_Name_elb[count.index]
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  datapoints_to_alarm = "1"
  metric_name         = "HTTPCode_ELB_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = "900"
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"
  threshold           = "50"
  alarm_description   = "ELB5xxx count in last 15min"
  actions_enabled     = "true"
  alarm_actions       = ["${aws_sns_topic.alarm.arn}"]
  ok_actions          = ["${aws_sns_topic.alarm.arn}"]
  dimensions = {
    AvailabilityZone =  var.LB_Evelyn2_Dev_Internal_elb[count.index]
    LoadBalancer = var.LB_Evelyn2_Dev_elb[count.index]
  }
}
# alarm for dev-internal
resource "aws_cloudwatch_metric_alarm" "elb5xx_Zone_1a_Internal_elb" {
  count               = length(var.Evelyn2_Dev_Internal_ELB_Alarm_Name_elb)
  alarm_name          = var.Evelyn2_Dev_Internal_ELB_Alarm_Name_elb[count.index]
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  datapoints_to_alarm = "1"
  metric_name         = "HTTPCode_ELB_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = "900"
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"
  threshold           = "50"
  alarm_description   = "ELB5xxx count in last 15min"
  actions_enabled     = "true"
 alarm_actions       = ["${aws_sns_topic.alarm.arn}"]
 ok_actions          = ["${aws_sns_topic.alarm.arn}"]
  dimensions = {
    AvailabilityZone =  var.Evelyn2_Dev_Availability_zone_elb [count.index] 
    LoadBalancer = var.LB_Evelyn2_Dev_Internal[count.index]
  }
}
# # alarm for ELB/NLB
resource "aws_cloudwatch_metric_alarm" "elb4xx_Zone_1a_elb" {
  count               = length(var.Evelyn2_Dev_ELB_Alarm_Name_4xx_elb)
  alarm_name          = var.Evelyn2_Dev_ELB_Alarm_Name_4xx_elb[count.index]
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  datapoints_to_alarm = "1"
  metric_name         = "HTTPCode_ELB_4XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = "900"
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"
  threshold           = "50"
  alarm_description   = "ELB5xxx count in last 15min"
  actions_enabled     = "true"
  alarm_actions       = ["${aws_sns_topic.alarm.arn}"]
  ok_actions          = ["${aws_sns_topic.alarm.arn}"]
  dimensions = {
    AvailabilityZone =  var.LB_Evelyn2_Dev_Internal_4xx_elb[count.index]
    LoadBalancer = var.LB_Evelyn2_Dev_4xx_elb[count.index]
  }
}
# alarm for dev-internal
resource "aws_cloudwatch_metric_alarm" "elb4xx_Zone_1a_Internal_elb" {
  count               = length(var.Evelyn2_Dev_Internal_ELB_Alarm_Name_4xx_elb)
  alarm_name          = var.Evelyn2_Dev_Internal_ELB_Alarm_Name_4xx_elb[count.index]
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  datapoints_to_alarm = "1"
  metric_name         = "HTTPCode_ELB_4XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = "900"
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"
  threshold           = "50"
  alarm_description   = "ELB5xxx count in last 15min"
  actions_enabled     = "true"
 alarm_actions       = ["${aws_sns_topic.alarm.arn}"]
 ok_actions          = ["${aws_sns_topic.alarm.arn}"]
  dimensions = {
    AvailabilityZone =  var.Evelyn2_Dev_Availability_zone_4xx_elb[count.index] 
    LoadBalancer = var.LB_Evelyn2_Dev_Internal_4xx_elb[count.index]
  }
}

#  ELB target Resoponse time.

resource "aws_cloudwatch_metric_alarm" "elb_trt_dev" {
  # count               = length(var.Evelyn2_Dev_ELB_Alarm_Name_trt)
  alarm_name          = var.Evelyn2_Dev_ELB_Alarm_Name_trt
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  datapoints_to_alarm = "5"
  metric_name         = "TargetResponseTime"
  namespace           = "AWS/ApplicationELB"
  period              = "900"
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"
  threshold           = "1"
  alarm_description   = "ELB5xxx count in last 15min"
  actions_enabled     = "true"
  alarm_actions       = ["${aws_sns_topic.alarm.arn}"]
  ok_actions          = ["${aws_sns_topic.alarm.arn}"]
  dimensions = {
    AvailabilityZone =  var.Evelyn2_Dev_Availability_zone_trt
    LoadBalancer = var.LB_Evelyn2_Dev_trt
  }
}

#===========
resource "aws_cloudwatch_metric_alarm" "elb_trt_internal" {
  # count               = length(var.Evelyn2_Dev_Internal_ELB_Alarm_Name_trt)
  alarm_name          = var.Evelyn2_Dev_Internal_ELB_Alarm_Name_trt
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  datapoints_to_alarm = "5"
  metric_name         = "TargetResponseTime"
  namespace           = "AWS/ApplicationELB"
  period              = "900"
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"
  threshold           = "1"
  alarm_description   = "ELBtrt count in last 15min"
  actions_enabled     = "true"
  alarm_actions       = ["${aws_sns_topic.alarm.arn}"]
  ok_actions          = ["${aws_sns_topic.alarm.arn}"]
  dimensions = {
    AvailabilityZone =  var.Evelyn2_Dev_Availability_zone_trt
    LoadBalancer = var.LB_Evelyn2_Dev_Internal_trt
  }
}

########################
########Prod#############
# alarm for sh
#prod
# alarm for HTTPCode_Target_4XX_Count
# alarm for ELB/NLB
#sh
resource "aws_cloudwatch_metric_alarm" "elb5xx_Zone_1a_sh" {
  count               = length(var.Evelyn2_sh_ELB_Alarm_Name)
  alarm_name          = var.Evelyn2_sh_ELB_Alarm_Name[count.index]
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  datapoints_to_alarm = "1"
  metric_name         = "HTTPCode_Target_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = "900"
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"
  threshold           = "50"
  alarm_description   = "ELB5xxx count in last 15min"
  actions_enabled     = "true"
  #alarm_actions       = ["${aws_sns_topic.alarm.arn}"]
  #ok_actions          = ["${aws_sns_topic.alarm.arn}"]
  dimensions = {
    AvailabilityZone =  var.Evelyn2_prod_Availability_zone [count.index]
    LoadBalancer = var.LB_Evelyn2_sh[count.index]
  }
}
#cribl
resource "aws_cloudwatch_metric_alarm" "elb5xx_Zone_1a_cribl" {
  count               = length(var.Evelyn2_cribl_ELB_Alarm_Name)
  alarm_name          = var.Evelyn2_cribl_ELB_Alarm_Name[count.index]
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  datapoints_to_alarm = "1"
  metric_name         = "HTTPCode_Target_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = "900"
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"
  threshold           = "50"
  alarm_description   = "ELB5xxx count in last 15min"
  actions_enabled     = "true"
  #alarm_actions       = ["${aws_sns_topic.alarm.arn}"]
  #ok_actions          = ["${aws_sns_topic.alarm.arn}"]
  dimensions = {
    AvailabilityZone =  var.Evelyn2_prod_Availability_zone [count.index]
    LoadBalancer = var.LB_Evelyn2_cribl[count.index]
  }
}

# alarm for cribl-internal
resource "aws_cloudwatch_metric_alarm" "elb5xx_Zone_1a_cribl_Internal" {
  count               = length(var.Evelyn2_cribl_Internal_ELB_Alarm_Name)
  alarm_name          = var.Evelyn2_cribl_Internal_ELB_Alarm_Name[count.index]
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  datapoints_to_alarm = "1"
  metric_name         = "HTTPCode_Target_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = "900"
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"
  threshold           = "50"
  alarm_description   = "ELB5xxx count in last 15min"
  actions_enabled     = "true"
 # alarm_actions       = ["${aws_sns_topic.alarm.arn}"]
 # ok_actions          = ["${aws_sns_topic.alarm.arn}"]
  dimensions = {
    AvailabilityZone =  var.Evelyn2_prod_Availability_zone [count.index]
    LoadBalancer = var.LB_Evelyn2_cribl_Internal[count.index]
  }
}
#############################################################################
# # alarm for ELB/NLB
#sh
resource "aws_cloudwatch_metric_alarm" "elb4xx_Zone_1a_sh" {
  count               = length(var.Evelyn2_sh_ELB_Alarm_Name_4xx)
  alarm_name          = var.Evelyn2_sh_ELB_Alarm_Name_4xx[count.index]
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  datapoints_to_alarm = "1"
  metric_name         = "HTTPCode_Target_4XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = "900"
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"
  threshold           = "50"
  alarm_description   = "ELB5xxx count in last 15min"
  actions_enabled     = "true"
  #alarm_actions       = ["${aws_sns_topic.alarm.arn}"]
  #ok_actions          = ["${aws_sns_topic.alarm.arn}"]
  dimensions = {
    AvailabilityZone =  var.Evelyn2_prod_Availability_zone_4xx [count.index]
    LoadBalancer = var.LB_Evelyn2_sh_4xx[count.index]
  }
}
#cribl
resource "aws_cloudwatch_metric_alarm" "elb4xx_Zone_1a_cribl" {
  count               = length(var.Evelyn2_cribl_ELB_Alarm_Name_4xx)
  alarm_name          = var.Evelyn2_cribl_ELB_Alarm_Name_4xx[count.index]
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  datapoints_to_alarm = "1"
  metric_name         = "HTTPCode_Target_4XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = "900"
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"
  threshold           = "50"
  alarm_description   = "ELB5xxx count in last 15min"
  actions_enabled     = "true"
  #alarm_actions       = ["${aws_sns_topic.alarm.arn}"]
  #ok_actions          = ["${aws_sns_topic.alarm.arn}"]
  dimensions = {
    AvailabilityZone =  var.Evelyn2_prod_Availability_zone_4xx [count.index]
    LoadBalancer = var.LB_Evelyn2_cribl_4xx[count.index]
  }
}
# alarm for cribl-internal
resource "aws_cloudwatch_metric_alarm" "elb4xx_Zone_1a_cribl_Internal" {
  count               = length(var.Evelyn2_cribl_Internal_ELB_Alarm_Name_4xx)
  alarm_name          = var.Evelyn2_cribl_Internal_ELB_Alarm_Name_4xx[count.index]
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  datapoints_to_alarm = "1"
  metric_name         = "HTTPCode_Target_4XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = "900"
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"
  threshold           = "50"
  alarm_description   = "ELB5xxx count in last 15min"
  actions_enabled     = "true"
 # alarm_actions       = ["${aws_sns_topic.alarm.arn}"]
 # ok_actions          = ["${aws_sns_topic.alarm.arn}"]
  dimensions = {
    AvailabilityZone =  var.Evelyn2_prod_Availability_zone_4xx [count.index]
    LoadBalancer = var.LB_Evelyn2_cribl_Internal_4xx[count.index]
  }
}
# ===========================================================================================================================
# alarm for ELB/NLB
#sh
resource "aws_cloudwatch_metric_alarm" "elb5xx_Zone_1a_elb_sh" {
  count               = length(var.Evelyn2_sh_ELB_Alarm_Name_elb)
  alarm_name          = var.Evelyn2_sh_ELB_Alarm_Name_elb[count.index]
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  datapoints_to_alarm = "1"
  metric_name         = "HTTPCode_ELB_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = "900"
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"
  threshold           = "50"
  alarm_description   = "ELB5xxx count in last 15min"
  actions_enabled     = "true"
  #alarm_actions       = ["${aws_sns_topic.alarm.arn}"]
  #ok_actions          = ["${aws_sns_topic.alarm.arn}"]
  dimensions = {
    AvailabilityZone =  var.Evelyn2_prod_Availability_zone_elb [count.index]
    LoadBalancer = var.LB_Evelyn2_sh_elb[count.index]
  }
}
#cribl
resource "aws_cloudwatch_metric_alarm" "elb5xx_Zone_1a_elb_cribl" {
  count               = length(var.Evelyn2_cribl_ELB_Alarm_Name_elb)
  alarm_name          = var.Evelyn2_cribl_ELB_Alarm_Name_elb[count.index]
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  datapoints_to_alarm = "1"
  metric_name         = "HTTPCode_ELB_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = "900"
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"
  threshold           = "50"
  alarm_description   = "ELB5xxx count in last 15min"
  actions_enabled     = "true"
  #alarm_actions       = ["${aws_sns_topic.alarm.arn}"]
  #ok_actions          = ["${aws_sns_topic.alarm.arn}"]
  dimensions = {
    AvailabilityZone =  var.Evelyn2_prod_Availability_zone_elb [count.index]
    LoadBalancer = var.LB_Evelyn2_cribl_elb[count.index]
  }
}
# alarm for cribl-internal
resource "aws_cloudwatch_metric_alarm" "elb5xx_Zone_1a_cribl_Internal_elb" {
  count               = length(var.Evelyn2_cribl_Internal_ELB_Alarm_Name_elb)
  alarm_name          = var.Evelyn2_cribl_Internal_ELB_Alarm_Name_elb[count.index]
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  datapoints_to_alarm = "1"
  metric_name         = "HTTPCode_ELB_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = "900"
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"
  threshold           = "50"
  alarm_description   = "ELB5xxx count in last 15min"
  actions_enabled     = "true"
 # alarm_actions       = ["${aws_sns_topic.alarm.arn}"]
 # ok_actions          = ["${aws_sns_topic.alarm.arn}"]
  dimensions = {
    AvailabilityZone =  var.Evelyn2_prod_Availability_zone_elb [count.index]
    LoadBalancer = var.LB_Evelyn2_cribl_Internal[count.index]
  }
}
##############################################

# # alarm for ELB/NLB
#sh
resource "aws_cloudwatch_metric_alarm" "elb4xx_Zone_1a_elb_sh" {
  count               = length(var.Evelyn2_sh_ELB_Alarm_Name_4xx_elb)
  alarm_name          = var.Evelyn2_sh_ELB_Alarm_Name_4xx_elb[count.index]
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  datapoints_to_alarm = "1"
  metric_name         = "HTTPCode_ELB_4XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = "900"
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"
  threshold           = "50"
  alarm_description   = "ELB5xxx count in last 15min"
  actions_enabled     = "true"
  #alarm_actions       = ["${aws_sns_topic.alarm.arn}"]
  #ok_actions          = ["${aws_sns_topic.alarm.arn}"]
  dimensions = {
    AvailabilityZone =  var.Evelyn2_prod_Availability_zone_4xx_elb[count.index]
    LoadBalancer = var.LB_Evelyn2_sh_4xx_elb[count.index]
  }
}
#cribl
resource "aws_cloudwatch_metric_alarm" "elb4xx_Zone_1a_elb_cribl" {
  count               = length(var.Evelyn2_cribl_ELB_Alarm_Name_4xx_elb)
  alarm_name          = var.Evelyn2_cribl_ELB_Alarm_Name_4xx_elb[count.index]
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  datapoints_to_alarm = "1"
  metric_name         = "HTTPCode_ELB_4XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = "900"
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"
  threshold           = "50"
  alarm_description   = "ELB5xxx count in last 15min"
  actions_enabled     = "true"
  #alarm_actions       = ["${aws_sns_topic.alarm.arn}"]
  #ok_actions          = ["${aws_sns_topic.alarm.arn}"]
  dimensions = {
    AvailabilityZone =  var.Evelyn2_prod_Availability_zone_4xx_elb[count.index]
    LoadBalancer = var.LB_Evelyn2_cribl_4xx_elb[count.index]
  }
}

# alarm for cribl-internal
resource "aws_cloudwatch_metric_alarm" "elb4xx_Zone_1a_cribl_Internal_elb" {
  count               = length(var.Evelyn2_cribl_Internal_ELB_Alarm_Name_4xx_elb)
  alarm_name          = var.Evelyn2_cribl_Internal_ELB_Alarm_Name_4xx_elb[count.index]
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  datapoints_to_alarm = "1"
  metric_name         = "HTTPCode_ELB_4XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = "900"
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"
  threshold           = "50"
  alarm_description   = "ELB5xxx count in last 15min"
  actions_enabled     = "true"
 # alarm_actions       = ["${aws_sns_topic.alarm.arn}"]
 # ok_actions          = ["${aws_sns_topic.alarm.arn}"]
  dimensions = {
    AvailabilityZone =  var.Evelyn2_prod_Availability_zone_4xx_elb[count.index]
    LoadBalancer = var.LB_Evelyn2_cribl_Internal_4xx_elb[count.index]
  }
}
##########################################################################################
##########################################################################################
##########################################################################################
########################################################################################## 
#  ELB target Resoponse time.
#sh 
resource "aws_cloudwatch_metric_alarm" "elb_trt_sh" {
  count               = length(var.Evelyn2_sh_ELB_Alarm_Name_trt)
  alarm_name          = var.Evelyn2_sh_ELB_Alarm_Name_trt
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  datapoints_to_alarm = "5"
  metric_name         = "TargetResponseTime"
  namespace           = "AWS/ApplicationELB"
  period              = "900"
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"
  threshold           = "1"
  alarm_description   = "ELB5xxx count in last 15min"
  actions_enabled     = "true"
  #alarm_actions       = ["${aws_sns_topic.alarm.arn}"]
  #ok_actions          = ["${aws_sns_topic.alarm.arn}"]
  dimensions = {
    AvailabilityZone =  var.Evelyn2_prod_Availability_zone_trt[]
    LoadBalancer = var.LB_Evelyn2_sh_trt
  }
}

# cribl
resource "aws_cloudwatch_metric_alarm" "elb_trt_cribl" {
  count               = length(var.Evelyn2_cribl_ELB_Alarm_Name_trt)
  alarm_name          = var.Evelyn2_cribl_ELB_Alarm_Name_trt
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  datapoints_to_alarm = "5"
  metric_name         = "TargetResponseTime"
  namespace           = "AWS/ApplicationELB"
  period              = "900"
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"
  threshold           = "1"
  alarm_description   = "ELB5xxx count in last 15min"
  actions_enabled     = "true"
  #alarm_actions       = ["${aws_sns_topic.alarm.arn}"]
  #ok_actions          = ["${aws_sns_topic.alarm.arn}"]
  dimensions = {
    AvailabilityZone =  var.Evelyn2_prod_Availability_zone_trt
    LoadBalancer = var.LB_Evelyn2_cribl_trt
  }
}

#cribl-internal
#===========
resource "aws_cloudwatch_metric_alarm" "elb_trt_cribl_internal" {
  count               = length(var.Evelyn2_cribl_Internal_ELB_Alarm_Name_trt)
  alarm_name          = var.Evelyn2_cribl_Internal_ELB_Alarm_Name_trt
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  datapoints_to_alarm = "5"
  metric_name         = "TargetResponseTime"
  namespace           = "AWS/ApplicationELB"
  period              = "900"
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"
  threshold           = "1"
  alarm_description   = "ELBtrt count in last 15min"
  actions_enabled     = "true"
 # alarm_actions       = ["${aws_sns_topic.alarm.arn}"]
 # ok_actions          = ["${aws_sns_topic.alarm.arn}"]
  dimensions = {
    AvailabilityZone =  var.Evelyn2_prod_Availability_zone_trt
    LoadBalancer = var.LB_Evelyn2_cribl_Internal_trt
  }
}