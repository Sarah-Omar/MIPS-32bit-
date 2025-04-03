module Control_Unit (
 input [5:0] opcode,  // last 6 bit
 output reg RegDst,         
 output reg ALUSrc,         
 output reg MemtoReg,       
 output reg RegWrite,      
 output reg MemRead,        
 output reg MemWrite,     
 output reg Branch,        
 output reg Jump,          
 output reg [1:0] ALUOp    
);
always @(*) begin
 RegDst   = 1'b0;
 ALUSrc   = 1'b0;
 MemtoReg = 1'b0;
 RegWrite = 1'b0;
 MemRead  = 1'b0;
 MemWrite = 1'b0;
 Branch   = 1'b0;
 Jump     = 1'b0;
 ALUOp    = 2'b00;

case (opcode)
6'b000000: begin // R-type use ALU (ADD, SUB, AND, OR,......)
RegDst   = 1'b1; // to select rd before register file 
ALUSrc   = 1'b0;  //come from D2 (rt)
MemtoReg = 1'b0;     
RegWrite = 1'b1;   
MemRead  = 1'b0;     
MemWrite = 1'b0;     
Branch   = 1'b0;      
Jump     = 1'b0;     
ALUOp    = 2'b10;  //ALUop1 =0,ALUop1 =1
  end

6'b100011: begin // I-type LW 
RegDst   = 1'b0;     
ALUSrc   = 1'b1;   // come from immediate  
MemtoReg = 1'b1;      
RegWrite = 1'b1;    
MemRead  = 1'b1;      
MemWrite = 1'b0;     
Branch   = 1'b0;     
Jump     = 1'b0;      
ALUOp    = 2'b00;  
end
6'b101011: begin // I-type SW 
RegDst   = 1'b0; 
ALUSrc   = 1'b1;     
RegWrite = 1'b1;
MemtoReg = 1'b0;     
MemRead  = 1'b0;     
MemWrite = 1'b1;     
Branch   = 1'b0;     
Jump     = 1'b0;    
ALUOp    = 2'b00;  
end
  6'b000100: begin // beq (branch if equal)
RegDst   = 1'b0;
ALUSrc   = 1'b0;     
RegWrite = 1'b1; 
MemtoReg = 1'b0;  
MemRead  = 1'b0;      
MemWrite = 1'b0;
Branch   = 1'b1;      
Jump     = 1'b0;     
ALUOp    = 2'b01;  
 end

default: begin 
RegDst   = 1'b0;
ALUSrc   = 1'b0;
MemtoReg = 1'b0;
RegWrite = 1'b0;
MemRead  = 1'b0;
MemWrite = 1'b0;
Branch   = 1'b0;
Jump     = 1'b0;
ALUOp    = 2'b00;
  end
 endcase
end
endmodule
