module FromIFTOID( clk, rst, instr_in, inpc_in, pc_out, instr_out, branch );
	input clk, rst, branch;
	input [31:0] inpc_in, instr_in ;
	output [31:0] pc_out, instr_out ;
	// 要存在 register
	reg [31:0] pc_out, instr_out ;
	
	always @( posedge clk ) begin
	#10;
		 if (rst) 
			begin
				pc_out <= 32'b0;
				instr_out <= 32'b0;
			end
			
		else if ( branch == 1'b1 ) begin
		    pc_out <= 32'b0;
			instr_out <= 32'bx;
		end
		 else
			begin
				pc_out <= inpc_in ;
				instr_out <= instr_in ;

			end
	  end
		
endmodule