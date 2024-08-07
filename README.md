# Arista ContainerLab AVD Deployment

## Disclaimer!
I'll start by saying that I am not a developer, nor do I resemble anything close to a developer.
The code you will find in this repository is most likely offensive to developers everywhere and for that I apologise.

# Exec Summary
This 'code' is designed to use AVD to deploy a Spine/Leaf topology via CVP using ContainerLab devices.
Features include:
- Automatically install all dependencies (docker, containerlab, pip, avd, etc...)
- Automatically deploy containerlab toplogy
- Automatic provisioning into On-Prem CVP or CVaaS
- Automatic creation of management configlets
- Automatically runs both Build and Deploy playbooks
- View Ansible output from Build and Deploy playbooks after they have run
- Host AVD generated documentation with apache container

# Requirements
In order for arista-avd-clab to work, it requires the following:
 - A Supported OS (Debian, Ubuntu or Linux Mint)
 - [Docker](https://docker.com)
 - [ContainerLab](https://containerlab.dev/)
 - [Python 3.10.0+](https://www.python.org/)
 - [Python-pip](https://pypi.org/project/pip/)
 - [Ansible](https://ansible.com)
 - [AVD](https;//avd.sh)
 - A supported cEOS image (cEOS-4.28.0F and above)

The script will automatically install any missing dependencies
All thats require to get started is git and python

# avd-clab Install Instructions
Clone the repository using `git clone https://github.com/CameronPrior/avd-clab.git` into a directory of your choosing.
After the repo has been cloned, navigate into the directory and run `sudo python3 avd_helper` and the rest will take care of itself. 

## Python Modules Used
I have utilised three external python modules in this script:
- [cvPrac](https://github.com/aristanetworks/cvprac) - Which is a RESTful API client for Cloudvision® Portal (CVP) which can be used for building applications that work with Arista CVP
- [requests](https://pypi.org/project/requests/) - The python HTTP library
- [docker](https://pypi.org/project/docker/) - The Python Docker library
- [paramiko](https://www.paramiko.org/) - The Python SSH library

# cEOS Install Instructions
The script will check to see if you have a valid cEOS image already imported into docker, if you dont it will check the EOS folder for a valid cEOS-lab.tar file.
If it cant find one there you will get an error which leaves you with two options, either copy a valid cEOS-lab.tar file to the EOS directory and run the script again OR manually import the image into docker.

Manual Import Instructions </br>
Once a supported cEOS image has been downloaded use the `docker import {CEOS FILENAME} {IMAGE NAME}` command, e.g. `docker import cEOS-lab-4.32.0F.tar ceosimage:4.32.0F`.
This command imports the container image that you downloaded and saves it into the docker image repository using the *image_name* you have given it.
You need to follow the correct image naming standard of ceosimage:#.##.##(.#)

# avd-clab Instructions
On first run, the script will prompt you for a CVP Service Token.<br />
The script provides instructions on how to generate these tokens so just follow those and you will be fine.<br />
The 'Deploy Lab' menu option will deploy the lab, register the devices with CVP, provision the devices in CVP, and run the Ansible Build and Deploy playbooks.<br />
The 'Cleanup Lab' menu option will destroy the lab, decommission the devices from CVP, and remove all configlets and containers from CVP. <br />
The 'Open Topology Documentation' menu options will start an apache docker container and host a directory listing which contains all of the AVD generated documentation allowing for easy viewing.<br />

# Topologies
The following topologies are included:

### Single Data Center with MLAG
![SDC-MLAG](https://user-images.githubusercontent.com/680877/222593712-17c56723-d3e8-4902-a2a1-673cda7629b0.png)

# AVD Generated Documentation
AVD will generate Fabric and Device documentation that can be found in the ./sites/dc1 folder after the script has finished running.

# On-Prem CloudVision Setup
In order to use CVP with ContainerLab, the CVP host needs a static route configured back to the management range you have configured.
When configuring CVP, I used the same interface for both the Cluster Interface and the Device Interface.
After CVP is up and running, add a static route using the `ip route add 172.16.100.0 via {DOCKER HOST IP} dev eth0` command.
The default range used for this deployment is 172.16.100.0/24

### CloudVision Setup Diagram
![CVP Config](https://user-images.githubusercontent.com/680877/222660607-a5fa8d7a-d500-43aa-9400-3a24ed21c60d.png)

