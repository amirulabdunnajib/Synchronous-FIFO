module testbench(); reg clk = 0;
reg rst_n = 0;
reg wr_en = 0;
reg rd_en = 0;
reg [15:0] din = 0;
wire [15:0] dout;
wire full;
wire empty;
  
// --- Wires to mirror FIFO registers ---
 wire [15:0] fifo_0;
 wire [15:0] fifo_1;
 wire [15:0] fifo_2;
 wire [15:0] fifo_3;
 wire [15:0] fifo_4;
 wire [15:0] fifo_5;
 wire [15:0] fifo_6;
 wire [15:0] fifo_7;
  
// --- Loop variable ---
integer i;

always 
 #1 clk = ~clk;  
 
 top ai45( .clk(clk), .rst_n(rst_n), .wr_en(wr_en), .rd_en(rd_en), .din(din), .dout(dout), .full(full), .empty(empty)); 
  
 // --- Mirror wire assignments ---
 assign fifo_0 = ai45.blk1885_1.fifo[0];
 assign fifo_1 = ai45.blk1885_1.fifo[1];
 assign fifo_2 = ai45.blk1885_1.fifo[2];
 assign fifo_3 = ai45.blk1885_1.fifo[3];
 assign fifo_4 = ai45.blk1885_1.fifo[4];
 assign fifo_5 = ai45.blk1885_1.fifo[5];
 assign fifo_6 = ai45.blk1885_1.fifo[6];
 assign fifo_7 = ai45.blk1885_1.fifo[7];
  
initial begin
  // The monitor will print the state of the signals.
  $monitor("[%0t] wr=%b rd=%b din=%h | dout=%h full=%b empty=%b",
           $time, wr_en, rd_en, din, dout, full, empty);
  
  // Reset sequence: Keep reset active
  $display("\nPHASE 1: Resetting the FIFO.");
  #5
  rst_n <= 1;
  
  // Write sequence: Fill the FIFO
  #2
  $display("\nPHASE 2: Filling the FIFO.");
  wr_en <= 1;
  @(posedge clk);
  for (i = 0; i < 8; i = i+1) begin
    din <= 16'h1000 + i;
    @(posedge clk);
  end
  wr_en <= 0;
  
  // Read sequence: Empty the FIFO
  #2
  $display("\nPHASE 4: Emptying the FIFO.");
  rd_en <= 1;
  @(posedge clk);
  for ( i = 0; i < 8; i = i+1) begin
    @(posedge clk);
  end
  rd_en <= 0;
    
  #5 $finish; 
end 
  
initial begin     
    
    $dumpfile("testbench.vcd");    
    
    $dumpvars(0,testbench);

end 
endmodule 



