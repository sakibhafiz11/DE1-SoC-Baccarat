module datapath (
	input logic slow_clock,
	input logic fast_clock,
	input logic resetb,
	input logic load_pcard1,
	input logic load_pcard2,
	input logic load_pcard3,
	input logic load_dcard1,
	input logic load_dcard2,
	input logic load_dcard3,
	
	output logic [3:0] dscore_out,
	output logic [3:0] pscore_out,
	output logic [3:0] pcard3_out,
	output logic [6:0] HEX0,
	output logic [6:0] HEX1,
	output logic [6:0] HEX2,
	output logic [6:0] HEX3,
	output logic [6:0] HEX4,
	output logic [6:0] HEX5
	);
	
	//Internal Signals - internal signals help connect modules togather, example dealcard --> reg4, they need a wire between them to connect.
	logic [3:0] pcard1;
	logic [3:0] pcard2;
	logic [3:0] pcard3;
		
	logic [3:0] dcard1;
	logic [3:0] dcard2;
	logic [3:0] dcard3;
	
	logic [3:0] new_card; //dealcard output, this is he card value which dealcard generates
	
	
	// dealcard instantiation
	dealcard dc (
		.clk(fast_clock),
		.new_card(new_card),
		.resetb(resetb)
	);
	
	// reg4 instaniation
	
	// pcard1 instaniation
	reg4 card1 (
		.in(new_card),
		.slow_clock(slow_clock),
		.resetb(resetb),
		.load(load_pcard1),
		.out(pcard1) //stored value goes to the internal signal -> pcard is what comes out of reg4 after storing
	);
	
	// pcard2 instaniation
	reg4 card2 (
		.in(new_card),
		.slow_clock(slow_clock),
		.resetb(resetb),
		.load(load_pcard2),
		.out(pcard2) //stored value goes to the internal signal -> pcard is what comes out of reg4 after storing
	);
	
		// pcard3 instaniation
	reg4 card3 (
		.in(new_card),
		.slow_clock(slow_clock),
		.resetb(resetb),
		.load(load_pcard3),
		.out(pcard3) //stored value goes to the internal signal -> pcard is what comes out of reg4 after storing
	);
	
		// dcard1 instaniation
	reg4 d_card1 (
		.in(new_card),
		.slow_clock(slow_clock),
		.resetb(resetb),
		.load(load_dcard1),
		.out(dcard1) //stored value goes to the internal signal -> pcard is what comes out of reg4 after storing
	);
	
		// dcard2 instaniation
	reg4 d_card2 (
		.in(new_card),
		.slow_clock(slow_clock),
		.resetb(resetb),
		.load(load_dcard2),
		.out(dcard2) //stored value goes to the internal signal -> pcard is what comes out of reg4 after storing
	);
	
	// dcard3 instaniation
	reg4 d_card3 (
		.in(new_card),
		.slow_clock(slow_clock),
		.resetb(resetb),
		.load(load_dcard3),
		.out(dcard3) //stored value goes to the internal signal -> pcard is what comes out of reg4 after storing
	);
	
	//scorehand instaniation
	
	//player instaniation
	
	scorehand player (
		.card1(pcard1),
		.card2(pcard2),
		.card3(pcard3),
		.score(pscore_out)
	);
	
	//dealer instaniaion
	
	scorehand dealer (
		.card1(dcard1),
		.card2(dcard2),
		.card3(dcard3),
		.score(dscore_out)
	);
	
	//card7seg instaniaion
	
	// HEX0
	card7seg hex0 (
		.SW(pcard1),
		.HEX0(HEX0)
	);
	
	//HEX1
	card7seg hex1 (
		.SW(pcard2),
		.HEX0(HEX1)
	);
	
	
	//HEX2
	card7seg hex2 (
		.SW(pcard3),
		.HEX0(HEX2)
	);
	
	
	//HEX3
	card7seg hex3 (
		.SW(dcard1),
		.HEX0(HEX3)
	);
	
	
	//HEX4
	card7seg hex4 (
		.SW(dcard2),
		.HEX0(HEX4)
	);
	
	//HEX5
	card7seg hex5 (
		.SW(dcard3),
		.HEX0(HEX5)
	);
	
	
	assign pcard3_out = pcard3; //whatever value pcard3Out holds internally goes to pcard3 so it can be transfered to the statemachine
	
endmodule
	
	
	
	
	
	
	
	
	
	
	
	
	
		
		
		
		
		
		
	
	