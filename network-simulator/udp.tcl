# Create a simular object
set ns [new Simulator]

# Open the nam trace file
set nf [open out.nam w]
$ns namtrace-all $nf

# Define a "finish" procedure
proc finish {} {
    global ns nf
    $ns flush-trace
    # Close the trace file
    close $nf
    # Execute nam on the trace file
    exec nam out.nam &
    exit 0
}

# Create four nodes
set n0 [$ns node]
set n1 [$ns node]

# Create links between the nodes
$ns duplex-link $n0 $n1 10Mb 10ms DropTail

# Create a UDP agent and attach it to node n0
set udp [new Agent/UDP]
$ns attach-agent $n0 $udp

# Create a CBR traffic source and attach it to udp
set cbr [new Application/Traffic/CBR]
$cbr attach-agent $udp
$cbr set type_ CBR
$cbr set packetSize_ 1000
$cbr set rate_ 1mb
$cbr set random_ false

# Create a null agent (a traffic sink) and attach it to node n3
set null [new Agent/Null]
$ns attach-agent $n1 $null

# Connect the traffic sources with the traffic sink
$ns connect $udp $null

# Schedule events for CBR agents
$ns at 0.5 "$cbr start"
$ns at 4.5 "$cbr stop"

# Call the finish procedure after 5 seconds of simulation time
$ns at 5.0 "finish"

# Run the simulation
$ns run