module Up_Dn_Counter_tb ();

  reg  [4:0] IN_tb;
  reg        Load_tb, Up_tb, Down_tb, clk_tb;
  wire [4:0] Counter_tb;
  wire       High_tb, Low_tb;
  reg  [8:1] failed;
  integer    i;

  initial begin
    $dumpfile("Up_Dn_Counter.vcd");
    $dumpvars;

    failed  = 8'b0;
    IN_tb   = 5'b01010;
    Load_tb = 1'b0;
    Up_tb   = 1'b0;
    Down_tb = 1'b0;
    clk_tb  = 1'b0;

    // Test Case 1: Load initial value from IN
    #3  Load_tb = 1'b1; Up_tb = 1'b0; Down_tb = 1'b0;
    #7  if (Counter_tb != 5'b01010) failed[1] = 1'b1;

    // Test Case 2: Verify Load has highest priority over Up and Down
    #3  Load_tb = 1'b1; Up_tb = 1'b1; Down_tb = 1'b1;
    #7  if (Counter_tb != 5'b01010) failed[2] = 1'b1;

    // Test Case 3: Decrement counter when Down is high
    #3  Load_tb = 1'b0; Up_tb = 1'b0; Down_tb = 1'b1;
    #27 if (Counter_tb != 5'b00111) failed[3] = 1'b1;

    // Test Case 4: Verify Down has higher priority than Up
    #3  Load_tb = 1'b0; Up_tb = 1'b1; Down_tb = 1'b1;
    #37 if (Counter_tb != 5'b00011) failed[4] = 1'b1;

    // Test Case 5: Hold count value when all control signals are low
    #3  Load_tb = 1'b0; Up_tb = 1'b0; Down_tb = 1'b0;
    #37 if (Counter_tb != 5'b00011) failed[5] = 1'b1;

    // Test Case 6: Decrement stops at 0 and asserts Low flag
    #3  Load_tb = 1'b0; Up_tb = 1'b0; Down_tb = 1'b1;
    #27 if (Low_tb != 1'b1) failed[6] = 1'b1;

    // Test Case 7: Increment counter when Up is high
    #3  Load_tb = 1'b0; Up_tb = 1'b1; Down_tb = 1'b0;
    #97 if (Counter_tb != 5'b01010) failed[7] = 1'b1;

    // Test Case 8: Increment stops at 31 and asserts High flag
    #3  Load_tb = 1'b0; Up_tb = 1'b1; Down_tb = 1'b0;
    #207 if (Counter_tb != 5'b11111 || High_tb != 1'b1) failed[8] = 1'b1;

    if (failed == 8'b0) begin
      $display("ALL TEST CASES PASSED");
    end else begin
      $write("TEST CASES FAILED:");
      for (i = 1; i <= 8; i = i + 1) begin
        if (failed[i]) $write(" %0d", i);
      end
      $display("");
    end

    #100 $finish;
  end

  always #5 clk_tb = !clk_tb;

  UpDownCounter DUT (
    .IN(IN_tb),
    .Load(Load_tb),
    .Up(Up_tb),
    .Down(Down_tb),
    .CLK(clk_tb),
    .Counter(Counter_tb),
    .High(High_tb),
    .Low(Low_tb)
  );

endmodule