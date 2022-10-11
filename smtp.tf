## Copyright (c) 2022, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl


resource "oci_identity_smtp_credential" "test_smtp_credential" {
  #Required
  provider = oci.home_region
  description = "SMTP Credentials for ${var.app_name}"
  user_id = var.user_ocid
}

