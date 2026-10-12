module dealcard ( //50MHz drives dealcard

	input logic clk,
	input logic resetb,
	output logic [3:0] new_card
	);
	
	
logic [3:0] dealer_card; //internal signal: Output ports → should not be read back inside always_ff, Internal signal → safe to read and write inside always_ff
	
always_ff @(posedge clk) begin
	if(resetb == 0)
		dealer_card <= 4'b0001;
		
	else if (dealer_card == 13)
		dealer_card <= 4'b0001;
		
	else
		dealer_card <= dealer_card + 1;
		
	end
	
	assign new_card = dealer_card; // connect to output which the function produced.
	
endmodule
	