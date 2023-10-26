# One Rate Plan Example (COS Bucket with One Rate Plan)

Module repository link: https://github.com/kbiegert/terraform-ibm-cos

This example creates the following infrastructure:
- A new resource group, if one is not passed in.
- A new Cloud Object Storage instance in the given resource group, region, and `cos-one-rate-plan` plan.
- A COS bucket with `onerate_active` plan.

This example is one way to use the [**terraform-ibm-cos module**](https://github.com/kbiegert/terraform-ibm-cos) found in the repository above.

## Usage
```
module "one-rate-plan" {
  source           = "https://cm.globalcatalog.cloud.ibm.com/api/v1-beta/offering/source?archive=tgz&kind=terraform&name=terraform-ibm-cos&version=0.0.6"
  ibmcloud_api_key = var.ibmcloud_api_key
  region           = "us-south"
  prefix           = "test-cos"
  resource_tags    = var.resource_tags
  resource_group   = var.resource_group
  access_tags      = var.access_tags
}
```