resource "asa_project" "demo-project" {
  project_name = "tf-test"
  next_unix_uid = 60120
  next_unix_gid = 63020
}

resource "asa_enrollment_token" "test-token" {
  project_name = "${asa_project.demo-project.project_name}"
  description  = "Token for X"
}

resource "asa_enrollment_token" "test-import-token" {
  project_name = "${asa_project.demo-project.project_name}"
  description  = "Token for Y"
}

resource "asa_create_group" "test-tf-group" {
  name = "test-tf-group"
}

resource "asa_create_group" "cloud-sre" {
  name = "cloud-sre"
}

resource "asa_create_group" "cloud-support" {
  name = "cloud-support"
}

resource "asa_assign_group" "test-sft-group-assignment" {
  project_name = "${asa_project.demo-project.project_name}"
  group_name   = "${asa_create_group.test-tf-group.name}"
}

resource "asa_assign_group" "group-assignment" {
  project_name        = "${asa_project.demo-project.project_name}"
  group_name          = "cloud-sre"
  server_access       = true
  server_admin        = true
  create_server_group = false
}

resource "asa_assign_group" "dev-group-assignment" {
  project_name  = "${asa_project.demo-project.project_name}"
  group_name    = "cloud-support"
  server_access = true
  server_admin  = false
}

output "enrollment_token" {
  value = "${asa_enrollment_token.test-token.token_value}"
}
