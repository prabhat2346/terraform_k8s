#+++++++++++++++++++++++++++
#+++++ CPU UTILIZATION +++++
#+++++++++++++++++++++++++++

#---------- CPU UTILIZATION (WARNING) ----------
resource "aws_cloudwatch_metric_alarm" "cpu_alarm_warning" {
  for_each = var.prod_cpu_alarms_warning
  alarm_name          = each.value.alarm_name
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "10"
  datapoints_to_alarm = "8"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 50
  alarm_description   = "This metric monitors ec2 cpu utilization"
  dimensions = {
    InstanceId = each.value.instance_id
  }
 }
#---------- CPU UTILIZATION (HIGH) ----------
resource "aws_cloudwatch_metric_alarm" "cpu_alarm_high" {
  for_each = var.prod_cpu_alarms_high
  alarm_name          = each.value.alarm_name
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "10"
  datapoints_to_alarm = "8"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "This metric monitors ec2 cpu utilization"
  dimensions = {
    InstanceId = each.value.instance_id
  }
 }

#++++++++++++++++++++++++
#+++++ MEMORY USAGE +++++
#++++++++++++++++++++++++

#---------- MEMORY USAGE (WARNING) ----------
 resource "aws_cloudwatch_metric_alarm" "memory_alarm_warning" {
  for_each = var.prod_memory_alarms_warning
  alarm_name          = each.value.alarm_name
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "10"
  datapoints_to_alarm = "8"
  metric_name         = "mem_used_percent"
  namespace           = "CWAgent"
  period              = 60
  statistic           = "Average"
  threshold           = 50
  alarm_description   = "This metric monitors ec2 memory uses."
  dimensions = {
    InstanceId = each.value.instance_id
    ImageId      = "ami-0bcc094591f354be2"
    InstanceType = each.value.InstanceType
  }
 }
#---------- MEMORY USAGE (HIGH) ----------
 resource "aws_cloudwatch_metric_alarm" "memory_alarm_high" {
  for_each = var.prod_memory_alarms_high
  alarm_name          = each.value.alarm_name
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "10"
  datapoints_to_alarm = "8"
  metric_name         = "mem_used_percent"
  namespace           = "CWAgent"
  period              = 60
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "This metric monitors ec2 memory uses."
  dimensions = {
    InstanceId = each.value.instance_id
    ImageId      = "ami-0bcc094591f354be2"
    InstanceType = each.value.InstanceType
  }
 }

#++++++++++++++++++++++++++++
#+++++ DISK UTILIZATION +++++
#++++++++++++++++++++++++++++

#---------- DISK (ROOT) (WARNING) ----------
 resource "aws_cloudwatch_metric_alarm" "disk_root_alarms_warning" {
 for_each             = var.prod_disk_root_alarms_warning
  alarm_name          = each.value.alarm_name
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "10"
  datapoints_to_alarm = "8"
  metric_name         = "disk_used_percent"
  namespace           = "CWAgent"
  period              = "60"
  statistic           = "Average"
  threshold           = "50"
  alarm_description   = "This metric monitors ec2 disk utilization"
  dimensions = {
    path         = "/"
    InstanceId   = each.value.instance_id
    ImageId      = "ami-0bcc094591f354be2"
    InstanceType = each.value.InstanceType
    device       = each.value.device
    fstype       = "ext4"

  }
 }
#---------- DISK (ROOT) (HIGH) ------------
 resource "aws_cloudwatch_metric_alarm" "disk_root_alarms_high" {
 for_each             = var.prod_disk_root_alarms_high
  alarm_name          = each.value.alarm_name
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "10"
  datapoints_to_alarm = "8"
  metric_name         = "disk_used_percent"
  namespace           = "CWAgent"
  period              = "60"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric monitors ec2 disk utilization"
  dimensions = {
    path         = "/"
    InstanceId   = each.value.instance_id
    ImageId      = "ami-0bcc094591f354be2"
    InstanceType = each.value.InstanceType
    device       = each.value.device
    fstype       = "ext4"

  }
 }
