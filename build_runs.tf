## Copyright (c) 2022, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_devops_build_run" "adminapi_buildrun" {

  depends_on = [oci_functions_application.test_fn_app,
    oci_devops_build_pipeline.build_pipeline_adminapi,
    oci_devops_deploy_pipeline.deploy_pipeline_adminapi,
    oci_devops_build_pipeline_stage.adminapi_deliver_artifact,
    oci_devops_build_pipeline_stage.adminapi_invoke_deployment
  ]

  #Required
  build_pipeline_id = oci_devops_build_pipeline.build_pipeline_adminapi.id

  #Optional
  display_name = "adminapi_build_run_${random_id.tag.hex}"
}