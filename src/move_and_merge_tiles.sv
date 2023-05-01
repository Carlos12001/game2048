module move_and_merge_tiles (
  input logic [3:0] direction,
  input logic [11:0] board_in[3:0][3:0],
  output logic [11:0] board_out[3:0][3:0],
  output logic [19:0] score_update
);

  logic [11:0] local_board[3:0][3:0];
  logic [19:0] local_score_update;
  integer i, j, k;

  always_comb begin
    local_board = board_in;
    local_score_update = 0;

    case (direction)
      4'b0001: begin // Top Move
        for (i = 0; i < 4; i++) begin
          // Compress
          k = 0;
          for (j = 0; j < 4; j++) begin
            if (local_board[j][i] != 12'b0) begin
              local_board[k][i] = local_board[j][i];
              if (k != j) begin
                local_board[j][i] = 12'b0;
              end
              k = k + 1;
            end
          end

          // Merge
          for (j = 0; j < 3; j++) begin
            if (local_board[j][i] == local_board[j + 1][i]) begin
              local_board[j][i] = local_board[j][i] + local_board[j + 1][i];
              local_board[j + 1][i] = 12'b0;
              local_score_update = local_score_update + local_board[j][i];
            end
          end

          // Compress again after merging
          k = 0;
          for (j = 0; j < 4; j++) begin
            if (local_board[j][i] != 12'b0) begin
              local_board[k][i] = local_board[j][i];
              if (k != j) begin
                local_board[j][i] = 12'b0;
              end
              k = k + 1;
            end
          end
        end
      end

      4'b0010: begin // Bottom Move
      end

      4'b0100: begin // Left Move
      end

      4'b1000: begin // Right Move
      end
      default: begin
      end
    endcase
  end

  assign score_update = local_score_update;
  assign board_out = local_board;

endmodule
