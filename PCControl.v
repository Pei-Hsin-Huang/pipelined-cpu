module PCControl( op, src, pc, jsel, b_sub );
input [5:0] op;
input [31:0] pc;
input clk, b_sub;
output jsel;
output [1:0] src;
reg jsel;
reg [1:0] src;

always @ ( pc ) begin
  if ( op == 6'd4 ) begin
    src <= 2'b01;
	jsel <= 1'b0;
  end

  else if ( op == 6'd2 ) begin
    src <= 2'b0;
	jsel <= 1'b1;
  end
  
  else if ( op == 6'd3 ) begin
    src <= 2'b0;
	jsel <= 1'b1;
  end
  
  else if ( b_sub == 1'b1 ) begin
    src <= 2'b10;
	jsel <= 1'b0;
  end
  
  else begin
    src <= 2'b0;
	jsel <= 1'b0;
  end

end

endmodule