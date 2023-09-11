Go to mininet custom topology directory
`$ cd mininet/custom`

To run mininet custom file via python
`$ sudo python3 mininet_assignment.py`

To run mininet custom file
`$ sudo mn --custom mininet_assignment.py --topo mytopo`

Try to ping all
`$ pingall`

Ping from h1 to h2
`$ h1 ping h2`

Ping 3 times from h1 to h2
`$ h1 ping -c 1 h2`

Run simple HTTP server on h1
`$ h1 python3 http.server`

Request to server from h2
`$ h2 wget -o - h1`