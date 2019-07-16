
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

cat >> /usr/local/lib/rancher_module <<EOF
br_netfilter
ip6_udp_tunnel
ip_set
ip_set_hash_ip
ip_set_hash_net
iptable_filter
iptable_nat
iptable_mangle
iptable_raw
nf_conntrack_netlink
nf_conntrack
nf_conntrack_ipv4
nf_defrag_ipv4
nf_nat
nf_nat_ipv4
nf_nat_masquerade_ipv4
nfnetlink
udp_tunnel
VETH
VXLAN
x_tables
xt_addrtype
xt_conntrack
xt_comment
xt_mark
xt_multiport
xt_nat
xt_recent
xt_set
xt_statistic
xt_tcpudp
EOF

cat > /etc/sysconfig/modules/rancher.modules << EOF
#!/bin/bash
for i in \`cat /usr/local/lib/rancher_module\`;do /usr/sbin/modprobe \$i > /dev/null 2>&1;
done
EOF

chmod 755 /etc/sysconfig/modules/rancher.modules
sh /etc/sysconfig/modules/rancher.modules

sudo mkdir -p /data/lib/docker

cat >  /etc/docker/daemon.json << EOF
{
 "registry-mirrors": ["https://h10nguty.mirror.aliyuncs.com"],
 "data-root" : "/data/lib/docker"
}
EOF

sudo adduser rancher
sudo usermod -aG docker rancher
sudo echo 'rancher ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

sudo systemctl enable docker
sudo systemctl daemon-reload
sudo systemctl restart docker
