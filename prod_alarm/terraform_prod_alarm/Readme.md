
This code demonstrates how to use for_each.
### To run
```
terraform init
terraform plan -var-file="prod.tfvars"
```

Notice that the plan output is

```
An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_cloudwatch_metric_alarm.disk_var_alarms["evelyn2_prod_warning_sh_1_a"] will be created
  + resource "aws_cloudwatch_metric_alarm" "disk_var_alarms" {
      + actions_enabled                       = true
      + alarm_description                     = "This metric monitors ec2 disk utilization"
      + alarm_name                            = "Evelyn2_Prod - Warning - Disk Utilization (var) - A - (SH-1)"
      + arn                                   = (known after apply)
      + comparison_operator                   = "GreaterThanOrEqualToThreshold"
      + datapoints_to_alarm                   = 8
      + dimensions                            = {
          + "ImageId"      = "ami-0bcc094591f354be2"
          + "InstanceId"   = "i-0405cfd6b155814ad"
          + "InstanceType" = "c5.2xlarge"
          + "device"       = "nvme1n1"
          + "fstype"       = "ext4"
          + "path"         = "/opt/splunk/var"
        }
      + evaluate_low_sample_count_percentiles = (known after apply)
      + evaluation_periods                    = 10
      + id                                    = (known after apply)
      + metric_name                           = "disk_used_percent"
      + namespace                             = "CWAgent"
      + period                                = 60
      + statistic                             = "Average"
      + threshold                             = 50
      + treat_missing_data                    = "missing"
    }

  # aws_cloudwatch_metric_alarm.disk_var_alarms["evelyn2_prod_warning_sh_1b"] will be created
  + resource "aws_cloudwatch_metric_alarm" "disk_var_alarms" {
      + actions_enabled                       = true
      + alarm_description                     = "This metric monitors ec2 disk utilization"
      + alarm_name                            = "Evelyn2_Prod - Warning - Disk Utilization (var) - B - (SH-1)"
      + arn                                   = (known after apply)
      + comparison_operator                   = "GreaterThanOrEqualToThreshold"
      + datapoints_to_alarm                   = 8
      + dimensions                            = {
          + "ImageId"      = "ami-0bcc094591f354be2"
          + "InstanceId"   = "i-0405cfd6b155814ad"
          + "InstanceType" = "c5.2xlarge"
          + "device"       = "nvme1n1"
          + "fstype"       = "ext4"
          + "path"         = "/opt/splunk/var"
        }
      + evaluate_low_sample_count_percentiles = (known after apply)
      + evaluation_periods                    = 10
      + id                                    = (known after apply)
      + metric_name                           = "disk_used_percent"
      + namespace                             = "CWAgent"
      + period                                = 60
      + statistic                             = "Average"
      + threshold                             = 50
      + treat_missing_data                    = "missing"
    }

  # aws_cloudwatch_metric_alarm.disk_var_alarms["evelyn2_prod_warning_sh_2_a"] will be created
  + resource "aws_cloudwatch_metric_alarm" "disk_var_alarms" {
      + actions_enabled                       = true
      + alarm_description                     = "This metric monitors ec2 disk utilization"
      + alarm_name                            = "Evelyn2_Prod - Warning - Disk Utilization (var) - A - (SH-2)"
      + arn                                   = (known after apply)
      + comparison_operator                   = "GreaterThanOrEqualToThreshold"
      + datapoints_to_alarm                   = 8
      + dimensions                            = {
          + "ImageId"      = "ami-0bcc094591f354be2"
          + "InstanceId"   = "i-0405cfd6b155814ad"
          + "InstanceType" = "c5.2xlarge"
          + "device"       = "nvme1n1"
          + "fstype"       = "ext4"
          + "path"         = "/opt/splunk/var"
        }
      + evaluate_low_sample_count_percentiles = (known after apply)
      + evaluation_periods                    = 10
      + id                                    = (known after apply)
      + metric_name                           = "disk_used_percent"
      + namespace                             = "CWAgent"
      + period                                = 60
      + statistic                             = "Average"
      + threshold                             = 50
      + treat_missing_data                    = "missing"
    }

  # aws_cloudwatch_metric_alarm.disk_var_alarms["evelyn2_prod_warning_sh_2b"] will be created
  + resource "aws_cloudwatch_metric_alarm" "disk_var_alarms" {
      + actions_enabled                       = true
      + alarm_description                     = "This metric monitors ec2 disk utilization"
      + alarm_name                            = "Evelyn2_Prod - Warning - Disk Utilization (var) - B - (SH-2)"
      + arn                                   = (known after apply)
      + comparison_operator                   = "GreaterThanOrEqualToThreshold"
      + datapoints_to_alarm                   = 8
      + dimensions                            = {
          + "ImageId"      = "ami-0bcc094591f354be2"
          + "InstanceId"   = "i-0405cfd6b155814ad"
          + "InstanceType" = "c5.2xlarge"
          + "device"       = "nvme1n1"
          + "fstype"       = "ext4"
          + "path"         = "/opt/splunk/var"
        }
      + evaluate_low_sample_count_percentiles = (known after apply)
      + evaluation_periods                    = 10
      + id                                    = (known after apply)
      + metric_name                           = "disk_used_percent"
      + namespace                             = "CWAgent"
      + period                                = 60
      + statistic                             = "Average"
      + threshold                             = 50
      + treat_missing_data                    = "missing"
    }

  # aws_cloudwatch_metric_alarm.memory_alarm["evelyn2_prod_High_cm"] will be created
  + resource "aws_cloudwatch_metric_alarm" "memory_alarm" {
      + actions_enabled                       = true
      + alarm_description                     = "This metric monitors ec2 memory uses."
      + alarm_name                            = "Evelyn2_Prod - High - Memory Usage - O - (CM)"
      + arn                                   = (known after apply)
      + comparison_operator                   = "GreaterThanOrEqualToThreshold"
      + datapoints_to_alarm                   = 8
      + dimensions                            = {
          + "ImageId"      = "ami-0bcc094591f354be2"
          + "InstanceId"   = "i-09458c6f9b151e67a"
          + "InstanceType" = "c5.large"
        }
      + evaluate_low_sample_count_percentiles = (known after apply)
      + evaluation_periods                    = 10
      + id                                    = (known after apply)
      + metric_name                           = "mem_used_percent"
      + namespace                             = "CWAgent"
      + period                                = 60
      + statistic                             = "Average"
      + threshold                             = 50
      + treat_missing_data                    = "missing"
    }

  # aws_cloudwatch_metric_alarm.memory_alarm["evelyn2_prod_High_cribl_1"] will be created
  + resource "aws_cloudwatch_metric_alarm" "memory_alarm" {
      + actions_enabled                       = true
      + alarm_description                     = "This metric monitors ec2 memory uses."
      + alarm_name                            = "Evelyn2_Prod - High - Memory Usage - A - (Cribl-1)"
      + arn                                   = (known after apply)
      + comparison_operator                   = "GreaterThanOrEqualToThreshold"
      + datapoints_to_alarm                   = 8
      + dimensions                            = {
          + "ImageId"      = "ami-0bcc094591f354be2"
          + "InstanceId"   = "i-0405cfd6b155814ad"
          + "InstanceType" = "c5.xlarge"
        }
      + evaluate_low_sample_count_percentiles = (known after apply)
      + evaluation_periods                    = 10
      + id                                    = (known after apply)
      + metric_name                           = "mem_used_percent"
      + namespace                             = "CWAgent"
      + period                                = 60
      + statistic                             = "Average"
      + threshold                             = 50
      + treat_missing_data                    = "missing"
    }

  # aws_cloudwatch_metric_alarm.memory_alarm["evelyn2_prod_High_cribl_1_b"] will be created
  + resource "aws_cloudwatch_metric_alarm" "memory_alarm" {
      + actions_enabled                       = true
      + alarm_description                     = "This metric monitors ec2 memory uses."
      + alarm_name                            = "Evelyn2_Prod - High - Memory Usage - B - (Cribl-1)"
      + arn                                   = (known after apply)
      + comparison_operator                   = "GreaterThanOrEqualToThreshold"
      + datapoints_to_alarm                   = 8
      + dimensions                            = {
          + "ImageId"      = "ami-0bcc094591f354be2"
          + "InstanceId"   = "i-0405cfd6b155814ad"
          + "InstanceType" = "c5.xlarge"
        }
      + evaluate_low_sample_count_percentiles = (known after apply)
      + evaluation_periods                    = 10
      + id                                    = (known after apply)
      + metric_name                           = "mem_used_percent"
      + namespace                             = "CWAgent"
      + period                                = 60
      + statistic                             = "Average"
      + threshold                             = 50
      + treat_missing_data                    = "missing"
    }

  # aws_cloudwatch_metric_alarm.memory_alarm["evelyn2_prod_High_dm"] will be created
  + resource "aws_cloudwatch_metric_alarm" "memory_alarm" {
      + actions_enabled                       = true
      + alarm_description                     = "This metric monitors ec2 memory uses."
      + alarm_name                            = "Evelyn2_Prod - High - Memory Usage - O - (DM)"
      + arn                                   = (known after apply)
      + comparison_operator                   = "GreaterThanOrEqualToThreshold"
      + datapoints_to_alarm                   = 8
      + dimensions                            = {
          + "ImageId"      = "ami-0bcc094591f354be2"
          + "InstanceId"   = "i-0405cfd6b155814ad"
          + "InstanceType" = "c5.large"
        }
      + evaluate_low_sample_count_percentiles = (known after apply)
      + evaluation_periods                    = 10
      + id                                    = (known after apply)
      + metric_name                           = "mem_used_percent"
      + namespace                             = "CWAgent"
      + period                                = 60
      + statistic                             = "Average"
      + threshold                             = 50
      + treat_missing_data                    = "missing"
    }

  # aws_cloudwatch_metric_alarm.memory_alarm["evelyn2_prod_High_ds"] will be created
  + resource "aws_cloudwatch_metric_alarm" "memory_alarm" {
      + actions_enabled                       = true
      + alarm_description                     = "This metric monitors ec2 memory uses."
      + alarm_name                            = "Evelyn2_Prod - High - Memory Usage - O - (DS)"
      + arn                                   = (known after apply)
      + comparison_operator                   = "GreaterThanOrEqualToThreshold"
      + datapoints_to_alarm                   = 8
      + dimensions                            = {
          + "ImageId"      = "ami-0bcc094591f354be2"
          + "InstanceId"   = "i-0223a28edb48be4e4"
          + "InstanceType" = "c5.large"
        }
      + evaluate_low_sample_count_percentiles = (known after apply)
      + evaluation_periods                    = 10
      + id                                    = (known after apply)
      + metric_name                           = "mem_used_percent"
      + namespace                             = "CWAgent"
      + period                                = 60
      + statistic                             = "Average"
      + threshold                             = 50
      + treat_missing_data                    = "missing"
    }

  # aws_cloudwatch_metric_alarm.memory_alarm["evelyn2_prod_High_idx_1a"] will be created
  + resource "aws_cloudwatch_metric_alarm" "memory_alarm" {
      + actions_enabled                       = true
      + alarm_description                     = "This metric monitors ec2 memory uses."
      + alarm_name                            = "Evelyn2_Prod - High - Memory Usage - A - (IDX-1)"
      + arn                                   = (known after apply)
      + comparison_operator                   = "GreaterThanOrEqualToThreshold"
      + datapoints_to_alarm                   = 8
      + dimensions                            = {
          + "ImageId"      = "ami-0bcc094591f354be2"
          + "InstanceId"   = "i-0405cfd6b155814ad"
          + "InstanceType" = "c5.xlarge"
        }
      + evaluate_low_sample_count_percentiles = (known after apply)
      + evaluation_periods                    = 10
      + id                                    = (known after apply)
      + metric_name                           = "mem_used_percent"
      + namespace                             = "CWAgent"
      + period                                = 60
      + statistic                             = "Average"
      + threshold                             = 50
      + treat_missing_data                    = "missing"
    }

  # aws_cloudwatch_metric_alarm.memory_alarm["evelyn2_prod_High_idx_1b"] will be created
  + resource "aws_cloudwatch_metric_alarm" "memory_alarm" {
      + actions_enabled                       = true
      + alarm_description                     = "This metric monitors ec2 memory uses."
      + alarm_name                            = "Evelyn2_Prod - High - Memory Usage - B - (IDX-1"
      + arn                                   = (known after apply)
      + comparison_operator                   = "GreaterThanOrEqualToThreshold"
      + datapoints_to_alarm                   = 8
      + dimensions                            = {
          + "ImageId"      = "ami-0bcc094591f354be2"
          + "InstanceId"   = "i-0405cfd6b155814ad"
          + "InstanceType" = "c5.xlarge"
        }
      + evaluate_low_sample_count_percentiles = (known after apply)
      + evaluation_periods                    = 10
      + id                                    = (known after apply)
      + metric_name                           = "mem_used_percent"
      + namespace                             = "CWAgent"
      + period                                = 60
      + statistic                             = "Average"
      + threshold                             = 50
      + treat_missing_data                    = "missing"
    }

  # aws_cloudwatch_metric_alarm.memory_alarm["evelyn2_prod_High_idx_2a"] will be created
  + resource "aws_cloudwatch_metric_alarm" "memory_alarm" {
      + actions_enabled                       = true
      + alarm_description                     = "This metric monitors ec2 memory uses."
      + alarm_name                            = "Evelyn2_Prod - High - Memory Usage - A - (IDX-2)"
      + arn                                   = (known after apply)
      + comparison_operator                   = "GreaterThanOrEqualToThreshold"
      + datapoints_to_alarm                   = 8
      + dimensions                            = {
          + "ImageId"      = "ami-0bcc094591f354be2"
          + "InstanceId"   = "i-0405cfd6b155814ad"
          + "InstanceType" = "c5.xlarge"
        }
      + evaluate_low_sample_count_percentiles = (known after apply)
      + evaluation_periods                    = 10
      + id                                    = (known after apply)
      + metric_name                           = "mem_used_percent"
      + namespace                             = "CWAgent"
      + period                                = 60
      + statistic                             = "Average"
      + threshold                             = 50
      + treat_missing_data                    = "missing"
    }

  # aws_cloudwatch_metric_alarm.memory_alarm["evelyn2_prod_High_idx_2b"] will be created
  + resource "aws_cloudwatch_metric_alarm" "memory_alarm" {
      + actions_enabled                       = true
      + alarm_description                     = "This metric monitors ec2 memory uses."
      + alarm_name                            = "Evelyn2_Prod - High - Memory Usage - B - (IDX-2)"
      + arn                                   = (known after apply)
      + comparison_operator                   = "GreaterThanOrEqualToThreshold"
      + datapoints_to_alarm                   = 8
      + dimensions                            = {
          + "ImageId"      = "ami-0bcc094591f354be2"
          + "InstanceId"   = "i-0405cfd6b155814ad"
          + "InstanceType" = "c5.xlarge"
        }
      + evaluate_low_sample_count_percentiles = (known after apply)
      + evaluation_periods                    = 10
      + id                                    = (known after apply)
      + metric_name                           = "mem_used_percent"
      + namespace                             = "CWAgent"
      + period                                = 60
      + statistic                             = "Average"
      + threshold                             = 50
      + treat_missing_data                    = "missing"
    }

  # aws_cloudwatch_metric_alarm.memory_alarm["evelyn2_prod_High_idx_3a"] will be created
  + resource "aws_cloudwatch_metric_alarm" "memory_alarm" {
      + actions_enabled                       = true
      + alarm_description                     = "This metric monitors ec2 memory uses."
      + alarm_name                            = "Evelyn2_Prod - High - Memory Usage - A - (IDX-3)"
      + arn                                   = (known after apply)
      + comparison_operator                   = "GreaterThanOrEqualToThreshold"
      + datapoints_to_alarm                   = 8
      + dimensions                            = {
          + "ImageId"      = "ami-0bcc094591f354be2"
          + "InstanceId"   = "i-0405cfd6b155814ad"
          + "InstanceType" = "c5.2xlarge"
        }
      + evaluate_low_sample_count_percentiles = (known after apply)
      + evaluation_periods                    = 10
      + id                                    = (known after apply)
      + metric_name                           = "mem_used_percent"
      + namespace                             = "CWAgent"
      + period                                = 60
      + statistic                             = "Average"
      + threshold                             = 50
      + treat_missing_data                    = "missing"
    }

  # aws_cloudwatch_metric_alarm.memory_alarm["evelyn2_prod_High_idx_3b"] will be created
  + resource "aws_cloudwatch_metric_alarm" "memory_alarm" {
      + actions_enabled                       = true
      + alarm_description                     = "This metric monitors ec2 memory uses."
      + alarm_name                            = "Evelyn2_Prod - High - Memory Usage - B - (IDX-3)"
      + arn                                   = (known after apply)
      + comparison_operator                   = "GreaterThanOrEqualToThreshold"
      + datapoints_to_alarm                   = 8
      + dimensions                            = {
          + "ImageId"      = "ami-0bcc094591f354be2"
          + "InstanceId"   = "i-0405cfd6b155814ad"
          + "InstanceType" = "c5.xlarge"
        }
      + evaluate_low_sample_count_percentiles = (known after apply)
      + evaluation_periods                    = 10
      + id                                    = (known after apply)
      + metric_name                           = "mem_used_percent"
      + namespace                             = "CWAgent"
      + period                                = 60
      + statistic                             = "Average"
      + threshold                             = 50
      + treat_missing_data                    = "missing"
    }

  # aws_cloudwatch_metric_alarm.memory_alarm["evelyn2_prod_High_idx_4a"] will be created
  + resource "aws_cloudwatch_metric_alarm" "memory_alarm" {
      + actions_enabled                       = true
      + alarm_description                     = "This metric monitors ec2 memory uses."
      + alarm_name                            = "Evelyn2_Prod - High - Memory Usage - A - (IDX-4)"
      + arn                                   = (known after apply)
      + comparison_operator                   = "GreaterThanOrEqualToThreshold"
      + datapoints_to_alarm                   = 8
      + dimensions                            = {
          + "ImageId"      = "ami-0bcc094591f354be2"
          + "InstanceId"   = "i-0405cfd6b155814ad"
          + "InstanceType" = "c5.2xlarge"
        }
      + evaluate_low_sample_count_percentiles = (known after apply)
      + evaluation_periods                    = 10
      + id                                    = (known after apply)
      + metric_name                           = "mem_used_percent"
      + namespace                             = "CWAgent"
      + period                                = 60
      + statistic                             = "Average"
      + threshold                             = 50
      + treat_missing_data                    = "missing"
    }

  # aws_cloudwatch_metric_alarm.memory_alarm["evelyn2_prod_High_idx_4b"] will be created
  + resource "aws_cloudwatch_metric_alarm" "memory_alarm" {
      + actions_enabled                       = true
      + alarm_description                     = "This metric monitors ec2 memory uses."
      + alarm_name                            = "Evelyn2_Prod - High - Memory Usage - B - (IDX-4)"
      + arn                                   = (known after apply)
      + comparison_operator                   = "GreaterThanOrEqualToThreshold"
      + datapoints_to_alarm                   = 8
      + dimensions                            = {
          + "ImageId"      = "ami-0bcc094591f354be2"
          + "InstanceId"   = "i-0405cfd6b155814ad"
          + "InstanceType" = "c5.large"
        }
      + evaluate_low_sample_count_percentiles = (known after apply)
      + evaluation_periods                    = 10
      + id                                    = (known after apply)
      + metric_name                           = "mem_used_percent"
      + namespace                             = "CWAgent"
      + period                                = 60
      + statistic                             = "Average"
      + threshold                             = 50
      + treat_missing_data                    = "missing"
    }

  # aws_cloudwatch_metric_alarm.memory_alarm["evelyn2_prod_High_sh_1"] will be created
  + resource "aws_cloudwatch_metric_alarm" "memory_alarm" {
      + actions_enabled                       = true
      + alarm_description                     = "This metric monitors ec2 memory uses."
      + alarm_name                            = "Evelyn2_Prod - High - Memory Usage - O - (SH-1)"
      + arn                                   = (known after apply)
      + comparison_operator                   = "GreaterThanOrEqualToThreshold"
      + datapoints_to_alarm                   = 8
      + dimensions                            = {
          + "ImageId"      = "ami-0bcc094591f354be2"
          + "InstanceId"   = "i-0405cfd6b155814ad"
          + "InstanceType" = "c5.xlarge"
        }
      + evaluate_low_sample_count_percentiles = (known after apply)
      + evaluation_periods                    = 10
      + id                                    = (known after apply)
      + metric_name                           = "mem_used_percent"
      + namespace                             = "CWAgent"
      + period                                = 60
      + statistic                             = "Average"
      + threshold                             = 50
      + treat_missing_data                    = "missing"
    }

  # aws_cloudwatch_metric_alarm.memory_alarm["evelyn2_prod_High_sh_1_a"] will be created
  + resource "aws_cloudwatch_metric_alarm" "memory_alarm" {
      + actions_enabled                       = true
      + alarm_description                     = "This metric monitors ec2 memory uses."
      + alarm_name                            = "Evelyn2_Prod - High - Memory Usage - A - (SH-1)"
      + arn                                   = (known after apply)
      + comparison_operator                   = "GreaterThanOrEqualToThreshold"
      + datapoints_to_alarm                   = 8
      + dimensions                            = {
          + "ImageId"      = "ami-0bcc094591f354be2"
          + "InstanceId"   = "i-0405cfd6b155814ad"
          + "InstanceType" = "c5.2xlarge"
        }
      + evaluate_low_sample_count_percentiles = (known after apply)
      + evaluation_periods                    = 10
      + id                                    = (known after apply)
      + metric_name                           = "mem_used_percent"
      + namespace                             = "CWAgent"
      + period                                = 60
      + statistic                             = "Average"
      + threshold                             = 50
      + treat_missing_data                    = "missing"
    }

  # aws_cloudwatch_metric_alarm.memory_alarm["evelyn2_prod_High_sh_1b"] will be created
  + resource "aws_cloudwatch_metric_alarm" "memory_alarm" {
      + actions_enabled                       = true
      + alarm_description                     = "This metric monitors ec2 memory uses."
      + alarm_name                            = "Evelyn2_Prod - High - Memory Usage - B - (SH-1)"
      + arn                                   = (known after apply)
      + comparison_operator                   = "GreaterThanOrEqualToThreshold"
      + datapoints_to_alarm                   = 8
      + dimensions                            = {
          + "ImageId"      = "ami-0bcc094591f354be2"
          + "InstanceId"   = "i-0405cfd6b155814ad"
          + "InstanceType" = "c5.2xlarge"
        }
      + evaluate_low_sample_count_percentiles = (known after apply)
      + evaluation_periods                    = 10
      + id                                    = (known after apply)
      + metric_name                           = "mem_used_percent"
      + namespace                             = "CWAgent"
      + period                                = 60
      + statistic                             = "Average"
      + threshold                             = 50
      + treat_missing_data                    = "missing"
    }

  # aws_cloudwatch_metric_alarm.memory_alarm["evelyn2_prod_High_sh_2_a"] will be created
  + resource "aws_cloudwatch_metric_alarm" "memory_alarm" {
      + actions_enabled                       = true
      + alarm_description                     = "This metric monitors ec2 memory uses."
      + alarm_name                            = "Evelyn2_Prod - High - Memory Usage - A - (SH-2)"
      + arn                                   = (known after apply)
      + comparison_operator                   = "GreaterThanOrEqualToThreshold"
      + datapoints_to_alarm                   = 8
      + dimensions                            = {
          + "ImageId"      = "ami-0bcc094591f354be2"
          + "InstanceId"   = "i-0405cfd6b155814ad"
          + "InstanceType" = "c5.2xlarge"
        }
      + evaluate_low_sample_count_percentiles = (known after apply)
      + evaluation_periods                    = 10
      + id                                    = (known after apply)
      + metric_name                           = "mem_used_percent"
      + namespace                             = "CWAgent"
      + period                                = 60
      + statistic                             = "Average"
      + threshold                             = 50
      + treat_missing_data                    = "missing"
    }

  # aws_cloudwatch_metric_alarm.memory_alarm["evelyn2_prod_High_sh_2b"] will be created
  + resource "aws_cloudwatch_metric_alarm" "memory_alarm" {
      + actions_enabled                       = true
      + alarm_description                     = "This metric monitors ec2 memory uses."
      + alarm_name                            = "Evelyn2_Prod - High - Memory Usage - B - (SH-2)"
      + arn                                   = (known after apply)
      + comparison_operator                   = "GreaterThanOrEqualToThreshold"
      + datapoints_to_alarm                   = 8
      + dimensions                            = {
          + "ImageId"      = "ami-0bcc094591f354be2"
          + "InstanceId"   = "i-0405cfd6b155814ad"
          + "InstanceType" = "c5.2xlarge"
        }
      + evaluate_low_sample_count_percentiles = (known after apply)
      + evaluation_periods                    = 10
      + id                                    = (known after apply)
      + metric_name                           = "mem_used_percent"
      + namespace                             = "CWAgent"
      + period                                = 60
      + statistic                             = "Average"
      + threshold                             = 50
      + treat_missing_data                    = "missing"
    }

  # aws_cloudwatch_metric_alarm.memory_alarm["evelyn2_prod_warning_cm"] will be created
  + resource "aws_cloudwatch_metric_alarm" "memory_alarm" {
      + actions_enabled                       = true
      + alarm_description                     = "This metric monitors ec2 memory uses."
      + alarm_name                            = "Evelyn2_Prod - Warning - Memory Usage - O - (CM)"
      + arn                                   = (known after apply)
      + comparison_operator                   = "GreaterThanOrEqualToThreshold"
      + datapoints_to_alarm                   = 8
      + dimensions                            = {
          + "ImageId"      = "ami-0bcc094591f354be2"
          + "InstanceId"   = "i-09458c6f9b151e67a"
          + "InstanceType" = "c5.large"
        }
      + evaluate_low_sample_count_percentiles = (known after apply)
      + evaluation_periods                    = 10
      + id                                    = (known after apply)
      + metric_name                           = "mem_used_percent"
      + namespace                             = "CWAgent"
      + period                                = 60
      + statistic                             = "Average"
      + threshold                             = 50
      + treat_missing_data                    = "missing"
    }

  # aws_cloudwatch_metric_alarm.memory_alarm["evelyn2_prod_warning_cribl_1"] will be created
  + resource "aws_cloudwatch_metric_alarm" "memory_alarm" {
      + actions_enabled                       = true
      + alarm_description                     = "This metric monitors ec2 memory uses."
      + alarm_name                            = "Evelyn2_Prod - Warning - Memory Usage - A - (Cribl-1)"
      + arn                                   = (known after apply)
      + comparison_operator                   = "GreaterThanOrEqualToThreshold"
      + datapoints_to_alarm                   = 8
      + dimensions                            = {
          + "ImageId"      = "ami-0bcc094591f354be2"
          + "InstanceId"   = "i-0405cfd6b155814ad"
          + "InstanceType" = "c5.xlarge"
        }
      + evaluate_low_sample_count_percentiles = (known after apply)
      + evaluation_periods                    = 10
      + id                                    = (known after apply)
      + metric_name                           = "mem_used_percent"
      + namespace                             = "CWAgent"
      + period                                = 60
      + statistic                             = "Average"
      + threshold                             = 50
      + treat_missing_data                    = "missing"
    }

  # aws_cloudwatch_metric_alarm.memory_alarm["evelyn2_prod_warning_cribl_1_b"] will be created
  + resource "aws_cloudwatch_metric_alarm" "memory_alarm" {
      + actions_enabled                       = true
      + alarm_description                     = "This metric monitors ec2 memory uses."
      + alarm_name                            = "Evelyn2_Prod - Warning - Memory Usage - B - (Cribl-1)"
      + arn                                   = (known after apply)
      + comparison_operator                   = "GreaterThanOrEqualToThreshold"
      + datapoints_to_alarm                   = 8
      + dimensions                            = {
          + "ImageId"      = "ami-0bcc094591f354be2"
          + "InstanceId"   = "i-0405cfd6b155814ad"
          + "InstanceType" = "c5.xlarge"
        }
      + evaluate_low_sample_count_percentiles = (known after apply)
      + evaluation_periods                    = 10
      + id                                    = (known after apply)
      + metric_name                           = "mem_used_percent"
      + namespace                             = "CWAgent"
      + period                                = 60
      + statistic                             = "Average"
      + threshold                             = 50
      + treat_missing_data                    = "missing"
    }

  # aws_cloudwatch_metric_alarm.memory_alarm["evelyn2_prod_warning_dm"] will be created
  + resource "aws_cloudwatch_metric_alarm" "memory_alarm" {
      + actions_enabled                       = true
      + alarm_description                     = "This metric monitors ec2 memory uses."
      + alarm_name                            = "Evelyn2_Prod - Warning - Memory Usage - O - (DM)"
      + arn                                   = (known after apply)
      + comparison_operator                   = "GreaterThanOrEqualToThreshold"
      + datapoints_to_alarm                   = 8
      + dimensions                            = {
          + "ImageId"      = "ami-0bcc094591f354be2"
          + "InstanceId"   = "i-0405cfd6b155814ad"
          + "InstanceType" = "c5.large"
        }
      + evaluate_low_sample_count_percentiles = (known after apply)
      + evaluation_periods                    = 10
      + id                                    = (known after apply)
      + metric_name                           = "mem_used_percent"
      + namespace                             = "CWAgent"
      + period                                = 60
      + statistic                             = "Average"
      + threshold                             = 50
      + treat_missing_data                    = "missing"
    }

  # aws_cloudwatch_metric_alarm.memory_alarm["evelyn2_prod_warning_ds"] will be created
  + resource "aws_cloudwatch_metric_alarm" "memory_alarm" {
      + actions_enabled                       = true
      + alarm_description                     = "This metric monitors ec2 memory uses."
      + alarm_name                            = "Evelyn2_Prod - Warning - Memory Usage - O - (DS)"
      + arn                                   = (known after apply)
      + comparison_operator                   = "GreaterThanOrEqualToThreshold"
      + datapoints_to_alarm                   = 8
      + dimensions                            = {
          + "ImageId"      = "ami-0bcc094591f354be2"
          + "InstanceId"   = "i-0223a28edb48be4e4"
          + "InstanceType" = "c5.large"
        }
      + evaluate_low_sample_count_percentiles = (known after apply)
      + evaluation_periods                    = 10
      + id                                    = (known after apply)
      + metric_name                           = "mem_used_percent"
      + namespace                             = "CWAgent"
      + period                                = 60
      + statistic                             = "Average"
      + threshold                             = 50
      + treat_missing_data                    = "missing"
    }

  # aws_cloudwatch_metric_alarm.memory_alarm["evelyn2_prod_warning_idx_1a"] will be created
  + resource "aws_cloudwatch_metric_alarm" "memory_alarm" {
      + actions_enabled                       = true
      + alarm_description                     = "This metric monitors ec2 memory uses."
      + alarm_name                            = "Evelyn2_Prod - Warning - Memory Usage - A - (IDX-1)"
      + arn                                   = (known after apply)
      + comparison_operator                   = "GreaterThanOrEqualToThreshold"
      + datapoints_to_alarm                   = 8
      + dimensions                            = {
          + "ImageId"      = "ami-0bcc094591f354be2"
          + "InstanceId"   = "i-0405cfd6b155814ad"
          + "InstanceType" = "c5.xlarge"
        }
      + evaluate_low_sample_count_percentiles = (known after apply)
      + evaluation_periods                    = 10
      + id                                    = (known after apply)
      + metric_name                           = "mem_used_percent"
      + namespace                             = "CWAgent"
      + period                                = 60
      + statistic                             = "Average"
      + threshold                             = 50
      + treat_missing_data                    = "missing"
    }

  # aws_cloudwatch_metric_alarm.memory_alarm["evelyn2_prod_warning_idx_1b"] will be created
  + resource "aws_cloudwatch_metric_alarm" "memory_alarm" {
      + actions_enabled                       = true
      + alarm_description                     = "This metric monitors ec2 memory uses."
      + alarm_name                            = "Evelyn2_Prod - Warning - Memory Usage - B - (IDX-1"
      + arn                                   = (known after apply)
      + comparison_operator                   = "GreaterThanOrEqualToThreshold"
      + datapoints_to_alarm                   = 8
      + dimensions                            = {
          + "ImageId"      = "ami-0bcc094591f354be2"
          + "InstanceId"   = "i-0405cfd6b155814ad"
          + "InstanceType" = "c5.xlarge"
        }
      + evaluate_low_sample_count_percentiles = (known after apply)
      + evaluation_periods                    = 10
      + id                                    = (known after apply)
      + metric_name                           = "mem_used_percent"
      + namespace                             = "CWAgent"
      + period                                = 60
      + statistic                             = "Average"
      + threshold                             = 50
      + treat_missing_data                    = "missing"
    }

  # aws_cloudwatch_metric_alarm.memory_alarm["evelyn2_prod_warning_idx_2a"] will be created
  + resource "aws_cloudwatch_metric_alarm" "memory_alarm" {
      + actions_enabled                       = true
      + alarm_description                     = "This metric monitors ec2 memory uses."
      + alarm_name                            = "Evelyn2_Prod - Warning - Memory Usage - A - (IDX-2)"
      + arn                                   = (known after apply)
      + comparison_operator                   = "GreaterThanOrEqualToThreshold"
      + datapoints_to_alarm                   = 8
      + dimensions                            = {
          + "ImageId"      = "ami-0bcc094591f354be2"
          + "InstanceId"   = "i-0405cfd6b155814ad"
          + "InstanceType" = "c5.xlarge"
        }
      + evaluate_low_sample_count_percentiles = (known after apply)
      + evaluation_periods                    = 10
      + id                                    = (known after apply)
      + metric_name                           = "mem_used_percent"
      + namespace                             = "CWAgent"
      + period                                = 60
      + statistic                             = "Average"
      + threshold                             = 50
      + treat_missing_data                    = "missing"
    }

  # aws_cloudwatch_metric_alarm.memory_alarm["evelyn2_prod_warning_idx_2b"] will be created
  + resource "aws_cloudwatch_metric_alarm" "memory_alarm" {
      + actions_enabled                       = true
      + alarm_description                     = "This metric monitors ec2 memory uses."
      + alarm_name                            = "Evelyn2_Prod - Warning - Memory Usage - B - (IDX-2)"
      + arn                                   = (known after apply)
      + comparison_operator                   = "GreaterThanOrEqualToThreshold"
      + datapoints_to_alarm                   = 8
      + dimensions                            = {
          + "ImageId"      = "ami-0bcc094591f354be2"
          + "InstanceId"   = "i-0405cfd6b155814ad"
          + "InstanceType" = "c5.xlarge"
        }
      + evaluate_low_sample_count_percentiles = (known after apply)
      + evaluation_periods                    = 10
      + id                                    = (known after apply)
      + metric_name                           = "mem_used_percent"
      + namespace                             = "CWAgent"
      + period                                = 60
      + statistic                             = "Average"
      + threshold                             = 50
      + treat_missing_data                    = "missing"
    }

  # aws_cloudwatch_metric_alarm.memory_alarm["evelyn2_prod_warning_idx_3a"] will be created
  + resource "aws_cloudwatch_metric_alarm" "memory_alarm" {
      + actions_enabled                       = true
      + alarm_description                     = "This metric monitors ec2 memory uses."
      + alarm_name                            = "Evelyn2_Prod - Warning - Memory Usage - A - (IDX-3)"
      + arn                                   = (known after apply)
      + comparison_operator                   = "GreaterThanOrEqualToThreshold"
      + datapoints_to_alarm                   = 8
      + dimensions                            = {
          + "ImageId"      = "ami-0bcc094591f354be2"
          + "InstanceId"   = "i-0405cfd6b155814ad"
          + "InstanceType" = "c5.2xlarge"
        }
      + evaluate_low_sample_count_percentiles = (known after apply)
      + evaluation_periods                    = 10
      + id                                    = (known after apply)
      + metric_name                           = "mem_used_percent"
      + namespace                             = "CWAgent"
      + period                                = 60
      + statistic                             = "Average"
      + threshold                             = 50
      + treat_missing_data                    = "missing"
    }

  # aws_cloudwatch_metric_alarm.memory_alarm["evelyn2_prod_warning_idx_3b"] will be created
  + resource "aws_cloudwatch_metric_alarm" "memory_alarm" {
      + actions_enabled                       = true
      + alarm_description                     = "This metric monitors ec2 memory uses."
      + alarm_name                            = "Evelyn2_Prod - Warning - Memory Usage - B - (IDX-3)"
      + arn                                   = (known after apply)
      + comparison_operator                   = "GreaterThanOrEqualToThreshold"
      + datapoints_to_alarm                   = 8
      + dimensions                            = {
          + "ImageId"      = "ami-0bcc094591f354be2"
          + "InstanceId"   = "i-0405cfd6b155814ad"
          + "InstanceType" = "c5.xlarge"
        }
      + evaluate_low_sample_count_percentiles = (known after apply)
      + evaluation_periods                    = 10
      + id                                    = (known after apply)
      + metric_name                           = "mem_used_percent"
      + namespace                             = "CWAgent"
      + period                                = 60
      + statistic                             = "Average"
      + threshold                             = 50
      + treat_missing_data                    = "missing"
    }

  # aws_cloudwatch_metric_alarm.memory_alarm["evelyn2_prod_warning_idx_4a"] will be created
  + resource "aws_cloudwatch_metric_alarm" "memory_alarm" {
      + actions_enabled                       = true
      + alarm_description                     = "This metric monitors ec2 memory uses."
      + alarm_name                            = "Evelyn2_Prod - Warning - Memory Usage - A - (IDX-4)"
      + arn                                   = (known after apply)
      + comparison_operator                   = "GreaterThanOrEqualToThreshold"
      + datapoints_to_alarm                   = 8
      + dimensions                            = {
          + "ImageId"      = "ami-0bcc094591f354be2"
          + "InstanceId"   = "i-0405cfd6b155814ad"
          + "InstanceType" = "c5.2xlarge"
        }
      + evaluate_low_sample_count_percentiles = (known after apply)
      + evaluation_periods                    = 10
      + id                                    = (known after apply)
      + metric_name                           = "mem_used_percent"
      + namespace                             = "CWAgent"
      + period                                = 60
      + statistic                             = "Average"
      + threshold                             = 50
      + treat_missing_data                    = "missing"
    }

  # aws_cloudwatch_metric_alarm.memory_alarm["evelyn2_prod_warning_idx_4b"] will be created
  + resource "aws_cloudwatch_metric_alarm" "memory_alarm" {
      + actions_enabled                       = true
      + alarm_description                     = "This metric monitors ec2 memory uses."
      + alarm_name                            = "Evelyn2_Prod - Warning - Memory Usage - B - (IDX-4)"
      + arn                                   = (known after apply)
      + comparison_operator                   = "GreaterThanOrEqualToThreshold"
      + datapoints_to_alarm                   = 8
      + dimensions                            = {
          + "ImageId"      = "ami-0bcc094591f354be2"
          + "InstanceId"   = "i-0405cfd6b155814ad"
          + "InstanceType" = "c5.xlarge"
        }
      + evaluate_low_sample_count_percentiles = (known after apply)
      + evaluation_periods                    = 10
      + id                                    = (known after apply)
      + metric_name                           = "mem_used_percent"
      + namespace                             = "CWAgent"
      + period                                = 60
      + statistic                             = "Average"
      + threshold                             = 50
      + treat_missing_data                    = "missing"
    }

  # aws_cloudwatch_metric_alarm.memory_alarm["evelyn2_prod_warning_sh_1"] will be created
  + resource "aws_cloudwatch_metric_alarm" "memory_alarm" {
      + actions_enabled                       = true
      + alarm_description                     = "This metric monitors ec2 memory uses."
      + alarm_name                            = "Evelyn2_Prod - Warning - Memory Usage - O - (SH-1)"
      + arn                                   = (known after apply)
      + comparison_operator                   = "GreaterThanOrEqualToThreshold"
      + datapoints_to_alarm                   = 8
      + dimensions                            = {
          + "ImageId"      = "ami-0bcc094591f354be2"
          + "InstanceId"   = "i-0405cfd6b155814ad"
          + "InstanceType" = "c5.xlarge"
        }
      + evaluate_low_sample_count_percentiles = (known after apply)
      + evaluation_periods                    = 10
      + id                                    = (known after apply)
      + metric_name                           = "mem_used_percent"
      + namespace                             = "CWAgent"
      + period                                = 60
      + statistic                             = "Average"
      + threshold                             = 50
      + treat_missing_data                    = "missing"
    }

  # aws_cloudwatch_metric_alarm.memory_alarm["evelyn2_prod_warning_sh_1_a"] will be created
  + resource "aws_cloudwatch_metric_alarm" "memory_alarm" {
      + actions_enabled                       = true
      + alarm_description                     = "This metric monitors ec2 memory uses."
      + alarm_name                            = "Evelyn2_Prod - Warning - Memory Usage - A - (SH-1)"
      + arn                                   = (known after apply)
      + comparison_operator                   = "GreaterThanOrEqualToThreshold"
      + datapoints_to_alarm                   = 8
      + dimensions                            = {
          + "ImageId"      = "ami-0bcc094591f354be2"
          + "InstanceId"   = "i-0405cfd6b155814ad"
          + "InstanceType" = "c5.2xlarge"
        }
      + evaluate_low_sample_count_percentiles = (known after apply)
      + evaluation_periods                    = 10
      + id                                    = (known after apply)
      + metric_name                           = "mem_used_percent"
      + namespace                             = "CWAgent"
      + period                                = 60
      + statistic                             = "Average"
      + threshold                             = 50
      + treat_missing_data                    = "missing"
    }

  # aws_cloudwatch_metric_alarm.memory_alarm["evelyn2_prod_warning_sh_1b"] will be created
  + resource "aws_cloudwatch_metric_alarm" "memory_alarm" {
      + actions_enabled                       = true
      + alarm_description                     = "This metric monitors ec2 memory uses."
      + alarm_name                            = "Evelyn2_Prod - Warning - Memory Usage - B - (SH-1)"
      + arn                                   = (known after apply)
      + comparison_operator                   = "GreaterThanOrEqualToThreshold"
      + datapoints_to_alarm                   = 8
      + dimensions                            = {
          + "ImageId"      = "ami-0bcc094591f354be2"
          + "InstanceId"   = "i-0405cfd6b155814ad"
          + "InstanceType" = "c5.2xlarge"
        }
      + evaluate_low_sample_count_percentiles = (known after apply)
      + evaluation_periods                    = 10
      + id                                    = (known after apply)
      + metric_name                           = "mem_used_percent"
      + namespace                             = "CWAgent"
      + period                                = 60
      + statistic                             = "Average"
      + threshold                             = 50
      + treat_missing_data                    = "missing"
    }

  # aws_cloudwatch_metric_alarm.memory_alarm["evelyn2_prod_warning_sh_2_a"] will be created
  + resource "aws_cloudwatch_metric_alarm" "memory_alarm" {
      + actions_enabled                       = true
      + alarm_description                     = "This metric monitors ec2 memory uses."
      + alarm_name                            = "Evelyn2_Prod - Warning - Memory Usage - A - (SH-2)"
      + arn                                   = (known after apply)
      + comparison_operator                   = "GreaterThanOrEqualToThreshold"
      + datapoints_to_alarm                   = 8
      + dimensions                            = {
          + "ImageId"      = "ami-0bcc094591f354be2"
          + "InstanceId"   = "i-0405cfd6b155814ad"
          + "InstanceType" = "c5.2xlarge"
        }
      + evaluate_low_sample_count_percentiles = (known after apply)
      + evaluation_periods                    = 10
      + id                                    = (known after apply)
      + metric_name                           = "mem_used_percent"
      + namespace                             = "CWAgent"
      + period                                = 60
      + statistic                             = "Average"
      + threshold                             = 50
      + treat_missing_data                    = "missing"
    }

  # aws_cloudwatch_metric_alarm.memory_alarm["evelyn2_prod_warning_sh_2b"] will be created
  + resource "aws_cloudwatch_metric_alarm" "memory_alarm" {
      + actions_enabled                       = true
      + alarm_description                     = "This metric monitors ec2 memory uses."
      + alarm_name                            = "Evelyn2_Prod - Warning - Memory Usage - B - (SH-2)"
      + arn                                   = (known after apply)
      + comparison_operator                   = "GreaterThanOrEqualToThreshold"
      + datapoints_to_alarm                   = 8
      + dimensions                            = {
          + "ImageId"      = "ami-0bcc094591f354be2"
          + "InstanceId"   = "i-0405cfd6b155814ad"
          + "InstanceType" = "c5.2xlarge"
        }
      + evaluate_low_sample_count_percentiles = (known after apply)
      + evaluation_periods                    = 10
      + id                                    = (known after apply)
      + metric_name                           = "mem_used_percent"
      + namespace                             = "CWAgent"
      + period                                = 60
      + statistic                             = "Average"
      + threshold                             = 50
      + treat_missing_data                    = "missing"
    }

Plan: 180 to add, 0 to change, 0 to destroy.
```