module ALU_16B (
		input  wire [15:0] A, 
		input  wire [15:0] B,
		input  wire [3:0]  ALU_FUN,
		input  wire        CLK,
		output reg  [15:0] ALU_OUT,
		output reg         Arith_Flag,
		output reg         Carry_Flag,   
		output reg         Logic_Flag, 
		output reg         CMP_Flag, 
		output reg         Shift_Flag 
);

		//internal combinational signals
		reg [15:0] ALU_OUT_Comb;
		reg        Arith_Flag_Comb;
		reg        Carry_Flag_Comb;
		reg        Logic_Flag_Comb;
		reg        CMP_Flag_Comb;
		reg        Shift_Flag_Comb;

		always @(posedge CLK) begin
			ALU_OUT    <= ALU_OUT_Comb;
			Arith_Flag <= Arith_Flag_Comb;
			Carry_Flag <= Carry_Flag_Comb;
			Logic_Flag <= Logic_Flag_Comb;
			CMP_Flag   <= CMP_Flag_Comb;
			Shift_Flag <= Shift_Flag_Comb;
		end  

		always @(*) begin
			ALU_OUT_Comb    = 16'b0;
			Arith_Flag_Comb = 1'b0;
			Logic_Flag_Comb = 1'b0; 
			CMP_Flag_Comb   = 1'b0;
			Shift_Flag_Comb = 1'b0;
			Carry_Flag_Comb = 1'b0;
			
			case (ALU_FUN) 
				4'b0000: 
				begin
					{Carry_Flag_Comb, ALU_OUT_Comb} = A + B;
					Arith_Flag_Comb = 1'b1;
				end
				4'b0001: 
				begin
					{Carry_Flag_Comb, ALU_OUT_Comb} = A - B;
					Arith_Flag_Comb = 1'b1;
				end
				4'b0010: 
				begin
					ALU_OUT_Comb    = A * B;
					Arith_Flag_Comb = 1'b1;
				end
				4'b0011: 
				begin
					ALU_OUT_Comb    = A / B;
					Arith_Flag_Comb = 1'b1;
				end
				4'b0100: 
				begin
					ALU_OUT_Comb    = A & B;
					Logic_Flag_Comb = 1'b1;
				end
				4'b0101: 
				begin
					ALU_OUT_Comb    = A | B;
					Logic_Flag_Comb = 1'b1;
				end
				4'b0110: 
				begin
					ALU_OUT_Comb    = ~(A & B);
					Logic_Flag_Comb = 1'b1;
				end
				4'b0111: 
				begin
					ALU_OUT_Comb    = ~(A | B);
					Logic_Flag_Comb = 1'b1;
				end     
				4'b1000: 
				begin
					ALU_OUT_Comb    = A ^ B;
					Logic_Flag_Comb = 1'b1;
				end
				4'b1001: 
				begin
					ALU_OUT_Comb    = ~(A ^ B);
					Logic_Flag_Comb = 1'b1;
				end           
				4'b1010: 
				begin
					ALU_OUT_Comb  = (A == B) ? 16'd1 : 16'd0;
					CMP_Flag_Comb = 1'b1;
				end
				4'b1011: 
				begin
					ALU_OUT_Comb  = (A > B) ? 16'd2 : 16'd0;
					CMP_Flag_Comb = 1'b1;
				end
				4'b1100: 
				begin
					ALU_OUT_Comb  = (A < B) ? 16'd3 : 16'd0;
					CMP_Flag_Comb = 1'b1;
				end
				4'b1101: 
				begin
					ALU_OUT_Comb    = A >> 1;
					Shift_Flag_Comb = 1'b1;
				end
				4'b1110: 
				begin 
					ALU_OUT_Comb    = A << 1;
					Shift_Flag_Comb = 1'b1;
				end
				default: 
				begin
					ALU_OUT_Comb = 16'b0;
				end
			endcase
		end
endmodule