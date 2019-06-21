
sudo systemctl stop firewalld.service && systemctl disable firewalld.service
sudo iptables -P FORWARD ACCEPT

sudo cat >> /etc/sysctl.conf<<EOF
net.ipv4.ip_forward=1
net.bridge.bridge-nf-call-iptables=1
net.ipv4.neigh.default.gc_thresh1=4096
net.ipv4.neigh.default.gc_thresh2=6144
net.ipv4.neigh.default.gc_thresh3=8192
EOF

sudo sysctl -p

sudo mkdir -p /data/lib/docker

cat >  /etc/docker/daemon.json << EOF
{
 "registry-mirrors": ["https://h10nguty.mirror.aliyuncs.com"],
 "data-root" : "/data/lib/docker"
}
EOF

sudo adduser rancher
sudo passwd rancher
sudo usermod -aG docker rancher
sudo echo 'rancher ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

sudo systemctl enable docker
sudo systemctl daemon-reload
sudo systemctl restart docker
