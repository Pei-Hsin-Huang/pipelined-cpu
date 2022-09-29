module FromIDTOEX( clk, rst, 
				   RegDst_in, ALUSrc_in, MemtoReg_in, RegWrite_in, MemRead_in, MemWrite_in, Branch_in, Jump_in, 
				   ALUOp_in, rt_in, rd_in, opcode_in, rs_in,
				   pc_in, RD1_in, RD2_in, extend_immed_in, jump_addr_in, b_in, 
				   RegDst_out, ALUSrc_out, MemtoReg_out, RegWrite_out, MemRead_out, MemWrite_out, Branch_out, Jump_out, 
				   ALUOp_out,rt_out, rd_out,opcode_out, pc_out, RD1_out, RD2_out, extend_immed_out, jump_addr_out,
				   Funct_in, Funct_out, rs_out, b_out);
				   
	input clk, rst;
	input RegDst_in, ALUSrc_in, MemtoReg_in, RegWrite_in, MemRead_in, MemWrite_in, Branch_in, Jump_in ;
	input [1:0] ALUOp_in;
	input [4:0] rt_in, rd_in, rs_in ;	
	input [5:0] opcode_in, Funct_in;	
	input [31:0] pc_in, RD1_in, RD2_in, extend_immed_in, jump_addr_in, b_in;

	output RegDst_out, ALUSrc_out, MemtoReg_out, RegWrite_out, MemRead_out, MemWrite_out, Branch_out, Jump_out ;	
	output [1:0] ALUOp_out ;
	output [4:0] rt_out, rd_out, rs_out ;
	output [5:0] opcode_out,Funct_out;		
	output [31:0] pc_out, RD1_out, RD2_out, extend_immed_out, jump_addr_out, b_out;


	reg RegDst_out, ALUSrc_out, MemtoReg_out, RegWrite_out, MemRead_out, MemWrite_out, Branch_out, Jump_out ;	
	reg [1:0] ALUOp_out ;	
	reg [4:0] rt_out, rd_out, rs_out ;
	reg [5:0] opcode_out, Funct_out;
	reg [31:0] pc_out, RD1_out, RD2_out, extend_immed_out, jump_addr_out, b_out;
	
	
	always @( posedge clk ) begin
	#10;
		if (rst) begin
			RegDst_out <= 1'b0;
			ALUSrc_out <= 1'b0;
			MemtoReg_out <= 1'b0;
			RegWrite_out <= 1'b0;
			MemRead_out <= 1'b0;
			MemWrite_out <= 1'b0;
			Branch_out <= 1'b0;
			Jump_out <= 1'b0;
			
			ALUOp_out <= 2'b0;
			rt_out <= 4'b0;
			rd_out <= 4'b0;
			rs_out <= 4'b0;
			opcode_out <= 6'b0;	
            Funct_out <= 6'b0;				
			pc_out <= 32'b0;			
			RD1_out <= 32'b0;
			RD2_out <= 32'b0;
			extend_immed_out <= 32'b0;
			jump_addr_out <= 32'b0;
			b_out <= 32'b0;
		end
		else if (Funct_in == 6'd25) begin
		    RegDst_out <= RegDst_in ;
			ALUSrc_out <= ALUSrc_in ;
			MemtoReg_out <= MemtoReg_in ;
			RegWrite_out <=  1'b0 ;
			MemRead_out <=  MemRead_in ;
			MemWrite_out <= MemWrite_in ;
			Branch_out <= Branch_in ;
			Jump_out <= Jump_in ;
			
			ALUOp_out <= ALUOp_in ;		
			rt_out <= rt_in ;
			rd_out <= rd_in ;
			rs_out <= rs_in ;
			opcode_out <= opcode_in ;	
            Funct_out <= Funct_in ;			
			pc_out <= pc_in ;
			RD1_out <= RD1_in ;
			RD2_out <= RD2_in ;
			extend_immed_out <= extend_immed_in ;
			jump_addr_out <= jump_addr_in;
			b_out <= b_in;
		end
		
		else begin
			RegDst_out <= RegDst_in ;
			ALUSrc_out <= ALUSrc_in ;
			MemtoReg_out <= MemtoReg_in ;
			RegWrite_out <=  RegWrite_in ;
			MemRead_out <=  MemRead_in ;
			MemWrite_out <= MemWrite_in ;
			Branch_out <= Branch_in ;
			Jump_out <= Jump_in ;
			
			ALUOp_out <= ALUOp_in ;		
			rt_out <= rt_in ;
			rd_out <= rd_in ;
			rs_out <= rs_in ;
			opcode_out <= opcode_in ;	
            Funct_out <= Funct_in ;			
			pc_out <= pc_in ;
			RD1_out <= RD1_in ;
			RD2_out <= RD2_in ;
			extend_immed_out <= extend_immed_in ;
			jump_addr_out <= jump_addr_in;
			b_out <= b_in;
		end
	end
		
endmodule