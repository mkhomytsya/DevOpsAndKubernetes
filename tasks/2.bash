mkdir demo
cd demo
mkdir rootfs
docker run busybox
docker ps -a
sudo docker export d65901a0448b | tar xf - -C rootfs

runc spec
vim config.json

"args": [
  "sh",
  "-c",
  "while true; do { echo -e 'HTTP/1.1 200 OK\\n\\n Version 1.0.0'; } | nc -vlp 8080; done"
]

{
  "type": "network",
  "path": "/var/run/netns/runc"
}

sudo ip netns add runc
ls -l /var/run/netns
sudo bash
brctl addbr runc0
ip link set runc0 up

ip addr add 192.168.0.1/24 dev runc0
ip link add name veth-host type veth peer name veth-guest
ip link set veth-host up
brctl addif runc0 veth-host

ip link set veth-guest netns runc
ip netns exec runc ip link set veth-guest name eth1
ip netns exec runc ip addr add 192.168.0.2/24 dev eth1
ip netns exec runc ip link set eth1 up
ip netns exec runc ip link set lo up
ip netns exec runc ip route add default via 192.168.0.1
exit

sudo runc run demo &

curl http://192.168.0.2:8080

ps aux | grep "runc run demo"

kill

asciinema upload