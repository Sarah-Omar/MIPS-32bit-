module Adder_SUB
(
 input A ,B,
 input Cin,
 output Sum ,c
);
assign Sum = A^B^Cin;
assign c = (A&B) | (B&Cin) |(A&Cin);
endmodule

module Adder_Subtractor
#(parameter N=32)
(
input [N-1:0]A,
input [N-1:0] B,
input cin,
output [N-1:0] s,
output cout,v
);
wire [31:0]B_c;
wire [N:0]cloop;
assign B_c=B^{N{cin}};
assign cloop[0]=cin;
genvar i;
generate 
for (i=0; i<N ; i=i+1 )  begin: adder_sub
Adder_SUB  add0(A[i],B_c[i],cin,s[i],cloop[i+1]);
end
endgenerate
assign cout=cloop[N];
assign v=cout^cloop[N-1];
endmodule

module comp
(
input A,B,
output g_t,eq,l_t
);
assign g_t= A&~B;
assign eq= (~A & ~B) | (A & B);
assign l_t = ~A & B;
endmodule

module Comparator 
#(parameter N=32)
(
 input [N-1:0] A,
 input [N-1:0] B,
 output g_t, eq, l_t
);
 wire [N-1:0] gt_wire, eq_wire, lt_wire; // Wires for partial comparisons
wire [N-1:0] eq_cumulative; // Cumulative equality check
 wire [N-1:0] gt_cumulative; // Cumulative greater-than check
 genvar i;

 generate
  for (i = 0; i < N; i = i + 1) begin: compara
comp com0(A[i], B[i], gt_wire[i], eq_wire[i], lt_wire[i]);
  end
 endgenerate

 // Cumulative logic for equality and greater-than
 assign eq_cumulative[0] = eq_wire[0];
 assign gt_cumulative[0] = gt_wire[0];

 generate
  for (i = 1; i < N; i = i + 1) begin: cumulative_logic
assign eq_cumulative[i] = eq_cumulative[i-1] & eq_wire[i];
assign gt_cumulative[i] = gt_cumulative[i-1] | (eq_cumulative[i-1] & gt_wire[i]);
  end
 endgenerate

 // 32-bit outputs
assign g_t = gt_cumulative[N-1]; // A > B
assign eq = eq_cumulative[N-1];  // A == B
assign l_t = ~(eq | g_t);        // A < B
endmodule





module ALU (
input [31:0] A, B,  
input [3:0] ALUControl, 
output reg [31:0] ALUResult,  
output Zero_Flag
);
wire [31:0]sum,sub;
wire cout_add, v_add;  
wire cout_sub, v_sub;
Adder_Subtractor add (.A(A),.B(B),.cin(1'b0),.s(sum),.cout(cout_add),.v(v_add));
Adder_Subtractor sub0 (.A(A),.B(B),.cin(1'b1),.s(sub),.cout(cout_sub),.v(v_sub));
Comparator compa(.A(A),.B(B));
always @(*) begin
 case (ALUControl)
// Arithmetic
4'b0010: ALUResult = A+B ;  // ADD 
4'b0110:  ALUResult = A-B;  // SUB
4'b0011: ALUResult = A * B;  // MUL

// Logoc
4'b0000: ALUResult = A & B;  // AND
4'b0001: ALUResult = A | B;  // OR
4'b1100: ALUResult = ~(A | B);  // NOR
4'b1101: ALUResult = ~(A & B);  // NAND

// Shift
4'b1000: ALUResult = B << A;  // SHL (Shift Left Logical)
4'b1001: ALUResult = B >> A;  // SHR (Shift Right Logical)

// Comparaison
4'b0111: ALUResult = (A < B) ? 32'd1 : 32'd0;
4'b1011: ALUResult = (A == B) ? 32'd1 : 32'd0;
4'b1100: ALUResult = (A != B) ? 32'd1 : 32'd0;
4'b1101: ALUResult = (A > B) ? 32'd1 : 32'd0;

default: ALUResult = 32'b0;
endcase
end

assign Zero_Flag = (ALUResult == 0) ? 1 : 0;  

endmodule
