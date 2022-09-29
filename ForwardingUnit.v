module ForwardingUnit( MEM_rd, WB_rd, EX_rs, EX_rt, ForwardA, ForwardB, clk );
input [4:0] MEM_rd, WB_rd, EX_rs, EX_rt;
input clk;
output [1:0] ForwardA, ForwardB;
reg [1:0] ForwardA, ForwardB;

always @( EX_rs or EX_rt ) begin
  if ( MEM_rd == EX_rs )
  begin
    ForwardA = 2'b10;
	ForwardB = 2'b00;
  end
  
  else if ( MEM_rd == EX_rt )
  begin
    ForwardA = 2'b00;
    ForwardB = 2'b10;
  end
  
  else if ( WB_rd == EX_rs )
  begin
    ForwardA = 2'b01;
    ForwardB = 2'b00;
  end
  
  else if ( WB_rd == EX_rt )
  begin
    ForwardA = 2'b00;
    ForwardB = 2'b01;
  end

  else
  begin
    ForwardA = 2'b00;
    ForwardB = 2'b00;
  end

end


endmodule