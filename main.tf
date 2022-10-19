terraform {
  required_providers {
    tencentcloud = {
      source  = "tencentcloudstack/tencentcloud"
      version = "1.66.3"
    }
  }
}

provider "tencentcloud" {
  secret_id  = "********************************" # 云 API 密钥 SecretId
  secret_key = "********************************" # 云 API 密钥 SecretKey
  region     = "ap-hongkong" # 地域，完整可用地域列表参考: https://cloud.tencent.com/document/product/213/6091
}

data "tencentcloud_image" "ubuntu" {
  image_name_regex = "Ubuntu Server 20.04 LTS 64bit" # 操作系统镜像名

  filter {
    name   = "image-type"
    values = ["PUBLIC_IMAGE"]
  }
}

data "tencentcloud_instance_types" "node" {
  exclude_sold_out = true # 忽略已售罄的机型
  filter {
    name   = "instance-charge-type"
    values = ["POSTPAID_BY_HOUR"] # 过滤出支持按量计费的机型
  }
  filter {
    name   = "zone"
    values = ["ap-hongkong-2"] # 过滤出可用区中可用的机型
  }
  cpu_core_count = 2 # 过滤 CPU 规格
  memory_size    = 2 # 过滤内存规格
}

data "tencentcloud_vpc_instances" "testvpc" {
  name = "testvpc" # 指定 VPC 名称
}

data "tencentcloud_vpc_subnets" "testsubnet" {
  vpc_id = data.tencentcloud_vpc_instances.testvpc.instance_list.0.vpc_id
  name   = "test-subnet-2" # 指定子网名称
}

resource "tencentcloud_instance" "testcvm" {
  count                      = 1 # 创建机器的数量
  instance_name              = "testcvm" # CVM 实例名称
  hostname                   = "testcvm" # CVM hostname
  system_disk_type           = "CLOUD_PREMIUM" # 系统盘类型：高性能云盘
  system_disk_size           = 50 # 系统盘大小：50GB
  project_id                 = 0 # 默认项目
  key_name                   = "skey-fs20cbyx" # SSH 密钥 ID
  instance_charge_type       = "POSTPAID_BY_HOUR" # 实例计费模式：按量计费
  allocate_public_ip         = true # 是否分配公网 IP
  internet_max_bandwidth_out = 1 # 公网流量带宽限制：100GB
  internet_charge_type       = "TRAFFIC_POSTPAID_BY_HOUR" # 公网流量计费模式：按使用流量
  availability_zone          = data.tencentcloud_vpc_subnets.testsubnet.instance_list.0.availability_zone # CVM 可用区跟随子网可用区
  image_id                   = data.tencentcloud_image.ubuntu.image_id
  instance_type              = data.tencentcloud_instance_types.node.instance_types.0.instance_type
  vpc_id                     = data.tencentcloud_vpc_instances.testvpc.instance_list.0.vpc_id
  subnet_id                  = data.tencentcloud_vpc_subnets.testsubnet.instance_list.0.subnet_id


  data_disks {
    data_disk_type = "CLOUD_PREMIUM" # 50GB 高性能云硬盘
    data_disk_size = 50
    encrypt        = false
  }

  tags = {
    test = "test" # 打上腾讯云标签
  }
}

