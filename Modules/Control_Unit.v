module ControlUnit(CLK, OpCode, RegDst, Jump, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite, JAL);

input [4:0] OpCode;
input CLK;
output reg RegDst, Jump, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, JAL;
output reg [1:0] ALUOp;

always@(posedge CLK)
begin

case (OpCode)
	6'b000000:
		begin
			 RegDst<=1; ALUSrc<=0; MemtoReg<=0; RegWrite<=1; MemRead<=0; MemWrite<=0; Branch<=0; ALUOp<=2'b10; Jump<=0; JAL<=0; //r-type
		end
	6'b 100011: 
		begin
			RegDst<=0; ALUSrc<=1; MemtoReg<=1; RegWrite<=1; MemRead<=1; MemWrite<=0; Branch<=0; ALUOp<=2'b00; Jump<=0; JAL<=0; //lw
		end
	6'b 101011: 
		begin
			ALUSrc<=1; RegWrite<=0; MemRead<=0; MemWrite<=1; Branch<=0; ALUOp<=2'b00; Jump<=0; //sw
		end
	6'b 000100: 
		begin	
			ALUSrc<=0; RegWrite<=0; MemRead<=0; MemWrite<=0; Branch<=1; ALUOp<=2'b01; Jump<=0; //beq
		end
	6'b 000010: 
		begin
			RegWrite<=0; MemRead<=0; MemWrite<=0; Branch<=0; Jump<=1; //j
		end
	6'b 000011: 
		begin	
			RegWrite<=0; MemRead<=0; MemWrite<=0; Branch<=0; Jump<=1; JAL<=1; //jal
		end	
endcase 
end 

endmodule


module tb_ControlUnit();

//Inputs
reg [4:0] OpCode;
reg CLK;
//Outputs
wire RegDst, Jump, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, JAL;
wire [1:0] ALUOp;

always
begin
	#5
	CLK = ~CLK;
end

initial
begin

CLK = 0;

$display("Time   .  OpCode   .   RegDst   .  ALUSrc   .   MemtoReg   .   RegWrite   .   MemRead   .   MemWrite   .   Branch   .   ALUOp   .   Jump   .   JAL   ");
$monitor("%d   .   %d   .   %d   .    %d   .	%d   .	%d   .	%d   .	%d   .	%b   .	%d   .	%d", $time, OpCode, RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp, Jump, JAL);

#4
OpCode = 6'b000000;

#10
OpCode = 6'b100011;

#10
OpCode = 6'b101011;

#10
OpCode = 6'b101011;

#10
OpCode = 6'b000100;

#10
OpCode = 6'b000010;

#10
OpCode = 6'b000011;
end

ControlUnit test(CLK, OpCode, RegDst, Jump, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite, JAL);

endmodule 