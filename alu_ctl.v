/*
	Title:	ALU Control Unit
	Input Port
		1. ALUOp: 控制alu是要用+還是-或是其他指令
		2. Funct: 如果是其他指令則用這邊6碼判斷
	Output Port
		1. ALUOperation: 最後解碼完成之指令
*/

module alu_ctl(ALUOp, Funct, ALUOperation, Hi, Lo);
    input [1:0] ALUOp;
    input [5:0] Funct;
	output Hi, Lo;
    output [2:0] ALUOperation;
    reg    [2:0] ALUOperation;
	reg  Hi, Lo;

    // symbolic constants for instruction function code
    parameter F_add = 6'd32;
    parameter F_sub = 6'd34;
    parameter F_and = 6'd36;
    parameter F_or  = 6'd37;
    parameter F_slt = 6'd42;
	parameter F_mul = 6'd25;
	parameter F_sll = 6'd00;
	parameter F_mfhi= 6'b010000;
    parameter F_mflo= 6'b010010;

    // symbolic constants for ALU Operations
    parameter ALU_add = 3'b010;
    parameter ALU_sub = 3'b110;
    parameter ALU_and = 3'b000;
    parameter ALU_or  = 3'b001;
    parameter ALU_slt = 3'b111;
	parameter ALU_mul = 3'b011;
	parameter ALU_sll = 3'b100;

    always @(ALUOp or Funct)
    begin
	    Hi = 1'b0;
		Lo = 1'b0;
        case (ALUOp) 
            2'b00 : begin
			  ALUOperation = ALU_add;
			end
            2'b01 : begin
			  ALUOperation = ALU_sub;
			end
            2'b10 : case (Funct) 
                        F_add : begin
						  ALUOperation = ALU_add;
						end
                        F_sub : begin
						  ALUOperation = ALU_sub;
						end
                        F_and : begin
						  ALUOperation = ALU_and;
						end
                        F_or  : begin
						  ALUOperation = ALU_or;
						end
                        F_slt : begin
						  ALUOperation = ALU_slt;
						end
						F_sll : begin
						  ALUOperation = ALU_sll;
						end
						F_mul : begin 
						  ALUOperation = ALU_mul;
						end
						F_mfhi: begin
						  Hi = 1'b1;		
						end
						F_mflo: begin
						  Lo = 1'b1;		
						end
                        default begin
						  ALUOperation = 3'bxxx;
						end
                    endcase
            default begin
			  ALUOperation = 3'bxxx;
			end
        endcase
    end
endmodule

