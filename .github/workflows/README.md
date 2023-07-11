# How to Add Neu schulcloud Repository and trigger it with Auto deployment:

[1:] Create new Schulcloud Repo with no Template, add name and clear Description,
Owner hpi-schul-cloud, Public, add Readme, AGPL-3.0 license.

[2:] add .github/workflow folder contains the Jobs that should run on github Actions

[3:] add ansible folder contain the group_vars Folder and roles Folder

[4:] add this Repo configuration to dof_app_deploy 
        -add Repo to Workflows
        -add action to host
        -add core to the playbook/playbook_rollout/playbook_clean
        -commit changes.

[5:] Ask DevOps Admins to Release the Secrets for this Repo 

[6:] make sure that the jobs are running on dof_app_deploy, then run the Jobs on the Repo should be works