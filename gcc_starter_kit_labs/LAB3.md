# 1. Navigate to the directory: /tf/avm/gcc_starter_kit_labs/1-landingzones/applications.

cd /tf/avm/gcc_starter_kit_labs/1-landingzones/applications

# 2. Duplicate the folder named "network_template" and rename the duplicate as "network_project".

# 3. In the file resource_groups.tf, locate line 2 and replace "yourvnetname" with "project".

# 4. Confirm that in the file main.virtual_subnets.tf, line 6 reads as follows:

subnets = local.global_settings.subnets.project

# 5. Take some time to explore the remaining files within the folder to enhance your understanding.