#----------  DISK (OPT) (WARNING) #----------
 resource "aws_cloudwatch_metric_alarm" "disk_opt_alarms_warning" {
 for_each             = var.prod_disk_opt_alarms_warning
  alarm_name          = each.value.alarm_name
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "10"
  datapoints_to_alarm = "8"
  metric_name         = "disk_used_percent"
  namespace           = "CWAgent"
  period              = "60"
  statistic           = "Average"
  threshold           = "50"
  alarm_description   = "This metric monitors ec2 disk utilization"
  dimensions = {
    path         = "/opt"
    InstanceId   = each.value.instance_id
    ImageId      = "ami-0bcc094591f354be2"
    InstanceType = each.value.InstanceType
    device       = each.value.device
    fstype       = "ext4"

  }
}
#----------  DISK (OPT) (HIGH) ----------
 resource "aws_cloudwatch_metric_alarm" "disk_opt_alarms_high" {
 for_each             = var.prod_disk_opt_alarms_high
  alarm_name          = each.value.alarm_name
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "10"
  datapoints_to_alarm = "8"
  metric_name         = "disk_used_percent"
  namespace           = "CWAgent"
  period              = "60"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric monitors ec2 disk utilization"
  dimensions = {
    path         = "/opt"
    InstanceId   = each.value.instance_id
    ImageId      = "ami-0bcc094591f354be2"
    InstanceType = each.value.InstanceType
    device       = each.value.device
    fstype       = "ext4"

  }
}
#---------- DISK (VAR) (WARNING) ----------
resource "aws_cloudwatch_metric_alarm" "disk_var_alarms_warning" {
 for_each             = var.prod_disk_var_alarms_warning
  alarm_name          = each.value.alarm_name
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "10"
  datapoints_to_alarm = "8"
  metric_name         = "disk_used_percent"
  namespace           = "CWAgent"
  period              = "60"
  statistic           = "Average"
  threshold           = "50"
  alarm_description   = "This metric monitors ec2 disk utilization"
  dimensions = {
    path         = "/opt/splunk/var"
    InstanceId   = each.value.instance_id
    ImageId      = "ami-0bcc094591f354be2"
    InstanceType = each.value.InstanceType
    device       = each.value.device
    fstype       = "ext4"

  }
}
#---------- DISK (VAR) (HIGH) ----------
resource "aws_cloudwatch_metric_alarm" "disk_var_alarms_high" {
 for_each             = var.prod_disk_var_alarms_high
  alarm_name          = each.value.alarm_name
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "10"
  datapoints_to_alarm = "8"
  metric_name         = "disk_used_percent"
  namespace           = "CWAgent"
  period              = "60"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric monitors ec2 disk utilization"
  dimensions = {
    path         = "/opt/splunk/var"
    InstanceId   = each.value.instance_id
    ImageId      = "ami-0bcc094591f354be2"
    InstanceType = each.value.InstanceType
    device       = each.value.device
    fstype       = "ext4"

  }
}

#++++++++++++++++++++++++++++++++
#+++++ ELB TG HEALTH STATUS +++++
#++++++++++++++++++++++++++++++++
#----- SH -----
resource "aws_cloudwatch_metric_alarm" "elb_tght_sh" {
  for_each            = var.prod_elb_tght_sh
  alarm_name          = each.value.alarm_name
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  datapoints_to_alarm = "2"
  metric_name         = "UnHealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = "60"
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"
  threshold           = "0"
  alarm_description   = "ELB5XXx count in last 15min"
  actions_enabled     = "true"
  dimensions = {
    TargetGroup =  each.value.tg
    LoadBalancer = each.value.lb
  }
}
#----- CRIBL -----
resource "aws_cloudwatch_metric_alarm" "elb_tght_cribl" {
  for_each            = var.prod_elb_tght_cribl
  alarm_name          = each.value.alarm_name
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  datapoints_to_alarm = "2"
  metric_name         = "UnHealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = "60"
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"
  threshold           = "0"
  alarm_description   = "ELB5XXx count in last 15min"
  actions_enabled     = "true"
  dimensions = {
    TargetGroup =  each.value.tg
    LoadBalancer = each.value.lb
  }
}
#----- CRIBL-INTERNAL -----
resource "aws_cloudwatch_metric_alarm" "elb_tght_cribl_internal" {
  for_each            = var.prod_elb_tght_cribl_internal
  alarm_name          = each.value.alarm_name
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  datapoints_to_alarm = "2"
  metric_name         = "UnHealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = "60"
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"
  threshold           = "0"
  alarm_description   = "ELB5XXx count in last 15min"
  actions_enabled     = "true"
  dimensions = {
    TargetGroup =  each.value.tg
    LoadBalancer = each.value.lb
  }
}

