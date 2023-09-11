# Assignment 4 - Mininet

# Name - L.A.D.D.S. Gunawardhana
# Index - 19000553
# Reg.No - 2019/CS/055

from mininet.topo import Topo

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


topos = { 'mytopo': ( lambda: MyTopo() ) }