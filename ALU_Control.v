module ALU_Control (
input [5:0] funct,   
input [1:0] ALUOp,   
output reg [3:0] ALUControl
);

always @(*) begin
case (ALUOp)
2'b00: ALUControl = 4'b0010;  //ABB (LW, SW)
2'b01: ALUControl = 4'b0110;  //SUB(BEQ)
2'b10: begin // R-type 
case (funct)
//Arihmetic
6'b100000: ALUControl = 4'b0010; // ADD
6'b100010: ALUControl = 4'b0110; // SUB
6'b011000: ALUControl = 4'b0011; // MUL


//Logic 
6'b100100: ALUControl = 4'b0000; // AND
6'b100101: ALUControl = 4'b0001; // OR
6'b100111: ALUControl = 4'b1100; // NOR
6'b101000: ALUControl = 4'b1101; // NAND
 
//Shift
6'b000000: ALUControl = 4'b1000; // SHL (Shift Left )
6'b000010: ALUControl = 4'b1001; // SHR (Shift Right)

//(Set Conditions)
6'b101010: ALUControl = 4'b0111; // SLT (Set Less Than)
6'b101011: ALUControl = 4'b1011; // SEQ (Set Equal)
6'b101100: ALUControl = 4'b1100; // SNE (Set Not Equal)
6'b101101: ALUControl = 4'b1101; // SGT (Set Greater Than)

 
default: ALUControl = 4'b1111; // No Operation
endcase
end
2'b11: ALUControl = 4'b0111; // SLT 
default: ALUControl = 4'b1111; // No Operation
endcase
end

endmodule
