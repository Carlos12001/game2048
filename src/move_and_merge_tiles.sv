module move_and_merge_tiles (
  input logic [3:0] direction,
  input logic [11:0] board_in[3:0][3:0],
  output logic [11:0] board_out[3:0][3:0],
  output logic [19:0] score_update,
  output logic done
);

  logic [11:0] local_board[3:0][3:0];
  logic [19:0] local_score_update;
  integer i, j, k;

  always @(*) begin
    local_board = board_in;
    local_score_update = 0;
    done = 1'b0;

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
        done = 1'b1;
      end

      4'b0010: begin // Bottom Move
        for (i = 0; i < 4; i++) begin
          // Compress
          k = 3;
          for (j = 3; j >= 0; j--) begin
            if (local_board[j][i] != 12'b0) begin
              local_board[k][i] = local_board[j][i];
              if (k != j) begin
                local_board[j][i] = 12'b0;
              end
              k = k - 1;
            end
          end

          // Merge
          for (j = 3; j > 0; j--) begin
            if (local_board[j][i] == local_board[j - 1][i]) begin
              local_board[j][i] = local_board[j][i] + local_board[j - 1][i];
              local_board[j - 1][i] = 12'b0;
              local_score_update = local_score_update + local_board[j][i];
            end
          end

          // Compress again after merging
          k = 3;
          for (j = 3; j >= 0; j--) begin
            if (local_board[j][i] != 12'b0) begin
              local_board[k][i] = local_board[j][i];
              if (k != j) begin
                local_board[j][i] = 12'b0;
              end
              k = k - 1;
            end
          end
        end
        done = 1'b1;
      end

      4'b0100: begin // Left Move
        for (i = 0; i < 4; i++) begin
          // Compress
          k = 0;
          for (j = 0; j < 4; j++) begin
            if (local_board[i][j] != 12'b0) begin
              local_board[i][k] = local_board[i][j];
              if (k != j) begin
                local_board[i][j] = 12'b0;
              end
              k = k + 1;
            end
          end

          // Merge
          for (j = 0; j < 3; j++) begin
            if (local_board[i][j] == local_board[i][j + 1]) begin
              local_board[i][j] = local_board[i][j] + local_board[i][j + 1];
              local_board[i][j + 1] = 12'b0;
              local_score_update = local_score_update + local_board[i][j];
            end
          end

          // Compress again after merging
          k = 0;
          for (j = 0; j < 4; j++) begin
            if (local_board[i][j] != 12'b0) begin
              local_board[i][k] = local_board[i][j];
              if (k != j) begin
                local_board[i][j] = 12'b0;
              end
              k = k + 1;
            end
          end
        end
        done = 1'b1;
      end

      4'b1000: begin // Right Move
        for (i = 0; i < 4; i++) begin
          // Compress
          k = 3;
          for (j = 3; j >= 0; j--) begin
            if (local_board[i][j] != 12'b0) begin
              local_board[i][k] = local_board[i][j];
              if (k != j) begin
                local_board[i][j] = 12'b0;
              end
              k = k - 1;
            end
          end

          // Merge
          for (j = 3; j > 0; j--) begin
            if (local_board[i][j] == local_board[i][j - 1]) begin
              local_board[i][j] = local_board[i][j] + local_board[i][j - 1];
              local_board[i][j - 1] = 12'b0;
              local_score_update = local_score_update + local_board[i][j];
            end
          end

          // Compress again after merging
          k = 3;
          for (j = 3; j >= 0; j--) begin
            if (local_board[i][j] != 12'b0) begin
              local_board[i][k] = local_board[i][j];
              if (k != j) begin
                local_board[i][j] = 12'b0;
              end
              k = k - 1;
            end
          end
        end
        done = 1'b1;
      end

      default: begin
        done = 1'b0;
      end
      
    endcase
  end

  assign score_update = local_score_update;
  assign board_out = local_board;

endmodule
