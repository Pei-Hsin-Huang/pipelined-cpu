module HiLo( clk, MulAns, HiOut, LoOut, reset );
input clk ;
input reset ;
input [63:0] MulAns;
output [31:0] HiOut ;
output [31:0] LoOut ;

reg [63:0] HiLo ;

always@( posedge clk or reset )
begin
  if ( reset )
  begin
  
    HiLo = 64'b0 ;
	
  end
/*
reset�T�� �p�G�Oreset�N���k0
*/
  else
  begin
  
    HiLo = MulAns ;
	
  end
/*
��ǤJ�����k���צs�_��
*/
end

assign HiOut = HiLo[63:32] ;
assign LoOut = HiLo[31:0] ;

endmodule