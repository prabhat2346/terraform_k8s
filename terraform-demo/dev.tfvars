# variable value for Dev - CPU Usage - Warning & High
evelyn_ec2_instance_id_cpu                  =   ["i-00f0fa499f697770f",
                                                "i-018fbe1f2bdd5d014",
                                                "i-04e3ca07e5e4ba18d",
                                                "i-0ca3ef371c719a764",
                                                "i-0c415dd8546b3f5c1"]

 metric_alarm_name_cpu_warning           = ["Evelyn2_Dev - Warning - CPU Utilization - SH-1",
                                            "Evelyn2_Dev - Warning - CPU Utilization - IDX-1",
                                            "Evelyn2_Dev - Warning - CPU Utilization - DS",
                                            "Evelyn2_Dev - Warning - CPU Utilization - Cribl-1",
                                            "Evelyn2_Dev - Warning - CPU Utilization - DM"]
                                    
  metric_alarm_name_cpu_high             = ["Evelyn2_Dev - High - CPU Utilization - SH-1",
                                            "Evelyn2_Dev - High - CPU Utilization - IDX-1", 
                                            "Evelyn2_Dev - High - CPU Utilization - DS", 
                                            "Evelyn2_Dev - High - CPU Utilization - Cribl-1", 
                                            "Evelyn2_Dev - High - CPU Utilization - DM"]

 # variable value for Dev - Memory Usage - Warning & High.
 evelyn_ec2_instance_id_memory                = ["i-00f0fa499f697770f",
                                                "i-018fbe1f2bdd5d014",
                                                "i-04e3ca07e5e4ba18d",
                                                "i-0ca3ef371c719a764",
                                                "i-0c415dd8546b3f5c1"]
 metric_alarm_memory_high                = ["Evelyn2_Dev - High - Memory Usage - SH-1",
                                                "Evelyn2_Dev - High - Memory Usage - IDX-1", 
                                                "Evelyn2_Dev - High - Memory Usage - DS", 
                                                "Evelyn2_Dev - High - Memory Usage - Cribl-1", 
                                                "Evelyn2_Dev - High - Memory Usage - DM"]

metric_alarm_memory_warning              = ["Evelyn2_Dev - Warning - Memory Usage - SH-1",
                                                "Evelyn2_Dev - Warning - Memory Usage - IDX-1", 
                                                "Evelyn2_Dev - Warning - Memory Usage - DS", 
                                                "Evelyn2_Dev - Warning - Memory Usage - Cribl-1", 
                                                "Evelyn2_Dev - Warning - Memory Usage - DM"]
 ami_id_memory                                  =  ["ami-085925f297f89fce1",
                                                "ami-085925f297f89fce1",
                                                "ami-085925f297f89fce1",
                                                "ami-085925f297f89fce1",
                                                "ami-010bb5f550c901adb"]

instance_type_memory                            =   ["c5.large",
                                                "c5.large",
                                                "c5.large",
                                                "c5.large",
                                                "c5.large"]

# variable value for Dev - Disk Utilization - Warning & High (root)
evelyn_ec2_instance_root_id             = ["i-00f0fa499f697770f",
                                            "i-018fbe1f2bdd5d014", 
                                            "i-04e3ca07e5e4ba18d", 
                                             "i-0ca3ef371c719a764", 
                                            "i-0c415dd8546b3f5c1"]
metric_alarm_name_disk_root_warning   = ["Evelyn2_Dev - Warning - Disk Utilization (root) - SH-1",
                                            "Evelyn2_Dev - Warning - Disk Utilization (root) - IDX-1", 
                                            "Evelyn2_Dev - Warning - Disk Utilization (root) - DS", 
                                            "Evelyn2_Dev - Warning - Disk Utilization (root) - Cribl-1", 
                                            "Evelyn2_Dev - Warning - Disk Utilization (root) - DM"]   

  metric_alarm_name_disk_root_high      = ["Evelyn2_Dev - High - Disk Utilization (root) - SH-1",
                                            "Evelyn2_Dev - High - Disk Utilization (root) - IDX-1", 
                                            "Evelyn2_Dev - High - Disk Utilization (root) - DS", 
                                            "Evelyn2_Dev - High - Disk Utilization (root) - Cribl-1", 
                                            "Evelyn2_Dev - High - Disk Utilization (root) - DM"]                                              


ami_id_root                             = ["ami-085925f297f89fce1",
                                            "ami-085925f297f89fce1", 
                                            "ami-085925f297f89fce1", 
                                            "ami-085925f297f89fce1", 
                                            "ami-010bb5f550c901adb"]

