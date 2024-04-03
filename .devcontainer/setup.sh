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

git config --global --add safe.directory /tf/avm
# git config --global --add safe.directory /tf/avm/landingzones
# git config --global --add safe.directory /tf/avm/landingzones/aztfmod
# git config --global --add safe.directory /tf/avm/aztfmod
git config --global --add safe.directory /tf/avm/templates
git config --global --add safe.directory /tf/avm/modules
git config --global --add safe.directory /tf/avm/gcc_starter_kit

git config pull.rebase false 

if [ ! -d /tf/avm/gcc_starter_kit ]; then
    git clone https://github.com/mspsdi/avm-terraform-gcc-starter-kit /tf/avm/tmp
    mv /tf/avm/tmp/gcc_starter_kit /tf/avm/gcc_starter_kit
    mv /tf/avm/tmp/templates /tf/avm/templates
    mv /tf/avm/tmp/modules /tf/avm/modules
    sudo chmod 777 /tf/avm/gcc_starter_kit
    mkdir /tf/avm/gcc_starter_kit/landingzone/configuration/1-landingzones
    mkdir /tf/avm/gcc_starter_kit/landingzone/configuration/2-solution_accelerators
    mkdir /tf/avm/gcc_starter_kit/landingzone/configuration/2-solution_accelerators/project
    cp -R /tf/avm/templates/landingzone/configuration/1-landingzones/networking_template /tf/avm/gcc_starter_kit/landingzone/configuration/1-landingzones
    cp -R /tf/avm/templates/landingzone/configuration/2-solution_accelerators/project/solution_accelerators_template /tf/avm/gcc_starter_kit/landingzone/configuration/2-solution_accelerators/project
    rm -rf /tf/avm/tmp
fi
