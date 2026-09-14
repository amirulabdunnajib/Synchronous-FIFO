// Fixed size: 8 locations, 16-bit data width.
module fifo_core (
    input                       clk,
    input                       rst_n,
    input                       wr_en,
    input                       rd_en,
    input      [15:0]           din,
    input                       full,
    input                       empty,
    
    output reg [15:0]           dout,
    output reg [2:0]            wptr,
    output reg [2:0]            rptr
);

    // Memory is fixed to 8 locations of 16 bits each.
  reg [15:0] fifo[7:0];

    // Write logic: updates the write pointer and writes to memory
    always @(posedge clk) begin
      if (!rst_n) begin
            wptr <= 0;
        end else if (wr_en & !full) begin
            fifo[wptr] <= din;
            wptr <= wptr + 1;
        end
    end

    // Read logic: updates the read pointer and reads from memory
    always @(posedge clk) begin
      if (!rst_n) begin
            rptr <= 0;
        end else if (rd_en & !empty) begin
            dout <= fifo[rptr];
            rptr <= rptr + 1;
        end
    end

endmodule