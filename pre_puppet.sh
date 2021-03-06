#!/bin/bash
PUPPET_MODULE_PATH="/etc/puppetlabs/code/modules"
if [ $UID -ne 0 ];
then
    echo "run the script as root";
    exit 1;
fi;
yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm https://yum.puppetlabs.com/puppet5/puppet5-release-el-7.noarch.rpm
yum install -y puppet-agent puppetlabs-stdlib
echo "#!/bin/bash" > /etc/profile.d/puppet.sh
echo "PATH=\"\${PATH}:/opt/puppetlabs/puppet/bin\"" >> /etc/profile.d/puppet.sh
echo "#!/bin/csh" > /etc/profile.d/puppet.csh
echo "PATH=\"\${PATH}:/opt/puppetlabs/puppet/bin\"" >> /etc/profile.d/puppet.csh

puppet apply --modulepath=/usr/share/puppet/modules/:$(pwd) -e "include lanserver"

if [ $? -eq 0 ]
then
    echo "Now you can use this command to update your client without running the script:"
    echo "puppet apply --modulepath=/usr/share/puppet/modules/:$(pwd) -e \"include lanserver\""
fi
