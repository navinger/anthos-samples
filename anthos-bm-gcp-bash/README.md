## Anthos Baremetal on Google Compute Engine VMs

This sample shows you how to setup an Anthos clusters on bare metal in High
Availability (HA) mode using Compute Engine Virtual Machines (VMs). The
[setup_and_install_abm](./setup_and_install_abm.sh) script encapsulates all
the steps required to setup the Compute Engine VMs and to trigger the
installation of Anthos on bare metal. Follow the
[Try Anthos clusters on bare metal on Compute Engine VMs](https://cloud.google.com/anthos/clusters/docs/bare-metal/latest/try/gce-vms) guide for a step by step
explanation of all the steps included in this script.


### Prerequisites

- A workstation with access to the Internet _(i.e. Google Cloud APIs)_ with the following installed
  - [Git](https://git-scm.com/)
  - [Google Cloud SDK (gcloud CLI)](https://cloud.google.com/sdk/docs/install)
- A [Google Cloud Project](https://console.cloud.google.com/cloud-resource-manager?_ga=2.187862184.1029435410.1614837439-1338907320.1614299892) _(in which the resources for the setup will be provisioned)_
- The gcloud CLI must be [authenticated to Google Cloud and be configured to use
  the Google Cloud Project](https://cloud.google.com/sdk/gcloud/reference/init) you intend to use
---
### Quickstart

The steps inside the script is written with the assumption that you are working
with a Google Cloud Project that has most of the default settings. This is to
keep the different customizations to a minimal and allow for anyone to start at
this baseline and make changes as required. Based on the popularity of certain
variations, information about them are explained in the [FAQ](./FAQ.md) section.

1. Clone this repo into the workstation from where the rest of this guide will
   be followed.

    ```sh
    git clone https://github.com/GoogleCloudPlatform/anthos-samples
    cd anthos-bm-gcp-bash
    ```

2. Setup environment variables.
    ```sh
    export PROJECT_ID=<GCP_PROJECT_TO_USE>
    export ZONE=<GCP_ZONE_TO_USE>
    ```

3. Run the installation script.

    ```sh
    bash setup_and_install_abm.sh
    ```
    ```sh
    # expected output
    ...
    ...
    ...
    ✅ Successfully set up SSH access from admin workstation to cluster node VMs.

    🔄 Installing Anthos on bare metal...
    Your active configuration is: [shabir-shell-check2]
    Pseudo-terminal will not be allocated because stdin is not a terminal.
    Enter passphrase for key '/Users/shabirmean/.ssh/google_compute_engine':
    Welcome to Ubuntu 20.04.5 LTS (GNU/Linux 5.15.0-1018-gcp x86_64)

    * Documentation:  https://help.ubuntu.com
    * Management:     https://landscape.canonical.com
    * Support:        https://ubuntu.com/advantage

    System information as of Tue Oct  4 19:09:07 UTC 2022

    System load:  0.39               Users logged in:          0
    Usage of /:   1.3% of 193.65GB   IPv4 address for docker0: 172.17.0.1
    Memory usage: 1%                 IPv4 address for ens4:    10.128.0.2
    Swap usage:   0%                 IPv4 address for vxlan0:  10.200.0.2
    Processes:    153


    0 updates can be applied immediately.

    New release '22.04.1 LTS' available.
    Run 'do-release-upgrade' to upgrade to it.


    + export PROJECT_ID=shabir-shell-check2
    + PROJECT_ID=shabir-shell-check2
    + export clusterid=cluster-1
    + clusterid=cluster-1
    + bmctl create config -c cluster-1
    [2022-10-04 19:09:08+0000] Created config: bmctl-workspace/cluster-1/cluster-1.yaml
    + cat
    + bmctl create cluster -c cluster-1
    Please check the logs at bmctl-workspace/cluster-1/log/create-cluster-20221004-190908/create-cluster.log
    [2022-10-04 19:09:14+0000] Creating bootstrap cluster... OK
    [2022-10-04 19:10:24+0000] Installing dependency components... OK
    [2022-10-04 19:11:51+0000] Waiting for preflight check job to finish... OK
    [2022-10-04 19:13:51+0000] - Validation Category: machines and network
    [2022-10-04 19:13:51+0000]      - [PASSED] 10.200.0.5
    [2022-10-04 19:13:51+0000]      - [PASSED] 10.200.0.6
    [2022-10-04 19:13:51+0000]      - [PASSED] 10.200.0.7
    [2022-10-04 19:13:51+0000]      - [PASSED] gcp
    [2022-10-04 19:13:51+0000]      - [PASSED] 10.200.0.4-gcp
    [2022-10-04 19:13:51+0000]      - [PASSED] 10.200.0.3-gcp
    [2022-10-04 19:13:51+0000]      - [PASSED] 10.200.0.4
    [2022-10-04 19:13:51+0000]      - [PASSED] 10.200.0.5-gcp
    [2022-10-04 19:13:51+0000]      - [PASSED] 10.200.0.6-gcp
    [2022-10-04 19:13:51+0000]      - [PASSED] 10.200.0.7-gcp
    [2022-10-04 19:13:51+0000]      - [PASSED] node-network
    [2022-10-04 19:13:51+0000]      - [PASSED] pod-cidr
    [2022-10-04 19:13:51+0000]      - [PASSED] 10.200.0.3
    [2022-10-04 19:13:51+0000] Flushing logs... OK
    [2022-10-04 19:13:53+0000] Applying resources for new cluster
    [2022-10-04 19:13:53+0000] Waiting for cluster kubeconfig to become ready OK
    [2022-10-04 19:17:03+0000] Writing kubeconfig file
    [2022-10-04 19:17:03+0000] kubeconfig of cluster being created is present at bmctl-workspace/cluster-1/cluster-1-kubeconfig
    [2022-10-04 19:17:03+0000] Please restrict access to this file as it contains authentication credentials of your cluster.
    [2022-10-04 19:17:03+0000] Waiting for cluster to become ready OK
    [2022-10-04 19:23:43+0000] Please run
    [2022-10-04 19:23:43+0000] kubectl --kubeconfig bmctl-workspace/cluster-1/cluster-1-kubeconfig get nodes
    [2022-10-04 19:23:43+0000] to get cluster nodes status.
    [2022-10-04 19:23:43+0000] Waiting for node pools to become ready OK
    [2022-10-04 19:24:03+0000] Waiting for metrics to become ready in GCP OK
    [2022-10-04 19:24:13+0000] Moving admin cluster resources to the created admin cluster
    [2022-10-04 19:24:20+0000] Waiting for node update jobs to finish OK
    [2022-10-04 19:26:40+0000] Flushing logs... OK
    [2022-10-04 19:26:40+0000] Deleting bootstrap cluster... OK
    ✅ Installation complete. Please check the logs for any errors!!!
    ```