#+++++++++++++++++++++++++++++++++++++
#+++++ ELB target Resoponse time +++++
#+++++++++++++++++++++++++++++++++++++
#----- SH -----
resource "aws_cloudwatch_metric_alarm" "elb_trt_sh" {
  for_each            = var.prod_elb_trt_sh
  alarm_name          = each.value.alarm_name
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  datapoints_to_alarm = "5"
  metric_name         = "TargetResponseTime"
  namespace           = "AWS/ApplicationELB"
  period              = "900"
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"
  threshold           = "1"
  alarm_description   = "ELB5XXx count in last 15min"
  actions_enabled     = "true"
  dimensions = {
    AvailabilityZone =  each.value.az
    LoadBalancer = each.value.lb
  }
}
#----- CRIBL -----
resource "aws_cloudwatch_metric_alarm" "elb_trt_cribl" {
  for_each            = var.prod_elb_trt_cribl
  alarm_name          = each.value.alarm_name
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  datapoints_to_alarm = "5"
  metric_name         = "TargetResponseTime"
  namespace           = "AWS/ApplicationELB"
  period              = "900"
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"
  threshold           = "1"
  alarm_description   = "ELB5XXx count in last 15min"
  actions_enabled     = "true"
  dimensions = {
    AvailabilityZone =  each.value.az
    LoadBalancer = each.value.lb
  }
}
#----- CRIBL-INTERNAL -----
resource "aws_cloudwatch_metric_alarm" "elb_trt_cribl_internal" {
  for_each            = var.prod_elb_trt_cribl_internal
  alarm_name          = each.value.alarm_name
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  datapoints_to_alarm = "5"
  metric_name         = "TargetResponseTime"
  namespace           = "AWS/ApplicationELB"
  period              = "900"
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"
  threshold           = "1"
  alarm_description   = "ELB5XXx count in last 15min"
  actions_enabled     = "true"
  dimensions = {
    AvailabilityZone =  each.value.az
    LoadBalancer = each.value.lb
  }
}
#++++++++++++++++++++++++++
#+++++ ELB Target 4XX +++++
#++++++++++++++++++++++++++
#----- SH -----
resource "aws_cloudwatch_metric_alarm" "elb_target_4XX_sh" {
  for_each            = var.prod_elb_target_4XX_sh
  alarm_name          = each.value.alarm_name
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  datapoints_to_alarm = "1"
  metric_name         = "HTTPCode_Target_4XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = "900"
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"
  threshold           = "50"
  alarm_description   = "ELB5XXx count in last 15min"
  actions_enabled     = "true"
  dimensions = {
    AvailabilityZone =  each.value.az
    LoadBalancer = each.value.lb
  }
}
#----- CRIBL -----
resource "aws_cloudwatch_metric_alarm" "elb_target_4XX_cribl" {
  for_each            = var.prod_elb_target_4XX_cribl
  alarm_name          = each.value.alarm_name
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  datapoints_to_alarm = "1"
  metric_name         = "HTTPCode_Target_4XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = "900"
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"
  threshold           = "50"
  alarm_description   = "ELB5XXx count in last 15min"
  actions_enabled     = "true"
  dimensions = {
    AvailabilityZone =  each.value.az
    LoadBalancer = each.value.lb
  }
}
#----- CRIBL-INTERNAL -----
resource "aws_cloudwatch_metric_alarm" "elb_target_4XX_cribl_internal" {
  for_each            = var.prod_elb_target_4XX_cribl_internal
  alarm_name          = each.value.alarm_name
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  datapoints_to_alarm = "1"
  metric_name         = "HTTPCode_Target_4XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = "900"
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"
  threshold           = "50"
  alarm_description   = "ELB5XXx count in last 15min"
  actions_enabled     = "true"
  dimensions = {
    AvailabilityZone =  each.value.az
    LoadBalancer = each.value.lb
  }
}

#++++++++++++++++++++++++++
#+++++ ELB Target 5XX +++++
#++++++++++++++++++++++++++
#----- SH -----
resource "aws_cloudwatch_metric_alarm" "elb_target_5XX_sh" {
  for_each            = var.prod_elb_target_5XX_sh
  alarm_name          = each.value.alarm_name
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  datapoints_to_alarm = "1"
  metric_name         = "HTTPCode_Target_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = "900"
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"
  threshold           = "50"
  alarm_description   = "ELB5XXx count in last 15min"
  actions_enabled     = "true"
  dimensions = {
    AvailabilityZone =  each.value.az
    LoadBalancer = each.value.lb
  }
}
#----- CRIBL -----
resource "aws_cloudwatch_metric_alarm" "elb_target_5XX_cribl" {
  for_each            = var.prod_elb_target_5XX_cribl
  alarm_name          = each.value.alarm_name
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  datapoints_to_alarm = "1"
  metric_name         = "HTTPCode_Target_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = "900"
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"
  threshold           = "50"
  alarm_description   = "ELB5XXx count in last 15min"
  actions_enabled     = "true"
  dimensions = {
    AvailabilityZone =  each.value.az
    LoadBalancer = each.value.lb
  }
}
#----- CRIBL-INTERNAL -----
resource "aws_cloudwatch_metric_alarm" "elb_target_5XX_cribl_internal" {
  for_each            = var.prod_elb_target_5XX_cribl_internal
  alarm_name          = each.value.alarm_name
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  datapoints_to_alarm = "1"
  metric_name         = "HTTPCode_Target_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = "900"
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"
  threshold           = "50"
  alarm_description   = "ELB5XXx count in last 15min"
  actions_enabled     = "true"
  dimensions = {
    AvailabilityZone =  each.value.az
    LoadBalancer = each.value.lb
  }
}

