#secure-ssh.sh
#author laurathomas-roy
#creates a new ssh user using the $1 parameter
#adds a public key from the local repo or curled from the remote repo
#removes roots ability to ssh in

#error checking: username provided?
if [ $# -eq 0 ]; then
	echo "Usage: $0 <username>"
	exit 1
fi

#store user in variable
user=$1

#create passwordless user, necessary directories/permissions/ownership
sudo useradd -m -d /home/$user -s /bin/bash $user
sudo mkdir /home/$user/.ssh
sudo cp SYS-265/linux/public-keys/id_rsa.pub /home/$user/.ssh/authorized_keys
sudo chmod 700 /home/$user/.ssh
sudo chmod 600 /home/$user/.ssh/authorized_keys
sudo chown -R $user:$user /home/$user/.ssh

#disable root login
sudo sed -i 's/^PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config

#output
echo "New ssh user $user has been created!"
echo "Root login has been disabled!"
