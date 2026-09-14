// Block 2: Status Generation Logic (Full/Empty)
// Fixed for 3-bit pointers (depth of 8).
module fifo_status (
    input [2:0]                 wptr,
    input [2:0]                 rptr,
    output                      full,
    output                      empty
);

  assign full  = (wptr + 3'b1) == rptr;
  assign empty = wptr == rptr;

endmodule