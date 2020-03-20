
for instance in controller-0 controller-1 controller-2 worker-0 worker-1 worker-2; do
	vagrant ssh ${instance} -- "sudo apt-get update; sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade;"
done
