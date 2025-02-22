module DW_fp_div_inst( inst_a, inst_b, inst_rnd, z_inst, status_inst );

   parameter sig_width = 23;
   parameter exp_width = 8;
   parameter ieee_compliance = 1;
   parameter faithful_round = 0;
   
   input [sig_width+exp_width : 0]  inst_a;
   input [sig_width+exp_width : 0]  inst_b;
   input [2 : 0] 		    inst_rnd;
   output [sig_width+exp_width : 0] z_inst;
   output [7 : 0] 		    status_inst;
   
   // Instance of DW_fp_div
   DW_fp_div #(sig_width, exp_width, ieee_compliance, faithful_round) U1 
     (.a(inst_a), .b(inst_b), .rnd(inst_rnd), .z(z_inst), .status(status_inst));
endmodule 

