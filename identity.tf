
## Copyright (c) 2022, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

## Dynamic Groups

resource "oci_identity_dynamic_group" "dg_instances" {
  provider       = oci.home_region
  name           = "${var.app_name}_instances_dg_${random_id.tag.hex}"
  description    = "DevOps  pipeline dynamic group"
  compartment_id = var.tenancy_ocid
  matching_rule  = "Any {ALL {resource.type = 'instance-family', resource.compartment.id = '${var.compartment_ocid}'},ALL {resource.type = 'fnfunc',resource.compartment.id = '${var.compartment_ocid}'}}"
}

resource "oci_identity_dynamic_group" "dg_devops" {
  provider       = oci.home_region
  name           = "${var.app_name}_devops_dg_${random_id.tag.hex}"
  description    = "DevOps  pipeline dynamic group"
  compartment_id = var.tenancy_ocid
  matching_rule  = "Any {ALL {resource.type = 'instance-family', resource.compartment.id = '${var.compartment_ocid}'},ALL {resource.type = 'devopsdeploypipeline', resource.compartment.id = '${var.compartment_ocid}'},ALL {resource.type = 'devopsrepository', resource.compartment.id = '${var.compartment_ocid}'},ALL {resource.type = 'devopsbuildpipeline',resource.compartment.id = '${var.compartment_ocid}'}}"
}

## Policies

