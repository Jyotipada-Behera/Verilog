module UpDownCounter (
	input wire  [4:0] IN,
	input wire 	  Load, Up, Down, CLK,
	output wire 	  High, Low,
	output reg  [4:0] Counter
	);
	
always @(posedge CLK)
	begin
	if(Load)
		Counter <= IN;
	else if(Down)
		begin
		if (!Low)
			Counter <= Counter - 5'b00001;
		end
	else if(Up && !High)
		Counter <= Counter + 5'b00001;
	else
		Counter <= Counter;
	end

assign Low = (Counter == 5'b0);
assign High = (Counter == 5'b11111); 

endmodule