### Copyright (c) 2022, Oracle and/or its affiliates.
### All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

variable "tenancy_ocid" {}
variable "compartment_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "region" {}

variable "app_name" {
  default     = "cwiotapp"
  description = "Application name. Will be used as prefix to identify resources, such as OKE, VCN, DevOps, and others"
}

variable "oci_user_name" {}
variable "oci_user_authtoken" {}

variable "release" {
  description = "Reference Architecture Release (OCI Architecture Center)"
  default     = "1.1"
}


/*API Gateway Variables **********/

variable "gateway_displayname" {
  default = "apigateway"
}

variable "gateway_visibility" {
  default = "PUBLIC"
}

/********** API Gateway Variables **********/

/********** VCN Variables **********/
variable "VCN-CIDR" {
  default = "10.100.0.0/16"
}

variable "Public-Subnet-CIDR" {
  default = "10.100.0.0/24"
}


variable "Private-Subnet-CIDR" {
  default = "10.100.10.0/24"
}

/********** VCN Variables **********/


/********** MySQL Variables **********/

variable "availability_domain_name" {
  default = ""
}

variable "mysql_instance_compartment_name" {
  description = "Compartment where MySQL Instance will be created"
  default = ""
}

variable "mysql_network_compartment_name" {
  description = "Compartment where the network of MySQL artifact is"
  default = ""
}

variable "mysql_instance_compartment_ocid" {
  description = "OCID of the compartment where MySQL Instance will be created. Use alternatively to mysql_instance_compartment_name"
  default = ""
}

variable "mysql_network_compartment_ocid" {
  description = "OCID of the compartment where the network of MySQL artifact is. Use alternatively to mysql_network_compartment_name"
  default = ""
}

variable "mysql_db_system_admin_password" {
  description = "(Required) The password for the administrative user. The password must be between 8 and 32 characters long, and must contain at least 1 numeric character, 1 lowercase character, 1 uppercase character, and 1 special (nonalphanumeric) character."
}

variable "mysql_db_system_admin_username" {
  description = "(Required) The username for the administrative user."
}


variable "mysql_db_system_backup_policy_is_enabled" {
  description = "Boolean that defines if either backup is enabled or not"
  default     = false
}

variable "mysql_db_system_backup_policy_retention_in_days" {
  description = "The number of days automated backups are retained."
  default     = 7
}

variable "mysql_db_system_backup_policy_window_start_time" {
  description = "The start of a 30-minute window of time in which daily, automated backups occur. This should be in the format of the Time portion of an RFC3339-formatted timestamp. Any second or sub-second time data will be truncated to zero. At some point in the window, the system may incur a brief service disruption as the backup is performed."
  default     = ""
}

variable "mysql_db_system_data_storage_size_in_gb" {
  description = "Initial size of the data volume in GiBs that will be created and attached."
  default = 50
}



variable "mysql_db_system_description" {
  description = "User-provided data about the DB System."
  default = "iot health db"
}

variable "mysql_db_system_freeform_tags" {
  description = "Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace."
  default = {}
}


variable "mysql_db_system_is_highly_available" {
  description = "Boolean that describes if either HA is enabled or not"
  default     = true
}

variable "mysql_db_system_port" {
  description = "(Optional) The port for primary endpoint of the DB System to listen on."
  default     = "3306"
}

variable "mysql_db_system_port_x" {
  description = "(Optional) The TCP network port on which X Plugin listens for connections. This is the X Plugin equivalent of port."
  default     = "33060"
}

variable "mysql_shape_name" {
  description = "(Required) The name of the shape. The shape determines the resources allocated. CPU cores and memory for VM shapes; CPU cores, memory and storage for non-VM (or bare metal) shapes. To get a list of shapes, use the ListShapes operation."
  default     = "MySQL.VM.Standard.E3.1.8GB"
}

variable "mysql_heatwave_enabled" {
  description = "Defines whether a MySQL HeatWave cluster is enabled"
  default     = false
}

variable "mysql_heatwave_cluster_size" {
  description = "Number of MySQL HeatWave nodes to be created"
  default     = 2
}

variable "mysql_heatwave_shape" {
  description = "The shape to be used instead of mysql_shape_name when mysql_heatwave_enabled = true."
  default     = "MySQL.HeatWave.VM.Standard.E3"
}

/********** MySQL Variables **********/
/********** Objectstorage Variables **********/
variable "bucket_access_type" {
  default = "NoPublicAccess"
}

variable "bucket_auto_tiering" {
  default = "Disabled"
}

variable "bucket_storage_tier" {
  default = "Standard"
}
variable "bucket_versioning" {
  default = "Disabled"
}
/********** Objectstorage Variables **********/

