`timescale 1ns/1ns
 
module ALU_16B_tb();

reg CLK_tb;
reg [3:0] ALU_FUN_tb;
reg [15:0] A_tb;
reg [15:0] B_tb;

wire [15:0] ALU_OUT_tb;
wire Arith_Flag_tb;
wire Carry_Flag_tb;
wire Logic_Flag_tb;
wire CMP_Flag_tb;
wire Shift_Flag_tb;

initial
	begin
	$dumpfile("ALU.vcd");
	$dumpvars;

	CLK_tb = 1'b0;

	$display("Test Case 1: Unsigned Arith (Addition)");
	A_tb = 16'd50;
	B_tb = 16'd50;
	ALU_FUN_tb = 4'b0;
	
	#10000	

	if(Arith_Flag_tb==1'b1 && Carry_Flag_tb==1'b0 && ALU_OUT_tb==16'd100)
		$display("passed");
	else
		$display("FAILED!!!");

	$display("Test Case 2: Unsigned Arith (Subtraction)");
	A_tb = 16'd50;
	B_tb = 16'd50;
	ALU_FUN_tb = 4'b1;
	
	#10000	

	if(Arith_Flag_tb==1'b1 && Carry_Flag_tb==1'b0 && ALU_OUT_tb==16'b0)
		$display("passed");
	else
		$display("FAILED!!!");

	$display("Test Case 3: Unsigned Arith (Multiplication)");
	A_tb = 16'd5;
	B_tb = 16'd5;
	ALU_FUN_tb = 4'b10;
	
	#10000	

	if(Arith_Flag_tb==1'b1 && ALU_OUT_tb==16'd25)
		$display("passed");
	else
		$display("FAILED!!!");

	$display("Test Case 4: Unsigned Arith (Division)");
	A_tb = 16'd5;
	B_tb = 16'd5;
	ALU_FUN_tb = 4'b11;
	
	#10000	

	if(Arith_Flag_tb==1'b1 && ALU_OUT_tb==16'b1)
		$display("passed");
	else
		$display("FAILED!!!");

	$display("Test Case 5: Logical (AND)");
	A_tb = 16'b1001;
	B_tb = 16'b1000;
	ALU_FUN_tb = 4'b100;
	
	#10000	

	if(Logic_Flag_tb==1'b1 && ALU_OUT_tb==16'b1000)
		$display("passed");
	else
		$display("FAILED!!!");

	$display("Test Case 6: Logical (OR)");
	A_tb = 16'b1001;
	B_tb = 16'b1000;
	ALU_FUN_tb = 4'b101;
	
	#10000	

	if(Logic_Flag_tb==1'b1 && ALU_OUT_tb==16'b1001)
		$display("passed");
	else
		$display("FAILED!!!");

	$display("Test Case 7: Logical (NAND)");
	A_tb = 16'hffff;
	B_tb = 16'hffff;
	ALU_FUN_tb = 4'b110;
	
	#10000	

	if(Logic_Flag_tb==1'b1 && ALU_OUT_tb==16'b0)
		$display("passed");
	else
		$display("FAILED!!!");

	$display("Test Case 8: Logical (NOR)");
	A_tb = 16'hffff;
	B_tb = 16'b0;
	ALU_FUN_tb = 4'b111;
	
	#10000	

	if(Logic_Flag_tb==1'b1 && ALU_OUT_tb==16'b0)
		$display("passed");
	else
		$display("FAILED!!!");	

	$display("Test Case 9: Compare (Equal)");
	A_tb = 16'b1001;
	B_tb = 16'b1000;
	ALU_FUN_tb = 4'b1010;
	
	#10000	

	if(CMP_Flag_tb==1'b1 && ALU_OUT_tb==16'b0)
		$display("passed");
	else
		$display("FAILED!!!");

	$display("Test Case 10: Compare (Greater)");
	A_tb = 16'b1001;
	B_tb = 16'b1000;
	ALU_FUN_tb = 4'b1011;
	
	#10000	

	if(CMP_Flag_tb==1'b1 && ALU_OUT_tb==16'd2)
		$display("passed");
	else
		$display("FAILED!!!");	

	$display("Test Case 11: Compare (Less)");
	A_tb = 16'b1001;
	B_tb = 16'b1000;
	ALU_FUN_tb = 4'b1100;
	
	#10000	

	if(CMP_Flag_tb==1'b1 && ALU_OUT_tb==16'b0)
		$display("passed");
	else
		$display("FAILED!!!");

	$display("Test Case 12: Shift right)");
	A_tb = 16'd10;
	//B_tb = 16'b1000;
	ALU_FUN_tb = 4'b1101;
	
	#10000	

	if(Shift_Flag_tb==1'b1 && ALU_OUT_tb==16'd5)
		$display("passed");
	else
		$display("FAILED!!!");

	$display("Test Case 13: shift left)");
	A_tb = 16'd5;
	//B_tb = 16'b1000;
	ALU_FUN_tb = 4'b1110;
	
	#10000	

	if(Shift_Flag_tb==1'b1 && ALU_OUT_tb==16'd10)
		$display("passed");
	else
		$display("FAILED!!!");

	$display("Test Case 14: NOP");
	A_tb = 16'd5;
	B_tb = 16'b1000;
	ALU_FUN_tb = 4'b1111;
	
	#10000	

	if(ALU_OUT_tb==16'b0)
		$display("passed");
	else
		$display("FAILED!!!");

	#100000 $finish;
end
//f = 100 kHz, T=1/100kHz = 10^-5 s = 10^4 ns
// up 5000 ns down 5000 ns
always #5000 CLK_tb = ~CLK_tb; // 10k clock time period

ALU_16B DUT (
	.A(A_tb),
	.B(B_tb),
	.ALU_FUN(ALU_FUN_tb),
	.CLK(CLK_tb),
	
	.ALU_OUT(ALU_OUT_tb),
	.Arith_Flag(Arith_Flag_tb),
	.Carry_Flag(Carry_Flag_tb),
	.Logic_Flag(Logic_Flag_tb),
	.CMP_Flag(CMP_Flag_tb),
	.Shift_Flag(Shift_Flag_tb)
);	

endmodule