module MUX2_1( out, in1, in0, sel ) ;

output	out;
input	in1, in0, sel;

wire	out;
assign	out = sel ? in1 : in0;

endmodule