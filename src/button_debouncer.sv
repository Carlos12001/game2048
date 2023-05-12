module button_debouncer (
  input logic clk,
  input logic reset,
  input logic button_in,
  output logic button_out
);

  typedef enum logic [1:0] {IDLE, PRESSED, WAIT_RELEASE} state_t;
  state_t current_state, next_state;
  logic button_out_next; // variable intermedia para button_out

  always_ff @(posedge clk or negedge reset) begin
    if (~reset) begin
      current_state <= IDLE;
      button_out <= 0; // asignar button_out en always_ff
    end else begin
      current_state <= next_state;
      button_out <= button_out_next; // utilizar button_out_next
    end
  end

  always @(*) begin
    case (current_state)
      IDLE: begin
        if (~button_in) begin // button is pressed
          next_state = PRESSED;
          button_out_next = 1; // actualizar button_out_next
        end else begin
          button_out_next = 0;
          next_state = IDLE;
        end
      end
      PRESSED: begin
        next_state = WAIT_RELEASE;
        button_out_next = 1; // actualizar button_out_next
      end
      WAIT_RELEASE: begin
        button_out_next = 0; // actualizar button_out_next
        if (button_in) begin // button is released
          next_state = IDLE;
        end else begin
          next_state = WAIT_RELEASE;
        end
      end
      default: begin
        next_state = IDLE;
        button_out_next = 0; // actualizar button_out_next
      end
    endcase
  end

endmodule