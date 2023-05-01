module top_module (
	input logic clk,
	input logic rst,
	input logic top,
	input logic bottom,
	input logic left,
	input logic right,
	output logic [3:0] game_state
);

	logic state, next_state;

	always_ff @(posedge clk or posedge rst) begin
		if (rst) state = 0;
		else state = next_state;
	end


	//next state logic
	always_comb begin
		case (state)
			1 : next_state = 1;
			default: next_state = 0;
		endcase

		if (state) game_state = {top, bottom, left, right};
		else game_state = 4'b0000;
	end
	

endmodule