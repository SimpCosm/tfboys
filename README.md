# tfboys

tfboys records process learning terraform.

1. replace your secret id and secret key

2. execute `terraform init`

3. execute `terraform plan`

```
terraform plan
data.tencentcloud_vpc_instances.testvpc: Reading...
data.tencentcloud_image.ubuntu: Reading...
data.tencentcloud_instance_types.node: Reading...
data.tencentcloud_vpc_instances.testvpc: Read complete after 3s [id=1ece10e384e8263741e57cf1fef53854]
data.tencentcloud_vpc_subnets.testsubnet: Reading...
data.tencentcloud_image.ubuntu: Read complete after 3s [id=2103607329]
data.tencentcloud_instance_types.node: Read complete after 3s [id=2803967459]
data.tencentcloud_vpc_subnets.testsubnet: Read complete after 5s [id=554838c4f92006f6972efcab7c4eeed1]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # tencentcloud_instance.testcvm[0] will be created
  + resource "tencentcloud_instance" "testcvm" {
      + allocate_public_ip                      = true
      + availability_zone                       = "ap-hongkong-2"
      + create_time                             = (known after apply)
      + disable_monitor_service                 = false
      + disable_security_service                = false
      + expired_time                            = (known after apply)
      + force_delete                            = false
      + hostname                                = "testcvm"
      + id                                      = (known after apply)
      + image_id                                = "img-22trbn9x"
      + instance_charge_type                    = "POSTPAID_BY_HOUR"
      + instance_charge_type_prepaid_renew_flag = (known after apply)
      + instance_name                           = "testcvm"
      + instance_status                         = (known after apply)
      + instance_type                           = "SA2.MEDIUM2"
      + internet_charge_type                    = "TRAFFIC_POSTPAID_BY_HOUR"
      + internet_max_bandwidth_out              = 1
      + key_name                                = "skey-fs20cbyx"
      + private_ip                              = (known after apply)
      + project_id                              = 0
      + public_ip                               = (known after apply)
      + running_flag                            = true
      + security_groups                         = (known after apply)
      + subnet_id                               = "subnet-huah08rx"
      + system_disk_id                          = (known after apply)
      + system_disk_size                        = 50
      + system_disk_type                        = "CLOUD_PREMIUM"
      + tags                                    = {
          + "test" = "test"
        }
      + vpc_id                                  = "vpc-oxvl7igi"

      + data_disks {
          + data_disk_id           = (known after apply)
          + data_disk_size         = 50
          + data_disk_type         = "CLOUD_PREMIUM"
          + delete_with_instance   = true
          + encrypt                = false
          + throughput_performance = 0
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
```

4. exec `terraform apply` and input yes

```
Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

tencentcloud_instance.testcvm[0]: Creating...
tencentcloud_instance.testcvm[0]: Still creating... [10s elapsed]
tencentcloud_instance.testcvm[0]: Still creating... [20s elapsed]
tencentcloud_instance.testcvm[0]: Still creating... [30s elapsed]
tencentcloud_instance.testcvm[0]: Still creating... [40s elapsed]
tencentcloud_instance.testcvm[0]: Creation complete after 41s [id=ins-3uz3y0xs]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

You can see on you console from cloud provider that a new VM has been created.

5. exec `terraform destroy` and destroy the VM.

# Reference
- https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs
