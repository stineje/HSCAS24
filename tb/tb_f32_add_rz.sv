// testbench
module tb ();

   logic [31:0]  op1;		
   logic [31:0]  op2;		
   logic [2:0] 	 rm;		
   logic [2:0]	 op_type;	
   logic 	 P;   		
   logic 	 OvEn;		
   logic 	 UnEn;   	

   logic [63:0]  result;
   logic [4:0]   Flags;   	
   logic 	 Denorm;   	

   logic         clk;
   logic [31:0]  yexpected;
   logic 	 reset;   
   logic [63:0]  vectornum, errors;    // bookkeeping variables
   logic [103:0] testvectors[50000:0]; // array of testvectors
   logic [7:0] 	 flags_expected;

   integer 	handle3;
   integer 	desc3;   
   
   // instantiate device under test
   fpadd dut (result, Flags, Denorm, {op1, 32'h0}, {op2, 32'h0}, 
	      rm, op_type, P, OvEn, UnEn);   

   always     
     begin
	clk = 1; #5; clk = 0; #5;
     end
   
   initial
     begin
	handle3 = $fopen("f32_add_rz.out");
	$readmemh("f32_add_rz.tv", testvectors);
	vectornum = 0; errors = 0;
	reset = 1; #27; reset = 0;
     end

   always @(posedge clk)
     begin
	desc3 = handle3;
	#0  op_type = 3'b000;
	#0  P = 1'b1;
	#0  rm = 3'b001;
	#0  OvEn = 1'b0;
	#0  UnEn = 1'b0;	
	#1; {op1, op2, yexpected, flags_expected} = testvectors[vectornum];
	#5  $fdisplay(desc3, "%h_%h_%h_%b", op1, op2, result, Flags);
     end

   // check results on falling edge of clk
   always @(negedge clk)
     if (~reset) 
       begin // skip during reset
	  if (result[63:32] !== yexpected) begin  
             $display("Error: inputs = %h %h", op1, op2);
             $display("  outputs = %h (%h expected)", result, yexpected);
             errors = errors + 1;
	  end
	  vectornum = vectornum + 1;
	  if (testvectors[vectornum] === 104'bx) 
	    begin 
               $display("%d tests completed with %d errors", 
			vectornum, errors);
	       $finish();	       
	    end	
       end // if (~reset)
   
endmodule // tb


