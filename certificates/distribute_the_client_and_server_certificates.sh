
for instance in worker-0 worker-1 worker-2; do
  IP=$(vagrant ssh ${instance} -- ifconfig eth1 | awk '$1 == "inet" {print $2}')
  scp ca.pem ${instance}-key.pem ${instance}.pem vagrant@${IP}:~/
done

for instance in controller-0 controller-1 controller-2; do
  IP=$(vagrant ssh ${instance} -- ifconfig eth1 | awk '$1 == "inet" {print $2}')
  scp ca.pem ca-key.pem kubernetes-key.pem kubernetes.pem \
    service-account-key.pem service-account.pem vagrant@${IP}:~/
done
