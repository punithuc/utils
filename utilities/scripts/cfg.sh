#!/bin/bash
exportfs -ra
/etc/init.d/nfs restart
iptables -F INPUT
iptables -F FORWARD
