`timescale 1ns/1ns
module TotalALU( Operation, opcode, immed, a, b, result, zero, clk );
input clk;
input [2:0] Operation;
input [5:0] opcode ;
input [15:0] immed ;
input [31:0] a, b ;

output zero ;
output [31:0] result ;

//   AND  : 36
//   OR   : 37
//   ADD  : 32
//   SUB  : 34
//   SLL  : 0
//   SLT  : 42
//   MULTU: 25


parameter AND = 6'b100100;
parameter OR  = 6'b100101;
parameter ADD = 6'b100000;
parameter SUB = 6'b100010;
parameter SLT = 6'b101010;
parameter SLL = 6'b000000;
parameter MULTU=6'b011001;
parameter MFHI= 6'b010000;
parameter MFLO= 6'b010010;
/*
定義各種訊號
*/
//============================

wire [5:0] get_immed ;
wire [31:0] ALUOut, ShifterOut ;
// wire [31:0] dataOut ;

/*
定義各種接線
*/
//============================
	assign get_immed = immed[5:0];

ALU32 ALU( .a(a), .b(b), .Signal(Operation), .result(ALUOut), .zero(zero) );
Shifter Shifter( .dataA(b), .dataB(immed[10:6]), .dataOut(ShifterOut) );

/*
建立各種module
*/
	assign result = ( Operation == 3'b100 ) ? ShifterOut : ALUOut;


endmodule