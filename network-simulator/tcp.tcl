# Create a simular object
set ns [new Simulator]

# Open the nam trace file
set nf [open tcp.nam w]
$ns namtrace-all $nf

# Define a "finish" procedure
proc finish {} {
    global ns nf
    $ns flush-trace
    # Close the trace file
    close $nf
    # Execute nam on the trace file
    exec nam tcp.nam &
    exit 0
}

# Create 2 nodes
set n0 [$ns node]
set n1 [$ns node]

# Create links between the nodes
$ns duplex-link $n0 $n1 10Mb 10ms DropTail

# Create a TCP agent and attach it to node n0
set tcp [new Agent/TCP]
$tcp set class_ 2
$ns attach-agent $n0 $tcp

# Create a FTP traffic source and attach it to tcp
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ftp set type_ FTP
$ftp set packetSize_ 1000
$ftp set rate_ 1mb

# Create a tcp sink agent (a traffic sink) and attach it to node n3
set sink [new Agent/TCPSink]
$ns attach-agent $n1 $sink

# Connect the traffic sources with the traffic sink
$ns connect $tcp $sink

# Schedule events for CBR agents
$ns at 0.5 "$ftp start"
$ns at 4.5 "$ftp stop"

# Call the finish procedure after 5 seconds of simulation time
$ns at 5.0 "finish"

# Run the simulation
$ns run