## Copyright (c) 2022, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_apigateway_gateway" "test_gateway" {
  compartment_id             = var.compartment_ocid
  defined_tags               = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
  display_name               = "${var.app_name}_${var.gateway_displayname}"
  endpoint_type              =  var.gateway_visibility
  freeform_tags              = {}
  network_security_group_ids = []
#  state                      = "ACTIVE"
  subnet_id                  = oci_core_subnet.oke_lb_subnet[0].id

  response_cache_details {
    connect_timeout_in_ms  = 0
    is_ssl_enabled         = false
    is_ssl_verify_disabled = false
    read_timeout_in_ms     = 0
    send_timeout_in_ms     = 0
    type                   = "NONE"
  }

  timeouts {}
}
