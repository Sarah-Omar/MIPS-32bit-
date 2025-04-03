module Register_File (
input clk, reset, we,
input [4:0] read_reg1, read_reg2, write_reg,
input [31:0] write_data,
output reg [31:0] read_data1, read_data2
);


reg [31:0] regfile [0:31];
 
initial begin
regfile[0] = 32'd5;
regfile[8] = 32'd0;  
regfile[9] = 32'd5;  
regfile[10] = 32'd3; 
end

  integer i;

always @(posedge clk or posedge reset) begin
 if (reset) begin
  for (i = 0; i < 32; i = i + 1) begin
regfile[i] <= 32'd0; 
  end
 end else if (we && write_reg != 0) begin
  regfile[write_reg] <= write_data; 
 end
end

always @(*) begin
 read_data1 = regfile[read_reg1];
 read_data2 = regfile[read_reg2];
end

endmodule
