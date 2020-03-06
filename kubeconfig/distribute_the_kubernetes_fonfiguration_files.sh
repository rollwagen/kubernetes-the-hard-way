
for instance in worker-0 worker-1 worker-2; do
  IP=$(vagrant ssh ${instance} -- ifconfig eth1 | awk '$1 == "inet" {print $2}')
  scp ${instance}.kubeconfig kube-proxy.kubeconfig vagrant@${IP}:~/
done

for instance in controller-0 controller-1 controller-2; do
  IP=$(vagrant ssh ${instance} -- ifconfig eth1 | awk '$1 == "inet" {print $2}')
  scp admin.kubeconfig kube-controller-manager.kubeconfig kube-scheduler.kubeconfig vagrant@${IP}:~/
done
