## Copyright (c) 2022, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_devops_repository" "test_repository" {
  #Required
  name       = var.repository_name
  project_id = oci_devops_project.test_project.id

  #Optional
  default_branch = var.repository_default_branch
  description    = var.repository_description

  repository_type = var.repository_repository_type
}


resource "null_resource" "clonerepo" {

  depends_on = [oci_devops_project.test_project, oci_devops_repository.test_repository]

  provisioner "local-exec" {
    command = "echo '(1) Cleaning local repo: '; rm -rf ${oci_devops_repository.test_repository.name}"
  }

  provisioner "local-exec" {
    command = "echo '(2) Repo to clone: https://devops.scmservice.${var.region}.oci.oraclecloud.com/namespaces/${local.ocir_namespace}/projects/${oci_devops_project.test_project.name}/repositories/${oci_devops_repository.test_repository.name}'"
  }

  #provisioner "local-exec" {
  #  command = "echo '(3) Preparing git-askpass-helper script... '; current_dir=$PWD; chmod +x $current_dir/git-askpass-helper.sh"
  #}

  provisioner "local-exec" {
    command = "echo '(3) Starting git clone command... '; echo 'Username: Before' ${var.oci_user_name}; echo 'Username: After' ${local.encode_user}; echo 'auth_token' ${local.auth_token}; git clone https://${local.encode_user}:${local.auth_token}@devops.scmservice.${var.region}.oci.oraclecloud.com/namespaces/${local.ocir_namespace}/projects/${oci_devops_project.test_project.name}/repositories/${oci_devops_repository.test_repository.name};"
  }

  provisioner "local-exec" {
    command = "echo '(4) Finishing git clone command: '; ls -latr ${oci_devops_repository.test_repository.name}"
  }
}

resource "null_resource" "clonefromgithub" {

  provisioner "local-exec" {
    command = "rm -rf ./${var.git_repo_name}"
  }

  provisioner "local-exec" {
    command = "git clone ${var.git_repo};"
  }
}

resource "null_resource" "update_placeholders" {
  provisioner "local-exec" {
    environment = {
      DATA_SOURCE_URL_OCID_VALUE = oci_vault_secret.db_source_env_url.id
      DATA_SOURCE_USER_OCID_VALUE = oci_vault_secret.db_source_env_user.id
      DATA_SOURCE_PASS_OCID_VALUE = oci_vault_secret.db_source_env_password.id
      HMAC_KEY_SECRET_OCID_VALUE = oci_vault_secret.hmac_key_secret_jwt.id
      VAULT_OCID = oci_kms_vault.vault.id
      REGION_ID = var.region
    }
    command = <<-EOT
      cat ${var.git_repo_name}/admin-api/func.yaml|envsubst > ${var.git_repo_name}/admin-api/func.yaml.tmp
      mv ${var.git_repo_name}/admin-api/func.yaml.tmp ${var.git_repo_name}/admin-api/func.yaml
      cat ${var.git_repo_name}/admin-api-authorizer/func.yaml|envsubst >${var.git_repo_name}/admin-api-authorizer/func.yaml.tmp
      mv ${var.git_repo_name}/admin-api-authorizer/func.yaml.tmp ${var.git_repo_name}/admin-api-authorizer/func.yaml
      cat ${var.git_repo_name}/external-secret-manifest/es-manifest.yaml|envsubst>${var.git_repo_name}/external-secret-manifest/es-manifest.yaml.tmp
      mv ${var.git_repo_name}/external-secret-manifest/es-manifest.yaml.tmp ${var.git_repo_name}/external-secret-manifest/es-manifest.yaml
    EOT

  }
}


resource "null_resource" "copyfiles" {

  depends_on = [null_resource.clonerepo]

  provisioner "local-exec" {
    command = "rm -rf ${var.git_repo_name}/.git; cp -pr ${var.git_repo_name}/* ${oci_devops_repository.test_repository.name}/; cd .."
  }
}


resource "null_resource" "pushcode" {

  depends_on = [null_resource.copyfiles]

  provisioner "local-exec" {
    command = "cd ./${oci_devops_repository.test_repository.name}; git config --global user.email 'test@example.com'; git config --global user.name '${var.oci_user_name}';git add .; git commit -m 'added latest files'; git push origin '${var.repository_default_branch}'"
  }
}


locals {
  encode_user = urlencode(var.oci_user_name)
  auth_token  = urlencode(var.oci_user_authtoken)
}
