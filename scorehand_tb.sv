module scorehand_tb;
	logic [3:0] card1;
	logic [3:0] card2;
	logic [3:0] card3;
	
	logic [3:0] score;
	
	scorehand test (
	
	.card1(card1),
	.card2(card2),
	.card3(card3),
	.score(score)
	);
	
	initial begin
		//Test 1
		card1 = 4'd7; card2 = 4'd2; card3 = 4'd0; #10; 
		//Test 2
		card1 = 4'd13; card2 = 4'd5; card3 = 4'd0; #10; // should be 5.
		//Test 3
		card1 = 4'd7; card2 = 4'd8; card3 = 4'd0; #10; // should be 5
		//Test 4
		card1 = 4'd9; card2 = 4'd9; card3 = 4'd0; #10; // should be a 8
		//Test 5
		card1 = 4'd3; card2 = 4'd4; card3 = 4'd5; #10; // should be a 2
		$stop;
	end
	
endmodule