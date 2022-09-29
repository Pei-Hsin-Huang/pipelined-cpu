//	Title: MIPS Pipeline CPU 
module pipeline_cpu( clk, rst );
	input clk, rst;
	
	// instruction bus
	wire[31:0] instr;
	wire HiSel, LoSel;
	wire [31:0] HiLoTemp;
	
	// break out important fields from instruction
	wire [5:0] opcode, funct;
    wire [4:0] rs, rt, rd, shamt;
    wire [15:0] immed;
    wire [31:0] extend_immed, b_offset, b_offset_temp, b_offset_sub;
    wire [25:0] jumpoffset;
	
	// datapath signals
    wire [4:0] rfile_wn;
    wire [31:0] rfile_rd1, rfile_rd2, rfile_wd, alu_b, alu_out, b_tgt, pc_next,
                pc, pc_incr, dmem_rdata, jump_addr, branch_addr, pc_try, pc_temp;
    reg [31:0] pc_add;
	// control signals
    wire RegWrite, Branch, RegDst, MemtoReg, MemRead, MemWrite, ALUSrc, Zero, Jump, BSrc, Jumpsel ; 
    wire [1:0] ALUOp, ForwardA, ForwardB, PCSrc;
    wire [2:0] Operation;
	wire [31:0] first_pc, first_instr;
	
    // for Stall
	wire [31:0] pc_stall, instr_stall;


	// for IDtoEX_STAGE_
	wire IDtoEX_STAGE_ALUSrc, IDtoEX_RegDst; 
	wire IDtoEX_STAGE_MemtoReg, IDtoEX_STAGE_RegWrite, IDtoEX_STAGE_MemRead, IDtoEX_STAGE_MemWrite;
	wire IDtoEX_STAGE_Branch, IDtoEX_STAGE_Jump ;	
	wire [1:0] IDtoEX_STAGE_ALUOp;	
	wire [4:0] IDtoEX_STAGE_rt, IDtoEX_STAGE_rd, IDtoEX_rs;	
	wire [5:0] IDtoEX_STAGE_opcode, IDtoEX_STAGE_Funct;	
	wire [31:0] IDtoEX_STAGE_pc, IDtoEX_STAGE_rd1, IDtoEX_STAGE_rd2, IDtoEX_STAGE_extend_immed, IDtoEX_STAGE_jump_addr;
    wire [31:0] OprandA, OprandB;
	
	
	// for EXtoMEM_STAGE
	wire EXtoMEM_zero, EXtoMEM_Hi, EXtoMEM_Lo;
	wire EXtoMEM_RegWrite, EXtoMEM_Branch, EXtoMEM_MemtoReg,
		 EXtoMEM_MemRead, EXtoMEM_MemWrite, EXtoMEM_Jump;  
	wire [4:0] EXtoMEM_mux;		 
	wire [5:0] EXtoMEM_opcode, EXtoMEM_Funct;
	wire [31:0] EXtoMEM_outpc, EXtoMEM_pc, EXtoMEM_alu_out, EXtoMEM_rd2, EXtoMEM_jump_addr;
	
	
	
	// for MEMtoWB_STAGE
	wire MEMtoWB_RegWrite, MEMtoWB_MemtoReg, MEMtoWB_Jump;
	wire [4:0] MEMtoWB_mux;	
	wire [5:0] MEMtoWB_opcode;
	wire [31:0] MEMtoWB_outpc, MEMtoWB_rd, MEMtoWB_alu_out;
	
	
	assign opcode = first_instr[31:26];
    assign rs = first_instr[25:21];
    assign rt = first_instr[20:16];
    assign rd = first_instr[15:11];
    assign shamt = first_instr[10:6];
    assign funct = first_instr[5:0];
    assign immed = first_instr[15:0];
    assign jumpoffset = first_instr[25:0];
	
	// branch offset shifter
    assign b_offset = immed << 2;
	
	// jump offset shifter & concatenation
	assign jump_addr = { pc_incr[31:28], jumpoffset <<2 };
 
	// module instantiations
	
	// --------------------------------------------------------- IF ---------------------------------------------------------
    
	add32 PCADD( .a(pc_try), .b(32'd4), .result(pc_incr) );// PC = PC + 4;

	PCControl PCSel( .op(opcode), .src(PCSrc), .pc(pc_try), .jsel(Jumpsel), .b_sub(BSrc) );
	
	mux3 #(32) PCMUX( .sel(PCSrc), .a(pc_incr), .b(b_tgt), .c(pc_temp), .y(branch_addr) );
	
	//Jump 指令
	mux2 #(32) JMUX( .sel(Jumpsel), .a(branch_addr), .b(jump_addr), .y(pc_next) ); 
	
	//assign pc_try = branch_addr;
	reg32 PC( .clk(clk), .rst(rst), .en_reg(1'b1), .d_in(pc_next), .d_out(pc_try) );

	memory InstrMem( .clk(clk), .MemRead(1'b1), .MemWrite(1'b0), .wd(32'd0), .addr(pc_try), .rd(instr) );
	stall Stall( .sel(BSrc), .pc_in(pc_try), .instr_in(instr), .pc_out(pc_stall), .instr_out(instr_stall) ) ;
	
	//暫存 IFTOID
	// 儲存: instr, pc_incr 
	FromIFTOID IFTOID(.clk(clk), .rst(rst), .instr_in(instr_stall), .inpc_in(pc_stall) , .pc_out(first_pc), .instr_out(first_instr), .branch(Branch)); 
	
    
	// --------------------------------------------------------- ID ---------------------------------------------------------
	
	// 依 MEMtoWB_RegWrite 看需不需要輸出wn
	// in : RegWrite, RN1, RN2, WN(要經過RFmux), WD
	// out: RD1, RD2
	reg_file RegFile( .clk(clk), .RegWrite(MEMtoWB_RegWrite), .RN1(rs), .RN2(rt), .WN(MEMtoWB_mux), .instr(first_instr),
					  .WD(rfile_wd), .RD1(rfile_rd1), .RD2(rfile_rd2) );
	// sign-extender
	sign_extend SignExt( .immed_in(immed), .ext_immed_out(extend_immed) ); 
	
	add32 BRADD( .a(pc_try), .b(b_offset), .result(b_tgt) );
	sub32 BSUB( .a(first_pc), .b(b_offset_sub), .result(pc_temp) );

	/*
	Input Port
		1. opcode: 輸入的指令代號，據此產生對應的控制訊號
	Input Port
		1. RegDst: 控制RFMUX
		2. ALUSrc: 控制ALUMUX
		3. MemtoReg: 控制WRMUX
		4. RegWrite: 控制暫存器是否可寫入
		5. MemRead:  控制記憶體是否可讀出
		6. MemWrite: 控制記憶體是否可寫入
		7. Branch: 與ALU輸出的zero訊號做AND運算控制PCMUX
		8. ALUOp: 輸出至ALU Control
*/
	control_unit CTLS( .instr(instr), .opcode(opcode), .funct(funct), .RegDst(RegDst), .ALUSrc(ALUSrc), .MemtoReg(MemtoReg), 
                       .RegWrite(RegWrite), .MemRead(MemRead), .MemWrite(MemWrite), 
					   .Branch(Branch), .Jump(Jump), .ALUOp(ALUOp) );
					   

	// 暫存 IDTOEX 
	// in 儲存: RegDst, ALUSrc, MemtoReg, RegWrite,  MemRead,  MemWrite, Branch, Jump, ALUOp, rt, rd, opcode,
	//		 first_pc, rfile_rd1, rfile_rd2, extend_immed, jump_addr
	
	// out 暫存: IDtoEX_RegDst, IDtoEX_STAGE_ALUSrc, IDtoEX_STAGE_MemtoReg, IDtoEX_STAGE_RegWrite, IDtoEX_STAGE_MemRead
	//			 IDtoEX_STAGE_MemWrite, IDtoEX_STAGE_Branch, IDtoEX_STAGE_Jump, IDtoEX_STAGE_ALUOp,
	// 			 IDtoEX_STAGE_rt, IDtoEX_STAGE_rd, IDtoEX_STAGE_opcode, IDtoEX_STAGE_pc, IDtoEX_STAGE_rd1,
	// 			 IDtoEX_STAGE_rd2, IDtoEX_STAGE_extend_immed, IDtoEX_STAGE_jump_addr
	
	FromIDTOEX IDTOEX(.clk(clk), .rst(BSrc), 
					  .RegDst_in(RegDst), .ALUSrc_in(ALUSrc), .MemtoReg_in(MemtoReg), .RegWrite_in(RegWrite), 
					  .MemRead_in(MemRead), .MemWrite_in(MemWrite), .Branch_in(Branch), .Jump_in(Jump), 
					  .ALUOp_in(ALUOp), .rt_in(rt), .rd_in(rd), .opcode_in(opcode), .rs_in(rs),
					  .pc_in(first_pc),.RD1_in(rfile_rd1), .RD2_in(rfile_rd2), .extend_immed_in(extend_immed), .jump_addr_in(jump_addr), .b_in(b_offset),
					  .RegDst_out(IDtoEX_RegDst), .ALUSrc_out(IDtoEX_STAGE_ALUSrc), .MemtoReg_out(IDtoEX_STAGE_MemtoReg), 
					  .RegWrite_out(IDtoEX_STAGE_RegWrite), .MemRead_out(IDtoEX_STAGE_MemRead), .MemWrite_out(IDtoEX_STAGE_MemWrite), 
					  .Branch_out(IDtoEX_STAGE_Branch), .Jump_out(IDtoEX_STAGE_Jump),
					  .ALUOp_out(IDtoEX_STAGE_ALUOp), .rt_out(IDtoEX_STAGE_rt), 
					  .rd_out(IDtoEX_STAGE_rd), .opcode_out(IDtoEX_STAGE_opcode), 
					  .pc_out(IDtoEX_STAGE_pc), .RD1_out(IDtoEX_STAGE_rd1), .RD2_out(IDtoEX_STAGE_rd2), 
					  .extend_immed_out(IDtoEX_STAGE_extend_immed),  .jump_addr_out(IDtoEX_STAGE_jump_addr),
					  .Funct_in(funct), .Funct_out(IDtoEX_STAGE_Funct), .rs_out(IDtoEX_rs), .b_out(b_offset_temp) ) ;   
	
	
	// --------------------------------------------------------- EX ---------------------------------------------------------
	
	// 在ALU之前的MUX
	// in: ALUSrc, rd2, extend_immed  
	// out: alu_b
	mux2 #(32) ALUMUX( .sel(IDtoEX_STAGE_ALUSrc), .a(OprandB), .b(IDtoEX_STAGE_extend_immed), .y(alu_b) ); 
	
	alu_ctl ALUCTL( .ALUOp(IDtoEX_STAGE_ALUOp), .Funct(IDtoEX_STAGE_Funct), .ALUOperation(Operation), .Hi(HiSel), .Lo(LoSel) );
	
	mux3 #(32) OprandAMUX( .sel(ForwardA), .a(IDtoEX_STAGE_rd1), .b(rfile_wd), .c(EXtoMEM_alu_out), .y(OprandA) );
	mux3 #(32) OprandBMUX( .sel(ForwardB), .a(IDtoEX_STAGE_rd2), .b(rfile_wd), .c(EXtoMEM_alu_out), .y(OprandB) );
	
	TotalALU total_alu( .Operation(Operation), .opcode(IDtoEX_STAGE_opcode), .immed(IDtoEX_STAGE_extend_immed[15:0]), 
				  .a(OprandA), .b(alu_b),.result(alu_out), .zero(Zero), .clk(clk) );
	
	Branch B( .b(IDtoEX_STAGE_Branch), .z(Zero), .sel(BSrc), .clk(clk) );
	
	MultControl Mult( .clk(clk), .a(OprandA), .b(OprandB), .result(HiLoTemp), .Funct(IDtoEX_STAGE_Funct), .Operation(Operation), .reset(rst) );

	mux2 #(5) RFMUX( .sel(IDtoEX_RegDst), .a(IDtoEX_STAGE_rt), .b(IDtoEX_STAGE_rd), .y(rfile_wn) ); 
	
	ForwardingUnit Fw_Unit( .MEM_rd(EXtoMEM_mux), .WB_rd(MEMtoWB_mux), .EX_rs(IDtoEX_rs), .EX_rt(IDtoEX_STAGE_rt),
                        	.ForwardA(ForwardA), .ForwardB(ForwardB), .clk(clk) );
	// 暫存 EX/MEM
	// in 儲存: Zero, rfile_wn, IDtoEX_STAGE_opcode, IDtoEX_STAGE_pc,  b_tgt,  alu_out, IDtoEX_STAGE_rd2, IDtoEX_STAGE_jump_addr
	//			, IDtoEX_STAGE_RegWrite, IDtoEX_STAGE_Branch, IDtoEX_STAGE_MemtoReg, IDtoEX_STAGE_MemRead
	//			, IDtoEX_STAGE_MemWrite,IDtoEX_STAGE_Jump
	
	// out 暫存: EXtoMEM_zero, EXtoMEM_mux, EXtoMEM_opcode, EXtoMEM_outpc, EXtoMEM_pc, EXtoMEM_alu_out, EXtoMEM_rd2
	//			, EXtoMEM_jump_addr, EXtoMEM_RegWrite, EXtoMEM_Branch, EXtoMEM_MemtoReg, EXtoMEM_MemRead
	//          , EXtoMEM_MemWrite, EXtoMEM_Jump
	FromEXTOMEM EXTOMEM(.clk(clk), .rst(rst),
						.zero_in(Zero),	.mux_in(rfile_wn), .opcode_in(IDtoEX_STAGE_opcode), .inpc_in(b_tgt), 	
						.pc_in(IDtoEX_STAGE_pc), .alu_out_IN(alu_out), .rd2_in(IDtoEX_STAGE_rd2),  .jump_addr_in(IDtoEX_STAGE_jump_addr),
						.RegWrite_in(IDtoEX_STAGE_RegWrite), .Branch_in(IDtoEX_STAGE_Branch), 
						.MemtoReg_in(IDtoEX_STAGE_MemtoReg), .MemRead_in(IDtoEX_STAGE_MemRead), .MemWrite_in(IDtoEX_STAGE_MemWrite), 
						.Jump_in(IDtoEX_STAGE_Jump), .b_in(b_offset_temp), .Hi_in(HiSel), .Lo_in(LoSel),
						.zero_out(EXtoMEM_zero), .mux_out(EXtoMEM_mux), .opcode_out(EXtoMEM_opcode), .outpc_out(EXtoMEM_pc),
						.pc_out(EXtoMEM_outpc), .alu_out_OUT(EXtoMEM_alu_out), .rd2_out(EXtoMEM_rd2), .jump_addr_out(EXtoMEM_jump_addr),   
						.RegWrite_out(EXtoMEM_RegWrite), .Branch_out(EXtoMEM_Branch), 
						.MemtoReg_out(EXtoMEM_MemtoReg), .MemRead_out(EXtoMEM_MemRead), .MemWrite_out(EXtoMEM_MemWrite), 
						.Jump_out(EXtoMEM_Jump), .b_out(b_offset_sub), .Hi_out(EXtoMEM_Hi), .Lo_out(EXtoMEM_Lo) );						

			
	// --------------------------------------------------------- MEM --------------------------------------------------------
	
	memory DatMem( .clk(clk), .MemRead(EXtoMEM_MemRead), .MemWrite(EXtoMEM_MemWrite), .wd(EXtoMEM_rd2), 
				   .addr(EXtoMEM_alu_out), .rd(dmem_rdata) );			
	
	
	// 暫存 MEM/WB
	// in 儲存: EXtoMEM_mux, EXtoMEM_opcode, EXtoMEM_outpc, dmem_rdata, EXtoMEM_alu_out, EXtoMEM_RegWrite, EXtoMEM_MemtoReg,
	// 			EXtoMEM_Jump
	
	// out 暫存: MEMtoWB_mux, MEMtoWB_opcode, MEMtoWB_outpc, MEMtoWB_rd, MEMtoWB_alu_out, MEMtoWB_RegWrite, MEMtoWB_MemtoReg,
	//			 MEMtoWB_Jump
	FromMEMTOWB MEMTOWB(.clk(clk), .rst(rst),
						.mux_in(EXtoMEM_mux), .opcode_in(EXtoMEM_opcode), .pc_in(EXtoMEM_outpc),  .rd_in(dmem_rdata), 
						.alu_out_IN(EXtoMEM_alu_out), .RegWrite_in(EXtoMEM_RegWrite), .MemtoReg_in(EXtoMEM_MemtoReg), 
						.Jump_in(EXtoMEM_Jump), .Hi(EXtoMEM_Hi), .Lo(EXtoMEM_Lo), .HiLo_in(HiLoTemp),
						.mux_out(MEMtoWB_mux), .opcode_out(MEMtoWB_opcode),  .pc_out(MEMtoWB_outpc), .rd_out(MEMtoWB_rd),
						.alu_out_OUT(MEMtoWB_alu_out),  .RegWrite_out(MEMtoWB_RegWrite), .MemtoReg_out(MEMtoWB_MemtoReg), 
						.Jump_out(MEMtoWB_Jump) ); //
						
	// --------------------------------------------------------- WB ---------------------------------------------------------
						
    mux2 #(32) WRMUX( .sel(MEMtoWB_MemtoReg), .a(MEMtoWB_alu_out), .b(MEMtoWB_rd), .y(rfile_wd) );
	

				   		   
endmodule