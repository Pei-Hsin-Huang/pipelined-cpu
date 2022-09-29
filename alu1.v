module alu1( a, b, cin, cout, sum, Signal ) ;

output cout, sum ;
input a, b, cin ;
input [2:0] Signal ;

wire binvert ;
wire btemp ;
wire s0, s1, s2 ; // 運算完暫存
wire ct ;


// AND
and( s0, a, b ) ;
// OR
or( s1, a, b ) ;


assign binvert = Signal[2] ;
xor( btemp, binvert, b ) ;

fulladder addsub( .sum(s2), .cout(cout), .a(a), .b(btemp), .cin(cin) ) ;
assign sum = ( Signal == 3'b000 ) ? s0 : ( Signal == 3'b001 ) ? s1 : s2 ; // AND 或 OR
 
endmodule