module onetotwo(in, out1, out2);
  input in;
  output out1, out2;
  wire i1, i2;
  assign i1 = !in;
  assign i2 = !in;
  assign out1 = !i1;
  assign out2 = !i2;
endmodule