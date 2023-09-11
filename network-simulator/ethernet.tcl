# Create a simular object
set ns [new Simulator]

# Open the nam trace file
set nf [open ethernet.nam w]
$ns namtrace-all $nf

# Define a "finish" procedure
proc finish {} {
    global ns nf
    $ns flush-trace
    # Close the trace file
    close $nf
    # Execute nam on the trace file
    exec nam ethernet.nam &
    exit 0
}

# Create 5 nodes
set n0 [$ns node]
$n0 color "magenta"
$n0 label "src-1"
set n1 [$ns node]
$n1 color "blue"
$n1 label "src-2"
set n2 [$ns node]
set n3 [$ns node]
$n3 color "magenta"
$n3 label "dest-1"
set n4 [$ns node]
$n4 color "blue"
$n4 label "dest-2"

# Create Ethernet/LAN between the nodes
$ns duplex-link $n0 $n3 1Mb 1ms DropTail
$ns duplex-link $n1 $n4 1Mb 1ms DropTail
set lan [$ns newLan "$n0 $n1 $n2 $n3 $n4" 100Mb 100ms LL Queue/DropTail MAC/802_3 Channel]

# For n0 - n3
# Create a TCP agent and attach it to node n0
set tcp0 [new Agent/TCP]
$tcp0 set class_ 2
$ns attach-agent $n0 $tcp0

# Create a FTP traffic source and attach it to tcp
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
$ftp0 set type_ FTP
$ftp0 set packetSize_ 1000
$ftp0 set rate_ 1mb

# Create a tcp sink agent (a traffic sink) and attach it to node n3
set sink0 [new Agent/TCPSink]
$ns attach-agent $n3 $sink0
$ns connect $tcp0 $sink0

# Connect the traffic sources with the traffic sink
$ns connect $tcp0 $sink0

# For n1 - n4
# Create a TCP agent and attach it to node n0
set tcp1 [new Agent/TCP]
$tcp1 set class_ 2
$ns attach-agent $n1 $tcp1

# Create a FTP traffic source and attach it to tcp
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1
$ftp1 set type_ FTP
$ftp1 set packetSize_ 1000
$ftp1 set rate_ 1mb

# Create a tcp sink agent (a traffic sink) and attach it to node n3
set sink1 [new Agent/TCPSink]
$ns attach-agent $n4 $sink1
$ns connect $tcp1 $sink1

# Connect the traffic sources with the traffic sink
$ns connect $tcp1 $sink1


# Schedule events for CBR agents
$ns at 0.5 "$ftp0 start"
$ns at 2.0 "$ftp1 start"
$ns at 3.0 "$ftp0 stop"
$ns at 4.0 "$ftp1 stop"

# Call the finish procedure after 5 seconds of simulation time
$ns at 5.0 "finish"

# Run the simulation
$ns run