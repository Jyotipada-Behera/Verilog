//time units = 1ns, time precision = 1ps
`timescale 1ns/1ps

//tb has no io
module Down_Counter_tb();

//declare tb signals
reg 		clock_tb;
reg [3:0] 	in_tb;
reg 		latch_tb;
reg 		dec_tb;
wire		zero_tb;
wire [3:0]	counter_tb;

//initial block
initial
	begin
	$dumpfile ("count.vcd"); //waveforms in this file
	$dumpvars; //saves all waveforms
	clock_tb = 1'b0;
	in_tb = 4'b1010;
	latch_tb = 1'b0;
	dec_tb = 1'b0;
	$display ("TEST CASE 1"); //tests latch function
	#10
	latch_tb = 1'b1;
	#10
	if(counter_tb == 4'b1010)
		$display ("TEST CASE 1 PASSED with counter value = %0h at simulation time %0t", counter_tb, $time);
	else
		$display ("TEST CASE 1 FAILED with counter value = %0h at simulation time %0t", counter_tb, $time);
	$display ("TEST CASE 2"); //tests latch priority
	latch_tb = 1'b1;
	dec_tb = 1'b1;
	#10
	if(counter_tb == 4'b1010)
		$display ("TEST CASE 2 PASSED with counter value = %0h at simulation time %0t", counter_tb, $time);
	else
		$display ("TEST CASE 2 FAILED with counter value = %0h at simulation time %0t", counter_tb, $time);
	$display ("TEST CASE 3"); //tests decrement function
	latch_tb = 1'b0;
	#30
	if(counter_tb == 4'b1111)
		$display ("TEST CASE 3 PASSED with counter value = %0h at simulation time %0t", counter_tb, $time);
	else
		$display ("TEST CASE 3 FAILED with counter value = %0h at simulation time %0t", counter_tb, $time);
	$display ("TEST CASE 4"); //tests dec function also
	latch_tb = 1'b0;
	#80
	if (counter_tb == 4'b0 && zero_tb == 1'b1)
		$display ("TEST CASE 4 PASSED with counter value = %0h at simulation time %0t", counter_tb, $time);
	else
		$display ("TEST CASE 4 FAILED with counter value = %0h at simulation time %0t", counter_tb, $time);
	#100
	$stop; //finished with simulation
end

//clock generator
always #5 clock_tb = ~clock_tb;

//design instantiation
Down_Counter DUT (
	.CLK(clock_tb),
	.IN(in_tb),
	.latch(latch_tb),
	.dec(dec_tb),
	.counter(counter_tb),
	.zero(zero_tb)
);

endmodule