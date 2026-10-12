module scorehand (
	input logic [3:0] card1,
	input logic [3:0] card2,
	input logic [3:0] card3,
	
	output logic [3:0] score
	);
	
	logic [3:0] val1, val2, val3; //internal signals
	
	always_comb begin
	//Card 1:
		if (card1 >= 10)
			val1 = 0;
		else 
			val1 = card1;
			
	//Card 2:		
		if (card2 >= 10)
			val2 = 0;
		else 
			val2 = card2;
			
	//Card 3:
		if (card3 >= 10)
			val3 = 0;
		else
			val3 = card3;
			
	//Score:		
		score = (val1 +val2 +val3)%10; // %10 means we divide the value by 10 and the remainder will be the output.
			
	end
		
endmodule