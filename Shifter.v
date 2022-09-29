module Shifter( dataA, dataB, dataOut );
input reset ;
input [31:0] dataA ;
input [4:0] dataB ; //The 5-bit shift magnitude selection Input

output [31:0] dataOut ;

wire [31:0] 	ST1, ST2, ST3, ST4; //Four 32-bit intermediate lines  
wire [31:0]     set, temp;


//1
MUX2_1 m0( ST1[0], 1'b0, dataA[0], dataB[0] );
MUX2_1 m1( ST1[1], dataA[0], dataA[1], dataB[0] );
MUX2_1 m2( ST1[2], dataA[1], dataA[2], dataB[0] );
MUX2_1 m3( ST1[3], dataA[2], dataA[3], dataB[0] );
MUX2_1 m4( ST1[4], dataA[3], dataA[4], dataB[0] );
MUX2_1 m5( ST1[5], dataA[4], dataA[5], dataB[0] );
MUX2_1 m6( ST1[6], dataA[5], dataA[6], dataB[0] );
MUX2_1 m7( ST1[7], dataA[6], dataA[7], dataB[0] );
MUX2_1 m8( ST1[8], dataA[7], dataA[8], dataB[0] );
MUX2_1 m9( ST1[9], dataA[8], dataA[9], dataB[0] );
MUX2_1 m10( ST1[10], dataA[9], dataA[10], dataB[0] );
MUX2_1 m11( ST1[11], dataA[10], dataA[11], dataB[0] );
MUX2_1 m12( ST1[12], dataA[11], dataA[12], dataB[0] );
MUX2_1 m13( ST1[13], dataA[12], dataA[13], dataB[0] );
MUX2_1 m14( ST1[14], dataA[13], dataA[14], dataB[0] );
MUX2_1 m15( ST1[15], dataA[14], dataA[15], dataB[0] );
MUX2_1 m16( ST1[16], dataA[15], dataA[16], dataB[0] );
MUX2_1 m17( ST1[17], dataA[16], dataA[17], dataB[0] );
MUX2_1 m18( ST1[18], dataA[17], dataA[18], dataB[0] );
MUX2_1 m19( ST1[19], dataA[18], dataA[19], dataB[0] );
MUX2_1 m20( ST1[20], dataA[29], dataA[20], dataB[0] );
MUX2_1 m21( ST1[21], dataA[20], dataA[21], dataB[0] );
MUX2_1 m22( ST1[22], dataA[21], dataA[22], dataB[0] );
MUX2_1 m23( ST1[23], dataA[22], dataA[23], dataB[0] );
MUX2_1 m24( ST1[24], dataA[23], dataA[24], dataB[0] );
MUX2_1 m25( ST1[25], dataA[24], dataA[25], dataB[0] );
MUX2_1 m26( ST1[26], dataA[25], dataA[26], dataB[0] );
MUX2_1 m27( ST1[27], dataA[26], dataA[27], dataB[0] );
MUX2_1 m28( ST1[28], dataA[27], dataA[28], dataB[0] );
MUX2_1 m29( ST1[29], dataA[28], dataA[29], dataB[0] );
MUX2_1 m30( ST1[30], dataA[29], dataA[30], dataB[0] );
MUX2_1 m31( ST1[31], dataA[30], dataA[31], dataB[0] );

//2
MUX2_1 ms0( ST2[0], 1'b0, ST1[0], dataB[1] );
MUX2_1 ms1( ST2[1], 1'b0, ST1[1], dataB[1] );
MUX2_1 ms2( ST2[2], ST1[0], ST1[2], dataB[1] );
MUX2_1 ms3( ST2[3], ST1[1], ST1[3], dataB[1] );
MUX2_1 ms4( ST2[4], ST1[2], ST1[4], dataB[1] );
MUX2_1 ms5( ST2[5], ST1[3], ST1[5], dataB[1] );
MUX2_1 ms6( ST2[6], ST1[4], ST1[6], dataB[1] );
MUX2_1 ms7( ST2[7], ST1[5], ST1[7], dataB[1] );
MUX2_1 ms8( ST2[8], ST1[6], ST1[8], dataB[1] );
MUX2_1 ms9( ST2[9], ST1[7], ST1[9], dataB[1] );
MUX2_1 ms10( ST2[10], ST1[8], ST1[10], dataB[1] );
MUX2_1 ms11( ST2[11], ST1[9], ST1[11], dataB[1] );
MUX2_1 ms12( ST2[12], ST1[10], ST1[12], dataB[1] );
MUX2_1 ms13( ST2[13], ST1[11], ST1[13], dataB[1] );
MUX2_1 ms14( ST2[14], ST1[12], ST1[14], dataB[1] );
MUX2_1 ms15( ST2[15], ST1[13], ST1[15], dataB[1] );
MUX2_1 ms16( ST2[16], ST1[14], ST1[16], dataB[1] );
MUX2_1 ms17( ST2[17], ST1[15], ST1[17], dataB[1] );
MUX2_1 ms18( ST2[18], ST1[16], ST1[18], dataB[1] );
MUX2_1 ms19( ST2[19], ST1[17], ST1[19], dataB[1] );
MUX2_1 ms20( ST2[20], ST1[18], ST1[20], dataB[1] );
MUX2_1 ms21( ST2[21], ST1[19], ST1[21], dataB[1] );
MUX2_1 ms22( ST2[22], ST1[20], ST1[22], dataB[1] );
MUX2_1 ms23( ST2[23], ST1[21], ST1[23], dataB[1] );
MUX2_1 ms24( ST2[24], ST1[22], ST1[24], dataB[1] );
MUX2_1 ms25( ST2[25], ST1[23], ST1[25], dataB[1] );
MUX2_1 ms26( ST2[26], ST1[24], ST1[26], dataB[1] );
MUX2_1 ms27( ST2[27], ST1[25], ST1[27], dataB[1] );
MUX2_1 ms28( ST2[28], ST1[26], ST1[28], dataB[1] );
MUX2_1 ms29( ST2[29], ST1[27], ST1[29], dataB[1] );
MUX2_1 ms30( ST2[30], ST1[28], ST1[30], dataB[1] );
MUX2_1 ms31( ST2[31], ST1[29], ST1[31], dataB[1] );

//3
MUX2_1 mt0( ST3[0], 1'b0, ST2[0], dataB[2] );
MUX2_1 mt1( ST3[1], 1'b0, ST2[1], dataB[2] );
MUX2_1 mt2( ST3[2], 1'b0, ST2[2], dataB[2] );
MUX2_1 mt3( ST3[3], 1'b0, ST2[3], dataB[2] );
MUX2_1 mt4( ST3[4], ST2[0], ST2[4], dataB[2] );
MUX2_1 mt5( ST3[5], ST2[1], ST2[5], dataB[2] );
MUX2_1 mt6( ST3[6], ST2[2], ST2[6], dataB[2] );
MUX2_1 mt7( ST3[7], ST2[3], ST2[7], dataB[2] );
MUX2_1 mt8( ST3[8], ST2[4], ST2[8], dataB[2] );
MUX2_1 mt9( ST3[9], ST2[5], ST2[9], dataB[2] );
MUX2_1 mt10( ST3[10], ST2[6], ST2[10], dataB[2] );
MUX2_1 mt11( ST3[11], ST2[7], ST2[11], dataB[2] );
MUX2_1 mt12( ST3[12], ST2[8], ST2[12], dataB[2] );
MUX2_1 mt13( ST3[13], ST2[9], ST2[13], dataB[2] );
MUX2_1 mt14( ST3[14], ST2[10], ST2[14], dataB[2] );
MUX2_1 mt15( ST3[15], ST2[11], ST2[15], dataB[2] );
MUX2_1 mt16( ST3[16], ST2[12], ST2[16], dataB[2] );
MUX2_1 mt17( ST3[17], ST2[13], ST2[17], dataB[2] );
MUX2_1 mt18( ST3[18], ST2[14], ST2[18], dataB[2] );
MUX2_1 mt19( ST3[19], ST2[15], ST2[19], dataB[2] );
MUX2_1 mt20( ST3[20], ST2[16], ST2[20], dataB[2] );
MUX2_1 mt21( ST3[21], ST2[17], ST2[21], dataB[2] );
MUX2_1 mt22( ST3[22], ST2[18], ST2[22], dataB[2] );
MUX2_1 mt23( ST3[23], ST2[19], ST2[23], dataB[2] );
MUX2_1 mt24( ST3[24], ST2[20], ST2[24], dataB[2] );
MUX2_1 mt25( ST3[25], ST2[21], ST2[25], dataB[2] );
MUX2_1 mt26( ST3[26], ST2[22], ST2[26], dataB[2] );
MUX2_1 mt27( ST3[27], ST2[23], ST2[27], dataB[2] );
MUX2_1 mt28( ST3[28], ST2[24], ST2[28], dataB[2] );
MUX2_1 mt29( ST3[29], ST2[25], ST2[29], dataB[2] );
MUX2_1 mt30( ST3[30], ST2[26], ST2[30], dataB[2] );
MUX2_1 mt31( ST3[31], ST2[27], ST2[31], dataB[2] );

//4
MUX2_1 mf0( ST4[0], 1'b0, ST3[0], dataB[3] );
MUX2_1 mf1( ST4[1], 1'b0, ST3[1], dataB[3] );
MUX2_1 mf2( ST4[2], 1'b0, ST3[2], dataB[3] );
MUX2_1 mf3( ST4[3], 1'b0, ST3[3], dataB[3] );
MUX2_1 mf4( ST4[4], 1'b0, ST3[4], dataB[3] );
MUX2_1 mf5( ST4[5], 1'b0, ST3[5], dataB[3] );
MUX2_1 mf6( ST4[6], 1'b0, ST3[6], dataB[3] );
MUX2_1 mf7( ST4[7], 1'b0, ST3[7], dataB[3] );
MUX2_1 mf8( ST4[8], ST3[0], ST3[8], dataB[3] );
MUX2_1 mf9( ST4[9], ST3[1], ST3[9], dataB[3] );
MUX2_1 mf10( ST4[10], ST3[2], ST3[10], dataB[3] );
MUX2_1 mf11( ST4[11], ST3[3], ST3[11], dataB[3] );
MUX2_1 mf12( ST4[12], ST3[4], ST3[12], dataB[3] );
MUX2_1 mf13( ST4[13], ST3[5], ST3[13], dataB[3] );
MUX2_1 mf14( ST4[14], ST3[6], ST3[14], dataB[3] );
MUX2_1 mf15( ST4[15], ST3[7], ST3[15], dataB[3] );
MUX2_1 mf16( ST4[16], ST3[8], ST3[16], dataB[3] );
MUX2_1 mf17( ST4[17], ST3[9], ST3[17], dataB[3] );
MUX2_1 mf18( ST4[18], ST3[10], ST3[18], dataB[3] );
MUX2_1 mf19( ST4[19], ST3[11], ST3[19], dataB[3] );
MUX2_1 mf20( ST4[20], ST3[12], ST3[20], dataB[3] );
MUX2_1 mf21( ST4[21], ST3[13], ST3[21], dataB[3] );
MUX2_1 mf22( ST4[22], ST3[14], ST3[22], dataB[3] );
MUX2_1 mf23( ST4[23], ST3[15], ST3[23], dataB[3] );
MUX2_1 mf24( ST4[24], ST3[16], ST3[24], dataB[3] );
MUX2_1 mf25( ST4[25], ST3[17], ST3[25], dataB[3] );
MUX2_1 mf26( ST4[26], ST3[18], ST3[26], dataB[3] );
MUX2_1 mf27( ST4[27], ST3[19], ST3[27], dataB[3] );
MUX2_1 mf28( ST4[28], ST3[20], ST3[28], dataB[3] );
MUX2_1 mf29( ST4[29], ST3[21], ST3[29], dataB[3] );
MUX2_1 mf30( ST4[30], ST3[22], ST3[30], dataB[3] );
MUX2_1 mf31( ST4[31], ST3[23], ST3[31], dataB[3] );

//5
MUX2_1 mff0( temp[0], 1'b0, ST4[0], dataB[4] );
MUX2_1 mff1( temp[1], 1'b0, ST4[1], dataB[4] );
MUX2_1 mff2( temp[2], 1'b0, ST4[2], dataB[4] );
MUX2_1 mff3( temp[3], 1'b0, ST4[3], dataB[4] );
MUX2_1 mff4( temp[4], 1'b0, ST4[4], dataB[4] );
MUX2_1 mff5( temp[5], 1'b0, ST4[5], dataB[4] );
MUX2_1 mff6( temp[6], 1'b0, ST4[6], dataB[4] );
MUX2_1 mff7( temp[7], 1'b0, ST4[7], dataB[4] );
MUX2_1 mff8( temp[8], 1'b0, ST4[8], dataB[4] );
MUX2_1 mff9( temp[9], 1'b0, ST4[9], dataB[4] );
MUX2_1 mff10( temp[10], 1'b0, ST4[10], dataB[4] );
MUX2_1 mff11( temp[11], 1'b0, ST4[11], dataB[4] );
MUX2_1 mff12( temp[12], 1'b0, ST4[12], dataB[4] );
MUX2_1 mff13( temp[13], 1'b0, ST4[13], dataB[4] );
MUX2_1 mff14( temp[14], 1'b0, ST4[14], dataB[4] );
MUX2_1 mff15( temp[15], 1'b0, ST4[15], dataB[4] );
MUX2_1 mff16( temp[16], ST4[0], ST4[16], dataB[4] );
MUX2_1 mff17( temp[17], ST4[1], ST4[17], dataB[4] );
MUX2_1 mff18( temp[18], ST4[2], ST4[18], dataB[4] );
MUX2_1 mff19( temp[19], ST4[3], ST4[19], dataB[4] );
MUX2_1 mff20( temp[20], ST4[4], ST4[20], dataB[4] );
MUX2_1 mff21( temp[21], ST4[5], ST4[21], dataB[4] );
MUX2_1 mff22( temp[22], ST4[6], ST4[22], dataB[4] );
MUX2_1 mff23( temp[23], ST4[7], ST4[23], dataB[4] );
MUX2_1 mff24( temp[24], ST4[8], ST4[24], dataB[4] );
MUX2_1 mff25( temp[25], ST4[9], ST4[25], dataB[4] );
MUX2_1 mff26( temp[26], ST4[10], ST4[26], dataB[4] );
MUX2_1 mff27( temp[27], ST4[11], ST4[27], dataB[4] );
MUX2_1 mff28( temp[28], ST4[12], ST4[28], dataB[4] );
MUX2_1 mff29( temp[29], ST4[13], ST4[29], dataB[4] );
MUX2_1 mff30( temp[30], ST4[14], ST4[30], dataB[4] );
MUX2_1 mff31( temp[31], ST4[15], ST4[31], dataB[4] );

assign dataOut = temp ; 

endmodule