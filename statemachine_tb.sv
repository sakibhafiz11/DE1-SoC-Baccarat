module statemachine_tb;
	
	logic resetb;
	logic [3:0] dscore;
	logic [3:0] pscore;
	logic [3:0] pcard3;
	logic load_pcard1;
	logic load_pcard2;
	logic load_pcard3;
	logic load_dcard1;
	logic load_dcard2;
	logic load_dcard3;
	logic player_win_light;
	logic dealer_win_light;
	logic slow_clock;
	
	initial slow_clock = 0;
	always #5 slow_clock = ~slow_clock;
	
	//instantiate statemachine
	
	statemachine state (
		.resetb(resetb),
		.slow_clock(slow_clock),
		.dscore(dscore),
      .pscore(pscore),
      .pcard3(pcard3),
      .load_pcard1(load_pcard1),
      .load_pcard2(load_pcard2),
      .load_pcard3(load_pcard3),
      .load_dcard1(load_dcard1),
      .load_dcard2(load_dcard2),
      .load_dcard3(load_dcard3),
      .player_win_light(player_win_light),
      .dealer_win_light(dealer_win_light)
	);
	
	initial begin
	
	// Test 1: Test if Reset Works
		//Initial Values
		pscore = 4'd0;
		dscore = 4'd0;
		pcard3 = 4'd0;
	
		resetb = 1'b0; #10; //when we press KEY(3) //activates reset
		resetb = 1'b1; #10; //released reset
		//now observe: load_pcard1 should be 1 in waveform
	
	// Test 2: Pressing KEY0
		#10;  // → DEAL_DCARD1, observe: load_dcard1=1
		#10;  // → DEAL_PCARD2, observe: load_pcard2=1
		#10;  // → DEAL_DCARD2, observe: load_dcard2=1
		#10;  // → CHECK, observe: all loads=0
		
	// Test 3 to check natural:
		// set scores before CHECK
		pscore = 4'd9;
		dscore = 4'd7;
		#10;  // CHECK → natural → DONE
	
	 // Test 4: Player gets 3rd card (need reset first!)
		 resetb = 1'b0; #10;  // reset → DEAL_PCARD1
		 resetb = 1'b1; #10;
		 pscore = 4'd0;
		 dscore = 4'd0;
		 #10;  // → DEAL_DCARD1
		 #10;  // → DEAL_PCARD2
		 #10;  // → DEAL_DCARD2
		 pscore = 4'd4;   // ≤5 → player draws!
		 dscore = 4'd6;
		 #10;  // → CHECK → player draws → DEAL_PCARD3
		 // observe: load_pcard3=1
		 pcard3 = 4'd7;   // player 3rd card = 7
		 #10;  // → dealer check → DEAL_DCARD3 (dscore=6, pcard3=7)
		 // observe: load_dcard3=1
		 #10;  // → DONE
		 
	// Test 5: Check for winner
		 // Player Winner
		 resetb = 1'b0; #10;  // reset → DEAL_PCARD1
		 resetb = 1'b1; #10;
		 pscore = 4'd0;
		 dscore = 4'd0;
		 #10;  // → DEAL_DCARD1
		 #10;  // → DEAL_PCARD2
		 #10;  // → DEAL_DCARD2
		 pscore = 4'd6;   
		 dscore = 4'd5;
		 #10; //check for player win.
		 
		// Tie
		 resetb = 1'b0; #10;  // reset → DEAL_PCARD1
		 resetb = 1'b1; #10;
		 pscore = 4'd0;
		 dscore = 4'd0;
		 #10;  // → DEAL_DCARD1
		 #10;  // → DEAL_PCARD2
		 #10;  // → DEAL_DCARD2
		 pscore = 4'd6;   
		 dscore = 4'd6;
		 #10; //check for player win.
		 
		 //Dealer Win
		 resetb = 1'b0; #10;  // reset → DEAL_PCARD1
		 resetb = 1'b1; #10;
		 pscore = 4'd0;
		 dscore = 4'd0;
		 #10;  // → DEAL_DCARD1
		 #10;  // → DEAL_PCARD2
		 #10;  // → DEAL_DCARD2
		 pscore = 4'd6;   
		 dscore = 4'd7;
		 #10; //check for player win.
		 
	// Test 6: Dealer gets 3rd card
	
        // Scenario A: Player stood, dealer draws
        resetb = 1'b0; #10;
        resetb = 1'b1; #10;
        pscore = 4'd0;
        dscore = 4'd0;
        #10; #10; #10;
        pscore = 4'd6;
        dscore = 4'd4;
        #10;  // → CHECK → player stands → DEAL_DCARD3
        // observe: load_dcard3=1
        #10;  // → DONE

        // Scenario B: Player drew, dealer draws
        resetb = 1'b0; #10;
        resetb = 1'b1; #10;
        pscore = 4'd0;
        dscore = 4'd0;
        #10; #10; #10;
        pscore = 4'd5;
        dscore = 4'd4;
        pcard3 = 4'd6;
        #10;  // → CHECK → player draws → DEAL_PCARD3
        #10;  // → dealer check → DEAL_DCARD3
        // observe: load_dcard3=1
        #10;  // → DONE

        // Scenario C: Player drew, dealer stands
        resetb = 1'b0; #10;
        resetb = 1'b1; #10;
        pscore = 4'd0;
        dscore = 4'd0;
        #10; #10; #10;
        pscore = 4'd5;
        dscore = 4'd4;
        pcard3 = 4'd1;  // pcard3=1, not in range 2-7 → dealer stands
        #10;  // → CHECK → player draws → DEAL_PCARD3
        #10;  // → dealer check → DONE (dealer stands)
        // observe: load_dcard3=0
        $stop;
    end

endmodule
		 
		 
		
		 
		
		
	
		
		
		