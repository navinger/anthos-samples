/**
 * Copyright 2021 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

terraform {
  required_version = ">= v0.15.5, < 1.2" # this line should not change during a release
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 3.68.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 3.68.0"
    }
  }

  provider_meta "google" {
    # Anthos Bare metal version used in this release is 1.12.2
    # See
    # - https://github.com/GoogleCloudPlatform/anthos-samples/blob/main/anthos-bm-gcp-terraform/resources/templates/anthos_gce_cluster.tpl#L20
    # - https://github.com/GoogleCloudPlatform/anthos-samples/blob/main/anthos-bm-gcp-terraform/resources/init_vm.sh#L180
    module_name = "anthos-samples/terraform/anthos-bm-terraform:gce/v0.12.2"
  }

}

provider "google" {
  project     = var.project_id
  region      = var.region
  zone        = var.zone
  credentials = file(var.credentials_file)
}

provider "google-beta" {
  project     = var.project_id
  region      = var.region
  zone        = var.zone
  credentials = file(var.credentials_file)
}
