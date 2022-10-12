# Copyright (c) 2022, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl


resource "oci_devops_deploy_stage" "adminapi_auth_fn_deploy" {
  deploy_pipeline_id = oci_devops_deploy_pipeline.deploy_pipeline_adminapi_authorizer.id
  deploy_stage_predecessor_collection {
    items {
      id = oci_devops_deploy_pipeline.deploy_pipeline_adminapi_authorizer.id
    }
  }
  deploy_stage_type = "DEPLOY_FUNCTION"


  description  = "adminapi authorizer function deployment"
  display_name = "adminapi_authorizer function_deployment"

  namespace                       = "default"
  function_deploy_environment_id  = oci_devops_deploy_environment.function_environment_adminapi_authorizer.id
  docker_image_deploy_artifact_id = oci_devops_deploy_artifact.adminapi_authorizer_service_image.id
  defined_tags                    = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}
