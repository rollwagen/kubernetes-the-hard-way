for instance in worker-0 worker-1 worker-2; do

cat > ${instance}-csr.json <<EOF
{
  "CN": "system:node:${instance}",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "US",
      "L": "Portland",
      "O": "system:nodes",
      "OU": "Kubernetes The Hard Way",
      "ST": "Oregon"
    }
  ]
}
EOF

#EXTERNAL_IP=$(gcloud compute instances describe ${instance} \
#  --format 'value(networkInterfaces[0].accessConfigs[0].natIP)')
EXTERNAL_IP=$(vagrant ssh ${instance} -- ifconfig eth0 | awk '$1 == "inet" {print $2}')

#INTERNAL_IP=$(gcloud compute instances describe ${instance} \
#  --format 'value(networkInterfaces[0].networkIP)')
INTERNAL_IP=$(vagrant ssh ${instance} -- ifconfig eth1 | awk '$1 == "inet" {print $2}')

cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca-config.json \
  -hostname=${instance},${EXTERNAL_IP},${INTERNAL_IP} \
  -profile=kubernetes \
  ${instance}-csr.json | cfssljson -bare ${instance}

done

