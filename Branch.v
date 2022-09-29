module Branch( b, z, sel, clk );
input b, z, clk;
output sel;
reg sel;
wire temp;
and AND(temp, b, z);

always @( posedge clk ) begin
  if ( temp == 1'b1 )
    sel = 1'b0;
	
  else if ( b == 1'b1 )
    sel = 1'b1;
	
  else
    sel = 1'b0;
end

endmodule