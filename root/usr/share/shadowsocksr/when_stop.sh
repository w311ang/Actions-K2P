#会在reload,restart,stop时运行
ps -w | grep -v "grep" | grep '\[dnsforwarder-bp\]' | awk '{print $1}' | xargs kill -9
rm -rf /tmp/dnsforwarder-bplan
rm -rf /var/etc/dnsforwarder-bplan
ps -w | grep -v "grep" | grep 'tcp2udp 127.0.0.1:5333 :5333' | awk '{print $1}' | xargs kill -9
ipset destroy china6

#bropc
ps -w | grep -v "grep" | grep '\[dnsforwarder-br\]' | awk '{print $1}' | xargs kill -9
rm -rf /var/etc/dnsforwarder-bropc/
rm -rf /tmp/dnsforwarder-bropc

uci set shadowsocksr.@global[0].mydnsip="127.0.0.1"
uci set shadowsocksr.@global[0].mydnsport='5335'
uci delete dhcp.@dnsmasq[0].cachesize
uci commit

#specific domain block quic
rm -rf /var/dnsmasq.d/dnsmasq-ssrplus.d/010_quic_blocking.conf

ipset destroy chinalist
rm -rf /var/dnsmasq.d/dnsmasq-ssrplus.d/china.conf
