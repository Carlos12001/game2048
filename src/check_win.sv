module check_win (
	input logic [11:0]num_max_win,
	input logic [11:0] board_in[3:0][3:0],
	output logic result
);

  logic win;

  always_comb begin
    win = 1'b0;
    for (int i = 0; i < 4; i++) begin
      for (int j = 0; j < 4; j++) begin
        if (board_in[i][j] >= num_max_win) begin
          win = win|1'b1;
        end
      end
    end

    result = win;
  end

endmodule
