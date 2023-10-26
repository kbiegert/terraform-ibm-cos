# Basic Example

Module repository link: https://github.com/kbiegert/terraform-ibm-cos

This example creates the following infrastructure:
- A new resource group, if one is not passed in.
- A new Cloud Object Storage instance and a bucket in a resource group and region.

This example is one way to the [terraform-ibm-cos module](https://github.com/kbiegert/terraform-ibm-cos) found in the repository above.

## Usage
```
module "basic" {
  source           = "https://cm.globalcatalog.cloud.ibm.com/api/v1-beta/offering/source?archive=tgz&kind=terraform&name=terraform-ibm-cos&version=0.0.6"
  ibmcloud_api_key = var.ibmcloud_api_key
  region           = "us-south"
  prefix           = "test-cos"
  resource_tags    = var.resource_tags
  resource_group   = var.resource_group
}
```