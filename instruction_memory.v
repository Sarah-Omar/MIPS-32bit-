module instruction_memory (
input [31:0] address_in,  
input clk,reset,               
output reg [31:0] instruction 
);

reg [31:0] mem[0:1023];

initial begin
// R-type instructions (Arithmetic)
mem[0] = 32'b000000_01001_01010_01000_00000_100000; // add 
mem[1] = 32'b000000_01001_01010_01000_00000_100010; // sub 
mem[2] = 32'b000000_01001_01010_01000_00000_011000; // mul 
// R-type instructions (Logical)
mem[3] = 32'b000000_01001_01010_01000_00000_100100; // and 
mem[4] = 32'b000000_01001_01010_01000_00000_100101; // or 
mem[6] = 32'b000000_01001_01010_01000_00000_100111; // nor 
mem[7] = 32'b000000_01001_01010_01000_00000_101000; // nand 
// R-type instructions (Shift)
mem[8] = 32'b000000_00000_01001_01000_00000_000000; // (Shift Left Logical)
mem[9] = 32'b000000_00000_01001_01000_00000_000010; // (Shift Right Logical)
// R-type instructions (Set Conditions)
mem[10] = 32'b000000_01001_01010_01000_00000_101010; // slt (Set Less Than)
mem[11] = 32'b000000_01001_01010_01000_00000_101011; // seq (Set Equal)
mem[12] = 32'b000000_01001_01010_01000_00000_101100; // sne (Set Not Equal)
mem[13] = 32'b000000_01001_01010_01000_00000_101101; // sgt (Set Greater Than)
// I-type instructions
mem[14] = 32'b100011_01001_01000_0000000000000001; // lw
mem[15] = 32'b101011_01001_01000_0000000000000010; // sw 
mem[16] = 32'b000100_01001_01000_0000000000000010; // beq 


end
always @(posedge clk or posedge reset) begin
if (reset) begin
instruction <= 32'b0; 
end 
else begin
instruction = mem[address_in >> 2]; 
end
end
endmodule