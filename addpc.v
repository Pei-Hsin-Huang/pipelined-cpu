module addpc(a, b, result, clk);
  input clk;
  input [31:0] a, b;
  output [31:0] result;
  reg [31:0] result;
  
  always @( a ) begin
    result = a + b;
  end

endmodule
