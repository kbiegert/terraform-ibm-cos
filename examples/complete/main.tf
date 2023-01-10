##############################################################################
# Resource Group
##############################################################################

module "resource_group" {
  source = "git::https://github.com/terraform-ibm-modules/terraform-ibm-resource-group.git?ref=v1.0.5"
  # if an existing resource group is not set (null) create a new one using prefix
  resource_group_name          = var.resource_group == null ? "${var.prefix}-resource-group" : null
  existing_resource_group_name = var.resource_group
}

##############################################################################
# Observability Instances (Sysdig + AT)
##############################################################################

# Create Sysdig and Activity Tracker instance
module "observability_instances" {
  source                         = "git::https://github.com/terraform-ibm-modules/terraform-ibm-observability-instances?ref=v1.1.1"
  region                         = var.region
  resource_group_id              = module.resource_group.resource_group_id
  activity_tracker_instance_name = "${var.prefix}-at"
  sysdig_instance_name           = "${var.prefix}-sysdig"
  activity_tracker_plan          = "7-day"
  sysdig_plan                    = "graduated-tier"
  enable_platform_logs           = false
  enable_platform_metrics        = false
  logdna_provision               = false
  activity_tracker_tags          = var.resource_tags
  logdna_tags                    = var.resource_tags
  sysdig_tags                    = var.resource_tags
}

##############################################################################
# Create Key Protect resources
##############################################################################

locals {
  key_ring_name = "cos-key-ring"
  key_name      = "cos-key"
}

module "key_protect_all_inclusive" {
  source                    = "git::https://github.com/terraform-ibm-modules/terraform-ibm-key-protect-all-inclusive.git?ref=v3.0.2"
  key_protect_instance_name = "${var.prefix}-kp"
  resource_group_id         = module.resource_group.resource_group_id
  enable_metrics            = false
  region                    = var.region
  key_map = {
    (local.key_ring_name) = [local.key_name]
  }
  resource_tags = var.resource_tags
}

# Create COS instance and Key protect instance.
# Create COS bucket-1 with:
# - Retention
# - Encryption
# - Monitoring
# - Activity Tracking
module "cos_bucket1" {
  source                             = "../../"
  resource_group_id                  = module.resource_group.resource_group_id
  region                             = var.region
  cos_instance_name                  = "${var.prefix}-cos"
  cos_tags                           = var.resource_tags
  bucket_name                        = "${var.prefix}-bucket-1"
  existing_key_protect_instance_guid = module.key_protect_all_inclusive.key_protect_guid
  key_protect_key_crn                = module.key_protect_all_inclusive.keys["${local.key_ring_name}.${local.key_name}"].crn
  sysdig_crn                         = module.observability_instances.sysdig_crn
  activity_tracker_crn               = module.observability_instances.activity_tracker_crn
}

# We will reuse the COS instance, Key Protect instance and Key Protect Key Ring / Key that were created in cos_bucket1 module.
# Create COS bucket-2 with:
# - Retention
# - Encryption
# - Monitoring
# - Activity Tracking
module "cos_bucket2" {
  source                   = "../../"
  bucket_name              = "${var.prefix}-bucket-2"
  resource_group_id        = module.resource_group.resource_group_id
  region                   = var.region
  sysdig_crn               = module.observability_instances.sysdig_crn
  activity_tracker_crn     = module.observability_instances.activity_tracker_crn
  create_cos_instance      = false
  existing_cos_instance_id = module.cos_bucket1.cos_instance_id
  key_protect_key_crn      = module.key_protect_all_inclusive.keys["${local.key_ring_name}.${local.key_name}"].crn
}
