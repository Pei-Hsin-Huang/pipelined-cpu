module Multiplier( clk, dataA, dataB, Signal, dataOut, reset, OUT, IN );
input clk, reset ;
input [31:0] dataA ;
input [31:0] dataB ;
input [5:0] Signal ;
output [63:0] dataOut ;
output OUT, IN;

reg [6:0] counter ;
reg [63:0] prod, dataOut ;
reg OUT, IN;

always@( posedge clk )
begin
    if ( Signal == 6'b011001 ) begin
			if ( counter == 1 )
			begin
				prod[31:0]= dataB;
				prod[63:32] = 32'b0;
			end
			
			if ( prod[0] == 1'b0 )
			begin
			    prod = prod >> 1'b1;
			end
            
			else
			begin
			    prod[63:32] = prod[63:32] + dataA;
				prod = prod >> 1'b1;
			end
			
		counter = counter + 1 ;
		OUT = 1'b0;
		IN = 1;
	end
		
		else begin
		    counter = 0;
			OUT = 1'b0;
			IN = 1'b0;
		end
		
		if ( counter == 33 ) begin
		    dataOut = prod;
	        counter = 0;
			OUT = 1'b1;
			$display( "%d, Hi <= %d (Write)", $time/10, prod[63:32] );
			$display( "%d, Lo <= %d (Write)", $time/10, prod[31:0] );
		end
    

end


endmodule