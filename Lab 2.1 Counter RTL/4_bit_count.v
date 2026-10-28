module Down_Counter(
	input wire [3:0] IN,
	input wire latch,
	input wire dec,
	input wire CLK,
	output wire zero,
	output reg [3:0] counter
	);

	always @(posedge CLK)
		begin
		if(latch)
			begin
			counter <= IN;
			end
		else if(dec && !zero)
			begin
			counter <= counter - 4'b0001;
			end
		else
			begin
			counter <= counter;
			end
		end	
	
	assign zero = (counter == 4'b0000);

endmodule