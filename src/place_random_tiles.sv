module place_random_tiles (
  input logic clk,
  input logic rst,
  input logic start,
  input logic [11:0] board_in[3:0][3:0],
  output logic [11:0] board_out[3:0][3:0],
  output logic done
);

  // LFSR para generar números pseudoaleatorios
  logic [3:0] lfsr;
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      lfsr <= 4'b0001;
    end else begin
      lfsr <= {lfsr[2:0], lfsr[3] ^ lfsr[2]};
    end
  end

  // Estados
  typedef enum logic [1:0] {IDLE, SEARCH, FINISH} state_t;
  state_t current_state, next_state;

  // Variables temporales
  logic [11:0] local_board[3:0][3:0];
  logic [1:0] row, col;
  logic done_reg;

  // Logica de estado
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      current_state <= IDLE;
      row <= 2'b0;
      col <= 2'b0;
      local_board <= board_in;
      done_reg <= 1'b0;
    end else begin
      current_state <= next_state;
      row <= lfsr[3:2];
      col <= lfsr[1:0];
      
      case (current_state)
        IDLE: begin
          if (start) begin
            done_reg <= 0;
            local_board <= board_in;
            next_state = SEARCH;
          end else begin
            next_state = IDLE;
          end
        end

        SEARCH: begin
          if (board_in[row][col] == 0) begin
            local_board[row][col] = 12'h002;
            next_state = FINISH;
          end else begin
            next_state = SEARCH;
          end
        end

        FINISH: begin
          done_reg <= 1;
          next_state = IDLE;
        end

        default: begin
          next_state = IDLE;
        end
      endcase
    end
  end

  assign board_out = local_board;
  assign done = done_reg;

endmodule