/********** Vault Variables **********/

variable "vault_vault_type" {
  default = "DEFAULT"
}

variable "vault_key_shape_algorithm" {
  default = "AES"
}

variable "key_key_shape_length" {
  default = 32
}

variable "vault_key_protection_mode" {
  default = "HSM"
}

variable "vault_app_env_user" {
  default = "root"
}

/********** Vault Variables **********/

/********** Stream Variables **********/
variable "stream_partition_count" {
  default = 1 #10
}

variable "stream_retention_in_hours" {
  default = 24
}
/********** Stream Variables **********/

/********** Queue Variables **********/
variable "oci_queue_ocid" {
  default = ""
}
/********** Queue Variables **********/

/********** SMTP Variables **********/
variable "smtp_from_address" {
  default = "test@test.coom"
}

variable "auth_profile" {
  default = "InstancePrincipal"
}

/********** SMTP Variables **********/

variable "smtp_from_user_mail" {

}

/********** Devops Variables **********/
variable "project_logging_config_retention_period_in_days" {
  default = 30
}

variable "project_description" {
  default = "DevOps CI/CD Sample Project for IOT Wearable app"
}

#variable "build_pipeline_description" {
#  default = "build pipeline for python application with canary deployment strategies"
#}
#
#variable "build_pipeline_display_name" {
#  default = "oci_devops_canary-build-pipeline"
#}
#
variable "repository_name" {
  default = "java-oci-wearable"
}

variable "repository_default_branch" {
  default = "main"
}

variable "repository_description" {
  default = "OCI Wearable APP Code base"
}

variable "git_repo" {
  default = "https://github.com/karankap/oci-wearable-demo"
}

variable "git_repo_name" {
  default = "oci-wearable-demo"
}

variable "buildparam_baseimage_notificationservice" {
  default = "adoptopenjdk/openjdk8"
}
locals {
  ocir_docker_repository = join("", [lower(lookup(data.oci_identity_regions.current_region.regions[0], "key")), ".ocir.io"])
  #ocir_docker_repository = join("", [lower(lookup(data.oci_identity_regions.home_region.regions[0], "key")), ".ocir.io"])
  #ocir_namespace = lookup(data.oci_identity_tenancy.oci_tenancy, "name" )
  ocir_namespace = lookup(data.oci_objectstorage_namespace.ns, "namespace")
}

##variable "ocir_region" {
## default = "iad"}
#
#variable "deploy_artifact_deploy_artifact_source_deploy_artifact_source_type" {
#  default = "OCIR"
#}
#
#variable "deploy_artifact_deploy_artifact_type" {
#  default = "DOCKER_IMAGE"
#}
#
variable "repository_repository_type" {
  default = "HOSTED"
}
#
#variable "deploy_artifact_type" {
#  default = "KUBERNETES_MANIFEST"
#}
#
#variable "deploy_pipeline_description" {
#  default = "Devops CI/CD Pipleline demo for OKE"
#}
#
#variable "deploy_artifact_source_type" {
#  default = "INLINE"
#}
#
#variable "deploy_pipeline_deploy_pipeline_parameters_items_default_value" {
#  default = "example"
#}
#
#variable "deploy_pipeline_deploy_pipeline_parameters_items_description" {
#  default = "exampleapp"
#}
#
#variable "deploy_pipeline_deploy_pipeline_parameters_items_name" {
#  default = "namespace"
#}
#
#variable "deploy_stage_deploy_stage_type" {
#  default = "OKE_DEPLOYMENT"
#}
#
#variable "deploy_stage_description" {
#  default = "ci/cd deployment to OKE"
#}
#
#variable "execute_deployment" {
#  default = true
#}
#
#variable "build_pipeline_stage_is_pass_all_parameters_enabled" {
#  default = true
#}
#
#variable "deploy_stage_canary_ingress_name" {
#  default = "sample-oke-canary-app-ing"
#}
#
#variable "deploy_stage_canary_namespace" {
#  default = "nscanarystage"
#}
#
#variable "percentage_canary_shift" {
#  default = 25
#}
#
#variable "canary_prod_release_count_of_approval" {
#  default = 1
#}
#
#variable "canary_stage_shift_description" {
#  default = "switch the traffic between OKE environment"
#}
#
#variable "canary_stage_shift_name" {
#  default = "canary_oke_traffic_shift"
#}
#
#variable "deploy_stage_prd_namespace" {
#  default = "nscanaryprd"
#}
#
#variable "deploy_rollback_policy" {
#  default = "AUTOMATED_STAGE_ROLLBACK_POLICY"
#}
#
#variable "ingress_version" {
#  default = "v1.1.2"
#}