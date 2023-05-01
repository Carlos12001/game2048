module move_and_merge_tiles (
  input logic [3:0] direction, 
  input logic [11:0] board_in[0:15],
  output logic [11:0] board_out[0:15],
  output logic [19:0] score_update
);

  logic [11:0] temp_column[0:3];
  logic [1:0] i, j, k;
  logic [19:0] local_score_update;

  always_comb begin
    local_score_update = 0;
    for (int idx = 0; idx < 16; idx++) begin
      board_out[idx] = board_in[idx];
    end
    
    case (direction)
      4'b0001: begin // Top Move
        for (i = 0; i < 4; i++) begin
          // Compress column
          j = 0;
          for (k = 0; k < 4; k++) begin
            if (board_in[4 * k + i] != 0) begin
              temp_column[j] = board_in[4 * k + i];
              j = j + 1;
            end
          end
          for (j=j; j < 4; j++) begin
            temp_column[j] = 0;
          end

          // Merge column
          for (j = 0; j < 3; j++) begin
            if (temp_column[j] == temp_column[j+1] && temp_column[j] != 0) begin
              temp_column[j] = temp_column[j] + temp_column[j+1];
              local_score_update = local_score_update + temp_column[j];
              temp_column[j+1] = 0;
            end
          end

          // Compress column again
          j = 0;
          for (k = 0; k < 4; k++) begin
            if (temp_column[k] != 0) begin
              board_out[4 * j + i] = temp_column[k];
              j = j + 1;
            end
          end
          for (j=j; j < 4; j++) begin
            board_out[4 * j + i] = 0;
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

endmodule
