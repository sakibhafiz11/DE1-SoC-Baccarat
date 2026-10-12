module statemachine (
		input logic resetb,
		input logic slow_clock,
		input logic [3:0] pscore,
		input logic [3:0] dscore,
		input logic [3:0] pcard3,
		output logic load_pcard1,
		output logic load_pcard2,
		output logic load_pcard3,
		output logic load_dcard1,
		output logic load_dcard2,
		output logic load_dcard3,
		output logic player_win_light,
		output logic dealer_win_light
	);
	
	
	//States
	typedef enum logic [2:0] {
		DEAL_PCARD1, //state 0
		DEAL_DCARD1, //state 1
		DEAL_PCARD2, //state 2
		DEAL_DCARD2, //state 3
		CHECK, //state 4
		DEAL_PCARD3, //state 5
		DEAL_DCARD3, //state 6
		DONE //state 7
	}state_t;
	
	//Variable Declariation
	state_t current_state;
	state_t next_state;
		
	
	// Block 1: State Register - stores the current state, on every clk edge the current state updates
	
	always_ff @(posedge slow_clock) begin

		if(!resetb)
			current_state <= DEAL_PCARD1;
			
		else
			current_state <= next_state;
	end
	
	// Block 2: Decides where to go next
	
	always_comb begin
		case(current_state)
			DEAL_PCARD1: next_state = DEAL_DCARD1;
			DEAL_DCARD1: next_state = DEAL_PCARD2;
			DEAL_PCARD2: next_state = DEAL_DCARD2;
			DEAL_DCARD2: next_state = CHECK;
			DEAL_DCARD3: next_state = DONE;
			DONE: next_state = DONE;
			
		CHECK: begin
			if(pscore >= 8 || dscore >= 8 ) //check for natural
				next_state = DONE;
				
			else if (pscore <= 5) //check for if player needs a third card
				next_state = DEAL_PCARD3;
				
			else if ((pscore == 6 || pscore == 7) && dscore <= 5) // if player stands does dealer get a third card
				next_state = DEAL_DCARD3;
			
			else 
				next_state = DONE;
			end
			
		DEAL_PCARD3: begin
			if(dscore >= 7)
				next_state = DONE; // dealer stands
				
			else if (dscore == 6 && (pcard3 == 6 || pcard3 == 7))
				next_state = DEAL_DCARD3; //dealer draws
				
			else if (dscore == 5 && (pcard3 == 4 || pcard3 == 5 || pcard3 == 6 || pcard3 == 7))
				next_state = DEAL_DCARD3; //dealer draws
				
			else if (dscore == 4 && (pcard3 >= 2 && pcard3 <= 7)) //means between 2 and 7
				next_state = DEAL_DCARD3; //dealer draws
			
			else if (dscore == 3 && (pcard3 != 8))
				next_state = DEAL_DCARD3; //dealer draws
				
			else if (dscore <= 2)
				next_state = DEAL_DCARD3; //dealer draws
				
			else 
				next_state = DONE;
		end
		default: next_state = DEAL_PCARD1;
	endcase
	end
	
			
	//Block 3: Decides when to load in and decide the winner.
	always_comb begin
		case(current_state) 
			DEAL_PCARD1: begin
				 load_pcard1 = 1;
				 load_pcard2 = 0;
				 load_pcard3 = 0;
				 load_dcard1 = 0;
				 load_dcard2 = 0;
				 load_dcard3 = 0;
				 player_win_light = 0;
				 dealer_win_light = 0;
			end
			
			DEAL_DCARD1: begin
				 load_pcard1 = 0;
				 load_pcard2 = 0;
				 load_pcard3 = 0;
				 load_dcard1 = 1;
				 load_dcard2 = 0;
				 load_dcard3 = 0;
				 player_win_light = 0;
				 dealer_win_light = 0; 
			end
			
			DEAL_PCARD2: begin
				 load_pcard1 = 0;
				 load_pcard2 = 1;
				 load_pcard3 = 0;
				 load_dcard1 = 0;
				 load_dcard2 = 0;
				 load_dcard3 = 0;
				 player_win_light = 0;
				 dealer_win_light = 0; 
			end
			
			DEAL_DCARD2: begin
				 load_pcard1 = 0;
				 load_pcard2 = 0;
				 load_pcard3 = 0;
				 load_dcard1 = 0;
				 load_dcard2 = 1;
				 load_dcard3 = 0;
				 player_win_light = 0;
				 dealer_win_light = 0; 
			end
			
			DEAL_PCARD3: begin
				 load_pcard1 = 0;
				 load_pcard2 = 0;
				 load_pcard3 = 1;
				 load_dcard1 = 0;
				 load_dcard2 = 0;
				 load_dcard3 = 0;
				 player_win_light = 0;
				 dealer_win_light = 0; 
			end
			
			DEAL_DCARD3: begin
				 load_pcard1 = 0;
				 load_pcard2 = 0;
				 load_pcard3 = 0;
				 load_dcard1 = 0;
				 load_dcard2 = 0;
				 load_dcard3 = 1;
				 player_win_light = 0;
				 dealer_win_light = 0; 
			end
			
			CHECK: begin
				 load_pcard1 = 0;
				 load_pcard2 = 0;
				 load_pcard3 = 0;
				 load_dcard1 = 0;
				 load_dcard2 = 0;
				 load_dcard3 = 0;
				 player_win_light = 0;
				 dealer_win_light = 0; 
			end
			
		
			DONE: begin
				 load_pcard1 = 0;
				 load_pcard2 = 0;
				 load_pcard3 = 0;
				 load_dcard1 = 0;
				 load_dcard2 = 0;
				 load_dcard3 = 0;
				 if (pscore > dscore) begin //player wins
					player_win_light = 1;
					dealer_win_light = 0; 
				end
				
				else if (dscore > pscore) begin //dealer wins
					player_win_light = 0;
					dealer_win_light = 1;
				end
				
				else begin //tie, boh win
					player_win_light = 1;
					dealer_win_light = 1;
				end
			end
				default: begin
				 load_pcard1 = 0;
				 load_pcard2 = 0;
				 load_pcard3 = 0;
				 load_dcard1 = 0;
				 load_dcard2 = 0;
				 load_dcard3 = 0;
				 player_win_light = 0;
				 dealer_win_light = 0; 
				end
			endcase
		end
		
endmodule
					
					
			
			
				
			
			
			
			
			
			
			
		
			 
				
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
	
	
	
	
	
	
	
	