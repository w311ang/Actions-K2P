#!/bin/sh

#设置dnsforwarder，添加wan端dns
if [[ "$(cat /etc/config/dnsforwarder)" =~ "%wan_dns%" ]]; then
  for i in [1..5]; do
    wan_dns="$(ifstatus wan | jsonfilter -e '@["dns-server"][0]' || echo '')"
    if [[ "$wan_dns" != "" ]]; then
      sed -i "s/%wan_dns%/${wan_dns},/" /etc/config/dnsforwarder
      break
    else
      if [[ $i == 5 ]]; then
        exit 1
      else
        sleep 1s
      fi
    fi
  done
fi
