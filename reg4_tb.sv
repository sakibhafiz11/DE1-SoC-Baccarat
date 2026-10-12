module reg4_tb;

	logic [3:0] in; // Card Value coming in is 4-bits
	logic slow_clock; // This the clock from hitting the key to change the number
	logic load; // to help to deal with 1 card at a time.(this is the enable)
	logic resetb;
	logic [3:0] out; //stored card value
	
	
	reg4 test (
		.in(in),
		.slow_clock(slow_clock),
		.load(load),
		.resetb(resetb),
		.out(out)
	);
	
	 initial slow_clock = 0;
	 always #5 slow_clock = ~slow_clock;
	 
	 initial begin
	 
	 resetb = 1'b0; #10; // should clear it to 0, clears everything at START, makes sure we begin from 0, like pressing reset before a new game
	 resetb = 1'b1; #10; // should clear it to 0, tests that reset works AFTER storing a value, proves reset can clear a card that was loaded
	 
	 load = 1'd1; in = 4'b0111; #10; // we did load 1, so it should update the value to 7
	 load = 1'd0; in = 4'b0101; #10; // we did load 0, so the value should stay at 7 not change to 5.
	 
	 resetb = 1'b0; #10; // should clear it to 0.
	 $stop;
	end
	
endmodule

	 
	 
		