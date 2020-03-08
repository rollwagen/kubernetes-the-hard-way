
IP_CONTROLLER_0=$(vagrant ssh controller-0 -- ifconfig eth0 | awk '$1 == "inet" {print $2}')
IP_CONTROLLER_1=$(vagrant ssh controller-1 -- ifconfig eth0 | awk '$1 == "inet" {print $2}')
IP_CONTROLLER_2=$(vagrant ssh controller-2 -- ifconfig eth0 | awk '$1 == "inet" {print $2}')


cat > haproxy.cfg <<EOF
frontend k8s-api
    bind 0.0.0.0:6443
    mode tcp
    option tcplog
    timeout client 300000
    default_backend k8s-api

backend k8s-api
    mode tcp
    option tcp-check
    balance roundrobin
    default-server inter 10s downinter 5s rise 2 fall 2 slowstart 60s maxconn 250 maxqueue 256 weight 100

        server apiserver1 ${IP_CONTROLLER_0}:6443 check
        server apiserver2 ${IP_CONTROLLER_1}:6443 check
        server apiserver3 ${IP_CONTROLLER_2}:6443 check
EOF

echo "Running HAPROXY..."
haproxy -f haproxy.cfg





