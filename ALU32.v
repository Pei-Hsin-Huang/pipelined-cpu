module ALU32( a, b, Signal, result, zero ) ;

input [31:0] a, b ;
input [2:0] Signal ; 

output zero;
output [31:0] result;

wire less ;
wire [31:0] c, sum, set ;

assign set = 32'b0 ;

	alu1 a0( .a(a[0]), .b(b[0]), .cin(Signal[2]), .cout(c[0]), .sum(sum[0]), .Signal(Signal) ) ;
	alu1 a1( .a(a[1]), .b(b[1]), .cin(c[0]), .cout(c[1]), .sum(sum[1]), .Signal(Signal) ) ;
	alu1 a2( .a(a[2]), .b(b[2]), .cin(c[1]), .cout(c[2]), .sum(sum[2]), .Signal(Signal) ) ;
	alu1 a3( .a(a[3]), .b(b[3]), .cin(c[2]), .cout(c[3]), .sum(sum[3]), .Signal(Signal) ) ;
	alu1 a4( .a(a[4]), .b(b[4]), .cin(c[3]), .cout(c[4]), .sum(sum[4]), .Signal(Signal) ) ;
	alu1 a5( .a(a[5]), .b(b[5]), .cin(c[4]), .cout(c[5]), .sum(sum[5]), .Signal(Signal) ) ;
	alu1 a6( .a(a[6]), .b(b[6]), .cin(c[5]), .cout(c[6]), .sum(sum[6]), .Signal(Signal) ) ;
	alu1 a7( .a(a[7]), .b(b[7]), .cin(c[6]), .cout(c[7]), .sum(sum[7]), .Signal(Signal) ) ;
	alu1 a8( .a(a[8]), .b(b[8]), .cin(c[7]), .cout(c[8]), .sum(sum[8]), .Signal(Signal) ) ;
	alu1 a9( .a(a[9]), .b(b[9]), .cin(c[8]), .cout(c[9]), .sum(sum[9]), .Signal(Signal) ) ;
	alu1 a10( .a(a[10]), .b(b[10]), .cin(c[9]), .cout(c[10]), .sum(sum[10]), .Signal(Signal) ) ;
	alu1 a11( .a(a[11]), .b(b[11]), .cin(c[10]), .cout(c[11]), .sum(sum[11]), .Signal(Signal) ) ;
	alu1 a12( .a(a[12]), .b(b[12]), .cin(c[11]), .cout(c[12]), .sum(sum[12]), .Signal(Signal) ) ;
	alu1 a13( .a(a[13]), .b(b[13]), .cin(c[12]), .cout(c[13]), .sum(sum[13]), .Signal(Signal) ) ;
	alu1 a14( .a(a[14]), .b(b[14]), .cin(c[13]), .cout(c[14]), .sum(sum[14]), .Signal(Signal) ) ;
	alu1 a15( .a(a[15]), .b(b[15]), .cin(c[14]), .cout(c[15]), .sum(sum[15]), .Signal(Signal) ) ;
	alu1 a16( .a(a[16]), .b(b[16]), .cin(c[15]), .cout(c[16]), .sum(sum[16]), .Signal(Signal) ) ;
	alu1 a17( .a(a[17]), .b(b[17]), .cin(c[16]), .cout(c[17]), .sum(sum[17]), .Signal(Signal) ) ;
	alu1 a18( .a(a[18]), .b(b[18]), .cin(c[17]), .cout(c[18]), .sum(sum[18]), .Signal(Signal) ) ;
	alu1 a19( .a(a[19]), .b(b[19]), .cin(c[18]), .cout(c[19]), .sum(sum[19]), .Signal(Signal) ) ;
	alu1 a20( .a(a[20]), .b(b[20]), .cin(c[19]), .cout(c[20]), .sum(sum[20]), .Signal(Signal) ) ;
	alu1 a21( .a(a[21]), .b(b[21]), .cin(c[20]), .cout(c[21]), .sum(sum[21]), .Signal(Signal) ) ;
	alu1 a22( .a(a[22]), .b(b[22]), .cin(c[21]), .cout(c[22]), .sum(sum[22]), .Signal(Signal) ) ;
	alu1 a23( .a(a[23]), .b(b[23]), .cin(c[22]), .cout(c[23]), .sum(sum[23]), .Signal(Signal) ) ;
	alu1 a24( .a(a[24]), .b(b[24]), .cin(c[23]), .cout(c[24]), .sum(sum[24]), .Signal(Signal) ) ;
	alu1 a25( .a(a[25]), .b(b[25]), .cin(c[24]), .cout(c[25]), .sum(sum[25]), .Signal(Signal) ) ;
	alu1 a26( .a(a[26]), .b(b[26]), .cin(c[25]), .cout(c[26]), .sum(sum[26]), .Signal(Signal) ) ;
	alu1 a27( .a(a[27]), .b(b[27]), .cin(c[26]), .cout(c[27]), .sum(sum[27]), .Signal(Signal) ) ;
	alu1 a28( .a(a[28]), .b(b[28]), .cin(c[27]), .cout(c[28]), .sum(sum[28]), .Signal(Signal) ) ;
	alu1 a29( .a(a[29]), .b(b[29]), .cin(c[28]), .cout(c[29]), .sum(sum[29]), .Signal(Signal) ) ;
	alu1 a30( .a(a[30]), .b(b[30]), .cin(c[29]), .cout(c[30]), .sum(sum[30]), .Signal(Signal) ) ;
	alu1 a31( .a(a[31]), .b(b[31]), .cin(c[30]), .cout(c[31]), .sum(sum[31]), .Signal(Signal) ) ;



	assign less = ( sum[31] == 1'b1 ) ? 1 : 0 ; // 最高位元如果是1，a<b
	assign result = ( Signal == 3'b111 ) ? less : sum[31:0] ; 
	assign zero = ( result == 32'b0 ) ? 1'b1 : 1'b0 ; 




endmodule