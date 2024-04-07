# Lab 3 - Create Virtual Subnets

## Step 1
### Navigate to the directory: /tf/avm/gcc_starter_kit_labs/1-landingzones/applications.

```bash
cd /tf/avm/gcc_starter_kit_labs/1-landingzones/applications
```

## Step 2
### Duplicate the folder named "network_template" and rename the duplicate as "network_project".

## Step 3
### In the file resource_groups.tf, locate line 2 and replace "yourvnetname" with "project".

## Step 4
### Confirm that in the file main.virtual_subnets.tf, line 6 reads as follows:

```bash
subnets = local.global_settings.subnets.project
```

## Step 5
### Take some time to explore the remaining files within the folder to enhance your understanding.