path_name_root                          = ["/",
                                                "/", 
                                                "/", 
                                                "/", 
                                                "/"]

 device_name_root                       = ["nvme0n1p1",
                                                "nvme0n1p1", 
                                                "nvme0n1p1", 
                                                "nvme0n1p1", 
                                                "nvme0n1p1"]
 instance_type_root                           =   ["c5.large",
                                                "c5.large",
                                                "c5.large",
                                                "c5.large",
                                                "c5.large"]
fstype_name_root                            = ["ext4",
                                             "ext4", 
                                             "ext4", 
                                             "ext4", 
                                             "ext4"]

# variable value for Dev - Disk Utilization - Warning & High (opt)
evelyn_ec2_instance_opt_id             = ["i-00f0fa499f697770f",
                                            "i-018fbe1f2bdd5d014", 
                                            "i-04e3ca07e5e4ba18d", 
                                            "i-0ca3ef371c719a764", 
                                            "i-0c415dd8546b3f5c1"]
metric_alarm_name_disk_opt_warning    = ["Evelyn2_Dev - Warning - Disk Utilization (opt) - SH-1",
                                            "Evelyn2_Dev - Warning - Disk Utilization (opt) - IDX-1", 
                                            "Evelyn2_Dev - Warning - Disk Utilization (opt) - DS", 
                                            "Evelyn2_Dev - Warning - Disk Utilization (opt) - Cribl-1", 
                                            "Evelyn2_Dev - Warning - Disk Utilization (opt) - DM"]  

  metric_alarm_name_disk_opt_high       = ["Evelyn2_Dev - High - Disk Utilization (opt) - SH-1",
                                            "Evelyn2_Dev - High - Disk Utilization (opt) - IDX-1", 
                                            "Evelyn2_Dev - High - Disk Utilization (opt) - DS", 
                                            "Evelyn2_Dev - High - Disk Utilization (opt) - Cribl-1", 
                                            "Evelyn2_Dev - High - Disk Utilization (opt) - DM"]                                            

ami_id_opt                             = ["ami-085925f297f89fce1",
                                            "ami-085925f297f89fce1", 
                                            "ami-085925f297f89fce1",
                                            "ami-085925f297f89fce1", 
                                            "ami-010bb5f550c901adb"]

 path_name_opt                          = ["/opt",
                                            "/opt", 
                                            "/opt", 
                                            "/opt", 
                                            "/opt"]     

  device_name_opt                       = ["nvme1n1",
                                            "nvme2n1", 
                                            "nvme1n1", 
                                            "nvme1n1", 
                                            "nvme1n1"]
 instance_type_opt                            =   ["c5.large",
                                                "c5.large",
                                                "c5.large",
                                                "c5.large",
                                                "c5.large"]
fstype_name_opt                             = ["ext4",
                                             "ext4", 
                                             "ext4", 
                                             "ext4", 
                                             "ext4"]
 # variable value for Dev - Disk Utilization - Warning & High (/opt/splunk/var)
 evelyn_ec2_instance_var_id             = ["i-018fbe1f2bdd5d014",
                                            "i-0c415dd8546b3f5c1"]
 metric_alarm_name_disk_var_warning    = ["Evelyn2_Dev - Warning - Disk Utilization (var) - IDX-1",
                                          "Evelyn2_Dev - Warning - Disk Utilization (var) - DM"] 

  metric_alarm_name_disk_var_high       = ["Evelyn2_Dev - High - Disk Utilization (var) - IDX-1",
                                          "Evelyn2_Dev - High - Disk Utilization (var) - DM"]                                                 

 ami_id_var                             = ["ami-085925f297f89fce1",
                                           "ami-010bb5f550c901adb"]

 path_name_var                          = ["/opt/splunk/var",
                                           "/opt/splunk/var"]

 device_name_var                        = ["nvme1n1",
                                           "nvme2n1"]
 instance_type_var                            =   ["c5.large",
                                                "c5.large",
                                                "c5.large",
                                                "c5.large",
                                                "c5.large"]
 fstype_name_var                             = ["ext4",  
                                                "ext4"]                                               
 # variable value for ELB
                                            
 # variable value for ELB
 # for target 5xx
 target_group                         = "targetgroup/Evelyn2-Dev-SH/48ff9c5ce9325ce6"

   LB_Evelyn2_Dev                       = ["app/Evelyn2-Dev/3d6432d10c6ce004",
                                          "app/Evelyn2-Dev/3d6432d10c6ce004"]

   LB_Evelyn2_Dev_Internal              = ["app/Evelyn2-Dev-Internal/ee9cb88fb4dcbdb5",
                                          "app/Evelyn2-Dev-Internal/ee9cb88fb4dcbdb5"]
                                          

   Evelyn2_Dev_ELB_Alarm_Name           = ["Evelyn2_Dev - ELB - High - Dev - Target 5XX (us-east-1a)",
                                           "Evelyn2_Dev - ELB - High - Dev - Target 5XX (us-east-1c)"]
                                           

  Evelyn2_Dev_Internal_ELB_Alarm_Name   = ["Evelyn2_Dev - ELB - High - Dev-Internal - Target 5XX (us-east-1a)",
                                           "Evelyn2_Dev - ELB - High - Dev-Internal - Target 5XX (us-east-1c)"]
  Evelyn2_Dev_Availability_zone         = ["us-east-1a", "us-east-1c"]


  # for target 4xx
     LB_Evelyn2_Dev_4xx                     = ["app/Evelyn2-Dev/3d6432d10c6ce004",
                                          "app/Evelyn2-Dev/3d6432d10c6ce004"]

   LB_Evelyn2_Dev_Internal_4xx              = ["app/Evelyn2-Dev-Internal/ee9cb88fb4dcbdb5",
                                          "app/Evelyn2-Dev-Internal/ee9cb88fb4dcbdb5"]

   Evelyn2_Dev_ELB_Alarm_Name_4xx           = ["Evelyn2_Dev - ELB - High - Dev - Target 4XX (us-east-1a)",
                                           "Evelyn2_Dev - ELB - High - Dev - Target 4XX (us-east-1c)"]

  Evelyn2_Dev_Internal_ELB_Alarm_Name_4xx   = ["Evelyn2_Dev - ELB - High - Dev-Internal - Target 4XX (us-east-1a)",
                                           "Evelyn2_Dev - ELB - High - Dev-Internal - Target 4XX (us-east-1c)"]
  Evelyn2_Dev_Availability_zone_4xx         = ["us-east-1a", "us-east-1c"]

