module Data_Memory (
 input  clk, MemWrite, MemRead, reset,
 input  [31:0] address,
 input  [31:0] data_in,
 output reg [31:0] read_data
);

reg [31:0] mem [0:1023];
wire [9:0] mem_address = address[11:2]; // † word-aligned

integer i;
initial begin
 for (i = 0; i < 1024; i = i + 1) begin
  mem[i] = 32'b0;
 end
 mem[0] = 32'd10; 
end

always @(posedge clk or posedge reset) begin
 if (reset) begin
  read_data <= 32'b0; 
 end else if (MemWrite) begin
  mem[mem_address] <= data_in;
 end
end

always @(*) begin
 if (MemRead) begin
  read_data = mem[mem_address];
 end
end

endmodule
