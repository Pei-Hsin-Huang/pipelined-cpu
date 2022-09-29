/*
	Title: MIPS Pipeline CPU Testbench 
*/
module tb_Pipeline_cpu();
	reg clk, rst;
	
	// �]�w�n����h��cycle �Y���椣���Цۦ�վ�
	parameter cycle_count = 8;
	
	//���ͮɯߡA�g���G10���ɶ�
	initial begin
		clk = 1'b1;
		forever #5 clk = ~clk;
	end

	initial begin
		$dumpfile("pipeline_cpu.vcd");
		$dumpvars(0,tb_Pipeline_cpu);
		rst = 1'b1;
		/*
			���O��ưO����A�ɦW"instr_mem.txt, data_mem.txt"�i�ۦ�ק�
			�C�@�欰1 Byte��ơA�H��ӤQ���i��Ʀr���
			�B��Little Endian�s�X
		*/
		$readmemh("instr_mem.txt", CPU.InstrMem.mem_array );
		$readmemh("data_mem.txt", CPU.DatMem.mem_array );
		// �]�w�Ȧs����l�ȡA�C�@�欰�@���Ȧs�����
		$readmemh("reg.txt", CPU.RegFile.file_array );
		#10;
		rst = 1'b0;
		
	end
	
	initial begin
		// �@��cycle 10���ɶ�
		# (cycle_count*100);
		$display( "%d, End of Simulation\n", $time/10-1 );
		$finish;
	end
	
	always @( posedge clk ) begin
		$display( "%d, PC:", $time/10-1, CPU.pc_try );
		$display( "%d, wd: %d", $time/10-1, CPU.rfile_wd );
		
		if ( CPU.first_instr == 32'd0 ) begin
			$display( "%d, NOP\n", $time/10-1 ) ;
		end
		
		else if ( CPU.opcode == 6'd0 ) begin
			if ( CPU.funct == 6'd32 ) $display( "%d, ADD\n", $time/10-1 );
			else if ( CPU.funct == 6'd34 ) $display( "%d, SUB\n", $time/10-1 );
			else if ( CPU.funct == 6'd36 ) $display( "%d, AND\n", $time/10-1 );
			else if ( CPU.funct == 6'd37 ) $display( "%d, OR\n", $time/10-1 );
			else if ( CPU.funct == 6'd42 ) $display( "%d, SLT\n", $time/10-1 );
			else if ( CPU.funct == 6'd25 ) $display( "%d, MULTU\n", $time/10-1 );
			else if ( CPU.funct == 6'b010000 ) $display( "%d, MFHi\n", $time/10-1 );
			else if ( CPU.funct == 6'b010010 ) $display( "%d, MFLo\n", $time/10-1 );
            else if ( CPU.funct == 6'b000000 ) $display( "%d, SLL\n", $time/10-1 );			
		end
		else if ( CPU.opcode == 6'd35 ) $display( "%d, LW\n", $time/10-1 );
		else if ( CPU.opcode == 6'd43 ) $display( "%d, SW\n", $time/10-1 );
		else if ( CPU.opcode == 6'd4 ) $display( "%d, BEQ\n", $time/10-1 );
		else if ( CPU.opcode == 6'd2 ) $display( "%d, J\n", $time/10-1 );
		else if ( CPU.opcode == 6'd3 ) $display( "%d, JAL\n", $time/10-1 );
		else if ( CPU.opcode == 6'd9 ) $display( "%d, ADDIU\n", $time/10-1 );
		
	end
	
	pipeline_cpu CPU( clk, rst );
	
endmodule
