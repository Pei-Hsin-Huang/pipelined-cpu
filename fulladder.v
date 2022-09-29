module fulladder( sum, cout, a, b, cin ) ;
output sum, cout ;
input a, b, cin, sel ;

wire e1, e2, e3 ;

xor( e1, a, b ) ;
and( e2, a, b ) ;
xor( sum, e1, cin ) ;
and( e3, e1, cin ) ;
xor( cout, e2, e3 ) ;

endmodule