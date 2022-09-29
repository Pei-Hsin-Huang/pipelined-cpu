module FromMEMTOWB( clk, rst, 
					mux_in, opcode_in, pc_in, rd_in, alu_out_IN, RegWrite_in, MemtoReg_in, Jump_in, Hi, Lo, HiLo_in, 
					mux_out, opcode_out, pc_out,  rd_out, alu_out_OUT, RegWrite_out, MemtoReg_out, Jump_out );
					
					
					

	input clk, rst, Hi, Lo;
	input [4:0] mux_in;
	input [5:0] opcode_in;
	input [31:0] pc_in, rd_in, alu_out_IN, HiLo_in;
	input RegWrite_in, MemtoReg_in, Jump_in;
	
	output [4:0] mux_out;
	output [5:0] opcode_out;
	output [31:0] pc_out, rd_out, alu_out_OUT;
	output RegWrite_out, MemtoReg_out, Jump_out;
	
	reg [4:0] mux_out;
	reg [5:0] opcode_out;
	reg [31:0] pc_out, rd_out, alu_out_OUT;
	reg RegWrite_out, MemtoReg_out, Jump_out;
	
	always @(posedge clk) begin
	#10;
		if (rst) begin
			mux_out<= 5'b0;	
			opcode_out <= 6'b0;	
			pc_out <= 32'b0;
			rd_out <= 32'b0;
			alu_out_OUT <= 32'b0;	
			
			RegWrite_out <= 1'b0;
			MemtoReg_out <= 1'b0;
			Jump_out <= 1'b0;
		end
		
		else if ( opcode_in == 6'd3 ) begin
		    mux_out <= 5'd31;
			opcode_out <= opcode_in;			
			pc_out <= pc_in;
			rd_out <= rd_in;
			alu_out_OUT <= pc_in + 32'd4;
			
			RegWrite_out <= RegWrite_in;
			MemtoReg_out <= 1'b0;
			Jump_out <= Jump_in;
		end
		
		else if ( Hi == 1'b1 ) begin
		    mux_out <= mux_in;
			opcode_out <= opcode_in;			
			pc_out <= pc_in;
			rd_out <= rd_in;
			alu_out_OUT <= HiLo_in;
			
			RegWrite_out <= RegWrite_in;
			MemtoReg_out <= MemtoReg_in;
			Jump_out <= Jump_in;
		end
		
		else if ( Lo == 1'b1 ) begin
		    mux_out <= mux_in;
			opcode_out <= opcode_in;			
			pc_out <= pc_in;
			rd_out <= rd_in;
			alu_out_OUT <= HiLo_in;
			
			RegWrite_out <= RegWrite_in;
			MemtoReg_out <= MemtoReg_in;
			Jump_out <= Jump_in;
		end
		
		else begin
			mux_out <= mux_in;
			opcode_out <= opcode_in;			
			pc_out <= pc_in;
			rd_out <= rd_in;
			alu_out_OUT <= alu_out_IN;
			
			RegWrite_out <= RegWrite_in;
			MemtoReg_out <= MemtoReg_in;
			Jump_out <= Jump_in;
		end
	end
	
endmodule