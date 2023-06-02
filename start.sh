#!/bin/bash
docker network create consulnet
docker run -d --name=dev-consul -p 8500:8500 -p 8600:8600 --net=consulnet -e CONSUL_BIND_INTERFACE=eth0 consul
docker run -d --net=consulnet --name=nginx nginx
docker run -d --name=haproxy --net=consulnet -p 80:80 -p 1936:1936 -v $PWD/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg haproxy