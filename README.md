# Polkadot Fullnode Deployment and Update Automation

Objective: Automate the deployment and update process for a Polkadot Fullnode using Terraform and Ansible.
Task Requirements:

1. Create a repository on GitLab or GitHub for version control and collaboration.
2. Use Terraform to create IAC files for provisioning two instances on your AWS.
3. Write an Ansible playbook to automate the deployment of the Polkadot binary v1.0.0 to the two instances. 
4. Configure the playbook to create and manage a systemd service file that will run the Polkadot Fullnode.
5. Write a brief description explaining how you would update the Polkadot nodes to v1.2.0 using your playbook

- For upgrading the node we need to download the new version v1.2.0.
- After that we do a backup of the current version
- We move the new downloaded version to the bin folder and we assign execute permissions
- After that we restart the service

Note: See update.yml file
