module program_counter (
input clk,
input reset,
input [31:0] address_in,
output reg [31:0] address_out
);

always @(posedge clk or posedge reset )
begin 
if(reset)
address_out <= 32'b0; //reset pc to 0
else 
address_out <= address_in; //update pc to next abstraction
end 
endmodule