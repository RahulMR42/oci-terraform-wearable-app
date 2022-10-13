## Copyright (c) 2022, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_bastion_bastion" "test_bastion" {
  #Required
  bastion_type = "standard"
  compartment_id = var.compartment_ocid
  target_subnet_id = oci_core_subnet.application_private_subnet

  #Optional
  client_cidr_block_allow_list = ["0.0.0.0"]
  defined_tags = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }

}