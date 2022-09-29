module mux3( sel, a, b, c, y );
    parameter bitwidth=32;
    input [1:0] sel;
    input  [bitwidth-1:0] a, b, c;
    output [bitwidth-1:0] y;

    assign y = (sel == 2'b01) ? b : (sel == 2'b10) ? c : a;
endmodule