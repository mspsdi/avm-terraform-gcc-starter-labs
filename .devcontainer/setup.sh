if [ "${CODESPACES}" = "true" ]; then
    # Remove the default credential helper
    sudo sed -i -E 's/helper =.*//' /etc/gitconfig

    # Add one that just uses secrets available in the Codespace
    git config --global credential.helper '!f() { sleep 1; echo "username=${GITHUB_USER}"; echo "password=${GH_TOKEN}"; }; f'
fi

sudo chmod 666 /var/run/docker.sock || true
# sudo cp -R /tmp/.ssh-localhost/* ~/.ssh
sudo chown -R $(whoami):$(whoami) ~ || true ?>/dev/null
sudo chmod 400 ~/.ssh/*

git config --global core.editor vim
pre-commit install
pre-commit autoupdate

git config --global --add safe.directory /tf/caf
# git config --global --add safe.directory /tf/caf/landingzones
# git config --global --add safe.directory /tf/caf/landingzones/aztfmod
# git config --global --add safe.directory /tf/caf/aztfmod
git config --global --add safe.directory /tf/caf/templates
git config --global --add safe.directory /tf/caf/modules
git config --global --add safe.directory /tf/caf/gcc_starter_kit

git config pull.rebase false 

git clone https://github.com/mspsdi/avm-terraform-gcc-starter-kit /tf/caf
mkdir /tf/caf/gcc_starter_labs
cp /tf/caf/templates/landingzone/configuration/0-setup_gcc_dev_env /tf/caf/gcc_starter_labs/landingzone/configuration/0-setup_gcc_dev_env
cp /tf/caf/templates/landingzone/configuration/0-launchpad/launchpad /tf/caf/gcc_starter_labs/landingzone/configuration/0-launchpad/launchpad
cp /tf/caf/templates/landingzone/configuration/1-landingzones/networking_template /tf/caf/gcc_starter_labs/landingzone/configuration/1-landingzones/networking_template
cp /tf/caf/templates/landingzone/configuration/2-solution_accelerators/project/solution_accelerators_template /tf/caf/gcc_starter_labs/landingzone/configuration/2-solution_accelerators/project/solution_accelerators_template