# ------------------------------------------------------------------------------------------------------------------------------------------                                            

 # for ELB 5xx

   LB_Evelyn2_Dev_elb                       = ["app/Evelyn2-Dev/3d6432d10c6ce004",
                                              "app/Evelyn2-Dev/3d6432d10c6ce004"]

   LB_Evelyn2_Dev_Internal_elb             = ["app/Evelyn2-Dev-Internal/ee9cb88fb4dcbdb5",
                                          "app/Evelyn2-Dev-Internal/ee9cb88fb4dcbdb5"]
                                          

   Evelyn2_Dev_ELB_Alarm_Name_elb           = ["Evelyn2_Dev - ELB - High - Dev - ELB 5XX (us-east-1a)",
                                               "Evelyn2_Dev - ELB - High - Dev - ELB 5XX (us-east-1c)"]
                                           

  Evelyn2_Dev_Internal_ELB_Alarm_Name_elb   = ["Evelyn2_Dev - ELB - High - Dev-Internal - ELB 5XX (us-east-1a)",
                                           "Evelyn2_Dev - ELB - High - Dev-Internal - ELB 5XX (us-east-1c)"]
  Evelyn2_Dev_Availability_zone_elb         = ["us-east-1a", "us-east-1c"]


  # for ELB 4xx
     LB_Evelyn2_Dev_4xx_elb                    = ["app/Evelyn2-Dev/3d6432d10c6ce004",
                                          "app/Evelyn2-Dev/3d6432d10c6ce004"]

   LB_Evelyn2_Dev_Internal_4xx_elb             = ["app/Evelyn2-Dev-Internal/ee9cb88fb4dcbdb5",
                                          "app/Evelyn2-Dev-Internal/ee9cb88fb4dcbdb5"]

   Evelyn2_Dev_ELB_Alarm_Name_4xx_elb          = ["Evelyn2_Dev - ELB - High - Dev - ELB 4XX (us-east-1a)",
                                           "Evelyn2_Dev - ELB - High - Dev - ELB 4XX (us-east-1c)"]

  Evelyn2_Dev_Internal_ELB_Alarm_Name_4xx_elb   = ["Evelyn2_Dev - ELB - High - Dev-Internal - ELB 4XX (us-east-1a)",
                                           "Evelyn2_Dev - ELB - High - Dev-Internal - ELB 4XX (us-east-1c)"]
  Evelyn2_Dev_Availability_zone_4xx_elb         = ["us-east-1a", "us-east-1c"]

  # ELB target Resoponse time.
  

  LB_Evelyn2_Dev_trt                    = "app/Evelyn2-Dev/3d6432d10c6ce004"
                                          
    LB_Evelyn2_Dev_Internal_trt            = "app/Evelyn2-Dev-Internal/ee9cb88fb4dcbdb5"
                                          
   Evelyn2_Dev_ELB_Alarm_Name_trt         = "Evelyn2_Dev - Warning - ELB - Target-Response-Time - (Dev)"
                                            
   Evelyn2_Dev_Internal_ELB_Alarm_Name_trt   = "Evelyn2_Dev - Warning - ELB - Target-Response-Time - (Dev-Internal)"
                                              
  Evelyn2_Dev_Availability_zone_trt         = "us-east-1c"
  





                                         



                                                                                                                  



