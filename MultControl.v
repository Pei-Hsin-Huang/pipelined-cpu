module MultControl( clk, a, b, result, Funct, Operation, reset );
input clk, reset;
input [31:0] a, b;
input [5:0] Funct;
input [2:0] Operation;
output [31:0] result;
wire [63:0] MulAns;
wire [31:0] HiOut, LoOut;
reg [6:0] counter ;
reg [31:0] result;
reg [31:0] dataA, dataB;
reg [2:0] Op;
reg [5:0] F;
wire OUT, IN;

Multiplier Multiplier( .clk(clk), .dataA(dataA), .dataB(dataB), .Signal(F), .dataOut(MulAns), .reset(reset), .OUT(OUT), .IN(IN) );
HiLo HiLo( .clk(clk), .MulAns(MulAns), .HiOut(HiOut), .LoOut(LoOut), .reset(reset) );

always@( posedge clk )
begin
  if ( Operation == 3'b011 )
  begin
    if ( IN == 0 ) begin
    counter = 0 ;
	F = Funct;
	Op = Operation;
	dataA <= a;
	dataB <= b;
	end
  end
  
  else if ( Funct == 6'b010000 )
  begin
    result = HiOut;
  end
  
  else if ( Funct == 6'b010010 )
  begin
    result = LoOut;
  end
  
end

always@( clk )
begin
  if ( OUT == 1 )
  begin
    F = 6'bx;
  end
  
end

endmodule