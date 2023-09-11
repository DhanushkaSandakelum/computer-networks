# Assignment 4 - Mininet

# Name - L.A.D.D.S. Gunawardhana
# Index - 19000553
# Reg.No - 2019/CS/055

from mininet.topo import Topo
from mininet.net import Mininet
from mininet.util import dumpNodeConnections
from mininet.log import setLogLevel
from mininet.cli import CLI

class MyTopo( Topo ):
    "Custom Network Topology - 19000553"

    def build( self ):
        "Create custom topology"

        # Add hosts and switches
        h1 = self.addHost( 'h1' )
        h2 = self.addHost( 'h2' )
        h3 = self.addHost( 'h3' )
        h4 = self.addHost( 'h4' )
        h5 = self.addHost( 'h5' )

        # Add links - PORT level
        # Allow communication between h1, h2, h3 in port level
        self.addLink( h1, h2 )
        self.addLink( h2, h3 )
        self.addLink( h3, h1 )
        # Allow communication between h4, h5 in port level
        self.addLink( h4, h5 )

def runExeperiment():
    "Create and test a simple exeperiment on the custom topology created above"
    topo = MyTopo()
    net = Mininet(topo)
    net.start()
    print("Dump host connections")
    dumpNodeConnections(net.hosts)
    print("Testing network connectivity for all nodes")
    # net.pingAll()
    print("Run simple HTTP server on h1")
    h1, h2 = net.get('h1', 'h2')
    h1.cmdPrint("python3 -m http.server")
    h1.cmd("sleep 3")
    print("Request from node h2 to server h1")
    h2.cmdPrint("wget -o - 10.0.0.1")
    net.stop()

if __name__ == '__main__':
    setLogLevel('info')
    runExeperiment()