#+++++++++++++++++++++++
#+++++ ELB ELB 4XX +++++
#+++++++++++++++++++++++
#----- SH -----
resource "aws_cloudwatch_metric_alarm" "elb_elb_4XX_sh" {
  for_each            = var.prod_elb_elb_4XX_sh
  alarm_name          = each.value.alarm_name
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  datapoints_to_alarm = "1"
  metric_name         = "HTTPCode_ELB_4XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = "900"
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"
  threshold           = "50"
  alarm_description   = "ELB5XXx count in last 15min"
  actions_enabled     = "true"
  dimensions = {
    AvailabilityZone =  each.value.az
    LoadBalancer = each.value.lb
  }
}
#----- CRIBL -----
resource "aws_cloudwatch_metric_alarm" "elb_elb_4XX_cribl" {
  for_each            = var.prod_elb_elb_4XX_cribl
  alarm_name          = each.value.alarm_name
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  datapoints_to_alarm = "1"
  metric_name         = "HTTPCode_ELB_4XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = "900"
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"
  threshold           = "50"
  alarm_description   = "ELB5XXx count in last 15min"
  actions_enabled     = "true"
  dimensions = {
    AvailabilityZone =  each.value.az
    LoadBalancer = each.value.lb
  }
}
#----- CRIBL-INTERNAL -----
resource "aws_cloudwatch_metric_alarm" "elb_elb_4XX_cribl_internal" {
  for_each            = var.prod_elb_elb_4XX_cribl_internal
  alarm_name          = each.value.alarm_name
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  datapoints_to_alarm = "1"
  metric_name         = "HTTPCode_ELB_4XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = "900"
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"
  threshold           = "50"
  alarm_description   = "ELB5XXx count in last 15min"
  actions_enabled     = "true"
  dimensions = {
    AvailabilityZone =  each.value.az
    LoadBalancer = each.value.lb
  }
}
#+++++++++++++++++++++++
#+++++ ELB ELB 5XX +++++
#+++++++++++++++++++++++
#----- SH -----
resource "aws_cloudwatch_metric_alarm" "elb_elb_5XX_sh" {
  for_each            = var.prod_elb_elb_5XX_sh
  alarm_name          = each.value.alarm_name
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  datapoints_to_alarm = "1"
  metric_name         = "HTTPCode_ELB_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = "900"
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"
  threshold           = "50"
  alarm_description   = "ELB5XXx count in last 15min"
  actions_enabled     = "true"
  dimensions = {
    AvailabilityZone =  each.value.az
    LoadBalancer = each.value.lb
  }
}
#----- CRIBL -----
resource "aws_cloudwatch_metric_alarm" "elb_elb_5XX_cribl" {
  for_each            = var.prod_elb_elb_5XX_cribl
  alarm_name          = each.value.alarm_name
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  datapoints_to_alarm = "1"
  metric_name         = "HTTPCode_ELB_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = "900"
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"
  threshold           = "50"
  alarm_description   = "ELB5XXx count in last 15min"
  actions_enabled     = "true"
  dimensions = {
    AvailabilityZone =  each.value.az
    LoadBalancer = each.value.lb
  }
}
#----- CRIBL-INTERNAL -----
resource "aws_cloudwatch_metric_alarm" "elb_elb_5XX_cribl_internal" {
  for_each            = var.prod_elb_elb_5XX_cribl_internal
  alarm_name          = each.value.alarm_name
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  datapoints_to_alarm = "1"
  metric_name         = "HTTPCode_ELB_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = "900"
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"
  threshold           = "50"
  alarm_description   = "ELB5XXx count in last 15min"
  actions_enabled     = "true"
  dimensions = {
    AvailabilityZone =  each.value.az
    LoadBalancer = each.value.lb
  }
}