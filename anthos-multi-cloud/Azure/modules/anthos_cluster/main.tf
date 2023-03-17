/**
 * Copyright 2022 Google LLC
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

/*
 * Full Cluster terraform: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_azure_cluster
 * Full Node Pool terraform:  https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_azure_node_pool
 * Azure client terraform: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_azure_client
*/

resource "google_container_azure_cluster" "this" {
  azure_region      = var.azure_region
  description       = "Test Azure GKE cluster created with Terraform"
  location          = var.location
  name              = var.anthos_prefix
  resource_group_id = var.resource_group_id
  azure_services_authentication {
    tenant_id      = var.tenant_id
    application_id = var.application_id
  }
  authorization {
    dynamic "admin_users" {
      for_each = var.admin_users

      content {
        username = admin_users.value
      }
    }
  }
  control_plane {
    subnet_id = var.subnet_id
    tags = {
      "client" : "Terraform"
    }
    version = var.cluster_version
    vm_size = var.control_plane_instance_type
    main_volume {
      size_gib = 8
    }
    root_volume {
      size_gib = 32
    }
    ssh_config {
      authorized_key = var.ssh_public_key
    }
  }
  networking {
    pod_address_cidr_blocks     = var.pod_address_cidr_blocks
    service_address_cidr_blocks = var.service_address_cidr_blocks
    virtual_network_id          = var.virtual_network_id
  }
  fleet {
    project = var.fleet_project
  }
  timeouts {
    create = "45m"
    update = "45m"
    delete = "45m"
  }
}

resource "google_container_azure_node_pool" "azure_node_pool" {
  cluster   = google_container_azure_cluster.this.id
  version   = var.cluster_version
  location  = var.location
  name      = "${var.anthos_prefix}-np-1"
  subnet_id = var.subnet_id
  autoscaling {
    min_node_count = 2
    max_node_count = 5
  }
  config {
    tags = {
      "client" : "Terraform"
    }
    vm_size = var.node_pool_instance_type
    root_volume {
      size_gib = 32
    }
    ssh_config {
      authorized_key = var.ssh_public_key
    }
  }
  max_pods_constraint {
    max_pods_per_node = 110
  }
  timeouts {
    create = "45m"
    update = "45m"
    delete = "45m"
  }
}
