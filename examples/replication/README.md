# Cloud Object Storage replication example


Module repository link: https://github.com/kbiegert/terraform-ibm-cos

This example creates the following infrastructure:
- A new resource group, if one is not passed in.
- A new Cloud Object Storage instances in the given resource group and region.
- A COS source bucket with versioning.
- A COS target bucket with versioning.
- An IAM authorization policy to let the source instance write to the target bucket.
- A rule to copy everything from the source bucket to the target bucket.

This is a basic example with the COS instances and buckets in the same account, same resource group and same region. Most use cases for replication will dictate different regions and/or accounts. This example uses a single rule to a single destination; other options are multiple rules, multiple destinations, selective replication, replication of deletes and bi-directional replication (add a rule to the target destination to write to the source).

This example is one way to use the [**terraform-ibm-cos module**](https://github.com/kbiegert/terraform-ibm-cos) found in the repository above.

## Usage
```
module "replication" {
  source           = "https://cm.globalcatalog.cloud.ibm.com/api/v1-beta/offering/source?archive=tgz&kind=terraform&name=terraform-ibm-cos&version=0.0.6"
  ibmcloud_api_key = var.ibmcloud_api_key
  region           = "us-south"
  prefix           = "test-cos"
  resource_tags    = var.resource_tags
  resource_group   = var.resource_group
  access_tags      = var.access_tags
}
```