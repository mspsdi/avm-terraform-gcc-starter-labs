# Lab 2 - Import gcci platform vnet and log analytics workspace terraform state

## Step 1
### Navigate to the following launchpad directory: 
#### /tf/avm/gcc_starter_kit_labs/landingzone/configuration/0-launchpad/launchpad.

```bash
cd /tf/avm/gcc_starter_kit_labs/landingzone/configuration/0-launchpad/launchpad.
```

## Step 2
### In the "config.yaml" file, set the following parameters:

```bash
prefix: "<your project code prefix>"
location: "southeastasia"
environment: "sandpit"
```

## Step 3 
### Add the specified subnet names and address prefixes to line 12 of the "config.yaml" file:

```bash
WebSubnet: # DO NOT CHANGE subnet name
    address_prefixes: ["100.64.0.0/27"]
AppSubnet: # DO NOT CHANGE subnet name
    address_prefixes: ["100.64.0.32/27"]
DbSubnet: # DO NOT CHANGE subnet name
    address_prefixes: ["100.64.0.64/27"]
```

## Step 4
### Execute the "import.sh" bash script file to create the launchpad:

```bash
cd /tf/avm/gcc_starter_kit_labs/landingzone/configuration/0-launchpad/launchpad/
./import.sh
```

## Step 5
### Take some time to explore the import.sh and the remaining files within the folder to enhance your understanding.

## Step 6
### Make a record of the "resource group name" and "storage account name" generated during this lab session for future reference in Lab 4.
