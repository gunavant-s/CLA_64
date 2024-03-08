`timescale 1ns / 1ps


module tb_CLA();

  // Inputs
  reg [63:0] a, b;
  reg cin;

  // Outputs
  wire [63:0] sum;
  wire cout;

  // Instantiate the nbitksa module
  cla_64bit dut (
    .a(a),
    .b(b),
    .cin(cin),
    .sum(sum),
    .cout(cout)
  );
    
  // Stimulus
  integer i=0;
  initial begin
  for(i = 0;i<5;i=i+1) begin
    a = $random;
    b = $random;
    cin = $random;
    #10;
    end
    // Add more test cases as needed...
    // End simulation
    $finish;
  end

endmodule

