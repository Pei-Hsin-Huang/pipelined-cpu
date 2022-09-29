module stall ( sel, pc_in, instr_in, pc_out, instr_out ) ;
input sel ;
input [31:0] pc_in, instr_in;

output [31:0] pc_out, instr_out;

assign pc_out = sel ? 32'b0 : pc_in;
assign instr_out = sel ? 32'b0 : instr_in;

endmodule