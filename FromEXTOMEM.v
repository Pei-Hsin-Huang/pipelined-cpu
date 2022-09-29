module FromEXTOMEM(clk, rst, 
					zero_in, mux_in, opcode_in, inpc_in, pc_in,	alu_out_IN, rd2_in, jump_addr_in,	
					RegWrite_in, Branch_in, MemtoReg_in, MemRead_in, MemWrite_in, Jump_in, b_in, Hi_in, Lo_in, 
					zero_out, mux_out, opcode_out, outpc_out, pc_out, alu_out_OUT, rd2_out, jump_addr_out,	
			        RegWrite_out, Branch_out, MemtoReg_out, MemRead_out, MemWrite_out, Jump_out, b_out, Hi_out, Lo_out);


	input clk, rst;
	input zero_in, Hi_in, Lo_in;
	input [4:0] mux_in;
	input [5:0] opcode_in;
	input [31:0] inpc_in, pc_in, alu_out_IN, rd2_in, jump_addr_in, b_in;
	input RegWrite_in, Branch_in, MemtoReg_in, MemRead_in, MemWrite_in, Jump_in;
	
	output zero_out, Hi_out, Lo_out;
	output [4:0] mux_out;
	output [5:0] opcode_out;
	output [31:0] outpc_out, pc_out, alu_out_OUT, rd2_out, jump_addr_out, b_out;
	output RegWrite_out, Branch_out, MemtoReg_out, MemRead_out, MemWrite_out, Jump_out;
	
	reg zero_out, Hi_out, Lo_out;
	reg [4:0] mux_out;
	reg [5:0] opcode_out;
	reg [31:0] outpc_out, pc_out, alu_out_OUT, rd2_out, jump_addr_out, b_out;
	reg RegWrite_out, Branch_out, MemtoReg_out, MemRead_out, MemWrite_out, Jump_out;
	
	always @(posedge clk) begin
	#10;
		if (rst)
			begin
				zero_out <= 1'b0;	
				
				mux_out <= 5'b0;			
				opcode_out <= 6'b0;
				outpc_out <= 32'b0;
				pc_out <= 32'b0;
				alu_out_OUT <= 32'b0;
				rd2_out <= 32'b0;
				jump_addr_out <= 32'b0;	
				
				MemtoReg_out <= 1'b0;
				RegWrite_out <= 1'b0;
				MemRead_out <= 1'b0;
				MemWrite_out <= 1'b0;
				Branch_out <= 1'b0;
				Jump_out <= 1'b0;
				b_out <= 32'b0;
				Hi_out <= 1'b0;
				Lo_out <= 1'b0;
			end
		else
			begin
				zero_out <= zero_in;
				
				mux_out <= mux_in;	
				opcode_out <= opcode_in; 
				outpc_out <= inpc_in;
				pc_out <= pc_in;
				alu_out_OUT <= alu_out_IN;
				rd2_out <= rd2_in;
				jump_addr_out <= jump_addr_in;
				
				MemtoReg_out <= MemtoReg_in;
				RegWrite_out <= RegWrite_in;
				MemRead_out <= MemRead_in;			
				MemWrite_out <= MemWrite_in;
				Branch_out <= Branch_in;
				Jump_out <= Jump_in;
                b_out <= b_in;	
                Hi_out <= Hi_in;
				Lo_out <= Lo_in;				
			end
	end
	
endmodule