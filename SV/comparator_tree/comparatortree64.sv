 
// This module compares two 64-bit values A and B. LT is '1' if A < B 
// and EQ is '1'if A = B. LT and GT are both '0' if A > B.
// This structure was modified so
// that it only does a strict magnitdude comparison, and only
// returns flags for less than (LT) and eqaual to (EQ). It uses a tree 
// of 63 2-bit magnitude comparators, followed by one OR gates.
//
 
module comparatortree64 (A, B, EQ, LT, LTu);
 
   input logic [63:0] A;
   input logic [63:0] B;

   output logic       EQ;
   output logic       LT;
   output logic       LTu;
 
   logic [31:0]       s;
   logic [31:0]       t;
   logic [15:0]       u;
   logic [15:0]       v;
   logic [7:0]        w;
   logic [7:0]        x;
   logic [3:0]        y;
   logic [3:0]        z;
   logic [1:0]        a0;
   logic [1:0]        b0;
   logic [1:0]        a1;
   logic [1:0]        b1;

   logic 	          GT;
   logic              GTU;
   //logic 	          LT;
   //logic            LTu;
   //logic 	          EQ;
   logic [1:0] 	    A2;
   logic [1:0]        B2;

   logic              sA, sB;
   logic              tA, tB;
   logic              uA, uB;
   logic              vA, vB;
   logic              wA, wB;
   logic              xA, xB;
   logic              yA, yB;
   logic              zA, zB;

   //assign A2 = Sel ? {~A[63], A[62]} : A[63:62];
   //assign B2 = Sel ? {~B[63], B[62]} : B[63:62];
   assign A2 = {~A[63], A[62]};
   assign B2 = {~B[63], B[62]};   
   
   magcompare2b mag1(s[0], t[0], A[1:0], B[1:0]);
   magcompare2b mag2(s[1], t[1], A[3:2], B[3:2]);
   magcompare2b mag3(s[2], t[2], A[5:4], B[5:4]);
   magcompare2b mag4(s[3], t[3], A[7:6], B[7:6]);
   magcompare2b mag5(s[4], t[4], A[9:8], B[9:8]);
   magcompare2b mag6(s[5], t[5], A[11:10], B[11:10]);
   magcompare2b mag7(s[6], t[6], A[13:12], B[13:12]);
   magcompare2b mag8(s[7], t[7], A[15:14], B[15:14]);
   magcompare2b mag9(s[8], t[8], A[17:16], B[17:16]);
   magcompare2b magA(s[9], t[9], A[19:18], B[19:18]);
   magcompare2b magB(s[10], t[10], A[21:20], B[21:20]);
   magcompare2b magC(s[11], t[11], A[23:22], B[23:22]);
   magcompare2b magD(s[12], t[12], A[25:24], B[25:24]);
   magcompare2b magE(s[13], t[13], A[27:26], B[27:26]);
   magcompare2b magF(s[14], t[14], A[29:28], B[29:28]);
   magcompare2b mag10(s[15], t[15], A[31:30], B[31:30]);
   magcompare2b mag11(s[16], t[16], A[33:32], B[33:32]);
   magcompare2b mag12(s[17], t[17], A[35:34], B[35:34]);
   magcompare2b mag13(s[18], t[18], A[37:36], B[37:36]);
   magcompare2b mag14(s[19], t[19], A[39:38], B[39:38]);
   magcompare2b mag15(s[20], t[20], A[41:40], B[41:40]);
   magcompare2b mag16(s[21], t[21], A[43:42], B[43:42]);
   magcompare2b mag17(s[22], t[22], A[45:44], B[45:44]);
   magcompare2b mag18(s[23], t[23], A[47:46], B[47:46]);
   magcompare2b mag19(s[24], t[24], A[49:48], B[49:48]);
   magcompare2b mag1A(s[25], t[25], A[51:50], B[51:50]);
   magcompare2b mag1B(s[26], t[26], A[53:52], B[53:52]);
   magcompare2b mag1C(s[27], t[27], A[55:54], B[55:54]);
   magcompare2b mag1D(s[28], t[28], A[57:56], B[57:56]);
   magcompare2b mag1E(s[29], t[29], A[59:58], B[59:58]);
   magcompare2b mag1F(s[30], t[30], A[61:60], B[61:60]);
   
   magcompare2b mag20a(sA, tA, A2, B2);
   magcompare2b mag20(s[31], t[31], A[63:62], B[63:62]);

   //
   magcompare2c mag21(u[0], v[0], t[1:0], s[1:0]);
   magcompare2c mag22(u[1], v[1], t[3:2], s[3:2]);
   magcompare2c mag23(u[2], v[2], t[5:4], s[5:4]);
   magcompare2c mag24(u[3], v[3], t[7:6], s[7:6]);
   magcompare2c mag25(u[4], v[4], t[9:8], s[9:8]);
   magcompare2c mag26(u[5], v[5], t[11:10], s[11:10]);
   magcompare2c mag27(u[6], v[6], t[13:12], s[13:12]);
   magcompare2c mag28(u[7], v[7], t[15:14], s[15:14]);
   magcompare2c mag29(u[8], v[8], t[17:16], s[17:16]);
   magcompare2c mag2A(u[9], v[9], t[19:18], s[19:18]);
   magcompare2c mag2B(u[10], v[10], t[21:20], s[21:20]);
   magcompare2c mag2C(u[11], v[11], t[23:22], s[23:22]);
   magcompare2c mag2D(u[12], v[12], t[25:24], s[25:24]);
   magcompare2c mag2E(u[13], v[13], t[27:26], s[27:26]);
   magcompare2c mag2F(u[14], v[14], t[29:28], s[29:28]);
   
   magcompare2c mag30a(uA, vA, {tA, t[30]}, {sA, s[30]});
   magcompare2c mag30(u[15], v[15], t[31:30], s[31:30]);

   //
   magcompare2c mag31(w[0], x[0], v[1:0], u[1:0]);
   magcompare2c mag32(w[1], x[1], v[3:2], u[3:2]);
   magcompare2c mag33(w[2], x[2], v[5:4], u[5:4]);
   magcompare2c mag34(w[3], x[3], v[7:6], u[7:6]);
   magcompare2c mag35(w[4], x[4], v[9:8], u[9:8]);
   magcompare2c mag36(w[5], x[5], v[11:10], u[11:10]);
   magcompare2c mag37(w[6], x[6], v[13:12], u[13:12]);
   
   magcompare2c mag38a(wA, xA, {vA, v[14]}, {uA, u[14]});
   magcompare2c mag38(w[7], x[7], v[15:14], u[15:14]);

   //
   magcompare2c mag39(y[0], z[0], x[1:0], w[1:0]);
   magcompare2c mag3A(y[1], z[1], x[3:2], w[3:2]);
   magcompare2c mag3B(y[2], z[2], x[5:4], w[5:4]);

   magcompare2c mag3Ca(yA, zA, {xA, x[6]}, {wA, w[6]});
   magcompare2c mag3C(y[3], z[3], x[7:6], w[7:6]);

   //
   magcompare2c mag3D(a0[0], b0[0], z[1:0], y[1:0]);
   magcompare2c mag3Ea(a1[1], b1[1], {zA, z[2]}, {yA, y[2]});
   
   magcompare2c mag3E(a0[1], b0[1], z[3:2], y[3:2]);

   magcompare2c mag3Fa(LT, GT, {b1[1], b0[0]}, {a1[1], a0[0]});
   magcompare2c mag3F(LTu, GTu, b0[1:0], a0[1:0]);

   assign EQ = ~(LT | GT);
 
endmodule // comp64
