
KUBERNETES_PUBLIC_ADDRESS=$(ifconfig en0 | awk '$1 == "inet" {print $2}')

{
  kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=../certificates/ca.pem \
    --embed-certs=true \
    --server=https://${KUBERNETES_PUBLIC_ADDRESS}:6443 \
    --kubeconfig=kube-proxy.kubeconfig

  kubectl config set-credentials system:kube-proxy \
    --client-certificate=../certificates/kube-proxy.pem \
    --client-key=../certificates/kube-proxy-key.pem \
    --embed-certs=true \
    --kubeconfig=kube-proxy.kubeconfig

  kubectl config set-context default \
    --cluster=kubernetes-the-hard-way \
    --user=system:kube-proxy \
    --kubeconfig=kube-proxy.kubeconfig

  kubectl config use-context default --kubeconfig=kube-proxy.kubeconfig
}
