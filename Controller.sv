module Controller(clk, reset, Op, PCWriteCond, PCWrite, IorD, MemRead, MemWrite,
MemtoReg, IRWrite, PCSource, ALUOp, ALUSrcB, ALUSrcA, RegWrite, RegDst, stateNum);

input [6:0] Op;
input clk, reset;
output logic [1:0] ALUOp, ALUSrcB, PCSource;
output logic  PCWriteCond, PCWrite, IorD, MemRead, MemWrite, MemtoReg, IRWrite,
ALUSrcA, RegWrite, RegDst;
output logic [3:0] stateNum;
// logic [1:0] ALUOp, ALUSrcB, PCSource;
// logic PCWriteCond, PCWrite, IorD, MemRead, MemWrite, MemtoReg, IRWrite,
// ALUSrcA, RegWrite, RegDst;
 
typedef enum logic[3:0] {Fetch, Decode, MemAdr, Mem_Read, MemWB, Mem_Write, Execute, RType, Branch, Jump} State;

State currentState, nextState;

always_ff @(posedge clk)
    if (reset) currentState <=  Fetch;
    else currentState <=  nextState;


always_comb
begin
    case(currentState)

        Fetch: begin
            {PCWrite, PCWriteCond, IorD, MemRead, MemWrite,
            IRWrite, MemtoReg, PCSource, ALUOp, ALUSrcB, ALUSrcA, RegWrite, RegDst} = 16'b1001010000001000;
            nextState = Decode;
            stateNum = 4'd0;
        end

        Decode: begin
            {PCWrite, PCWriteCond, IorD, MemRead, MemWrite,
            IRWrite, MemtoReg, PCSource, ALUOp, ALUSrcB, ALUSrcA, RegWrite, RegDst} = 16'b0000000000011000;
            stateNum = 4'd1;
            // ld and sd is not handled yet ld = 3 , sd = 35
            
            if(Op == 3) begin //if op code is ld 
			nextState = MemAdr;
            end

            else if(Op == 35) begin //if op code is sd
            nextState = MemAdr;
            end

            else if(Op == 51) begin // if R type instruction //0110011
				nextState = Execute;
            end
			else
				nextState = Branch;
            
            
        end

        MemAdr: begin
            {PCWrite, PCWriteCond, IorD, MemRead, MemWrite,
            IRWrite, MemtoReg, PCSource, ALUOp, ALUSrcB, ALUSrcA, RegWrite, RegDst} = 16'b0000000000010100;
            
            stateNum = 4'd2;
            if(Op == 3) begin //if ld
                nextState = Mem_Read;
            end

            // if(Op == 35) begin // if SW instruction
            //     nextState = Mem_Write;
            // end
		    else
			    nextState = Mem_Write;

        end

        Mem_Read: begin
            {PCWrite, PCWriteCond, IorD, MemRead, MemWrite,
            IRWrite, MemtoReg, PCSource, ALUOp, ALUSrcB, ALUSrcA, RegWrite, RegDst} = 16'b0011000000000000;
            nextState = MemWB;
            stateNum = 4'd3;
        end

        MemWB: begin
            {PCWrite, PCWriteCond, IorD, MemRead, MemWrite,
            IRWrite, MemtoReg, PCSource, ALUOp, ALUSrcB, ALUSrcA, RegWrite, RegDst} = 16'b0000001000000010;
            nextState = Fetch;
            stateNum = 4'd4;
        end

        Mem_Write: begin
            {PCWrite, PCWriteCond, IorD, MemRead, MemWrite,
            IRWrite, MemtoReg, PCSource, ALUOp, ALUSrcB, ALUSrcA, RegWrite, RegDst} = 16'b0010100000000000;
            nextState = Fetch;
            stateNum = 4'd5;
        end

        Execute: begin
            {PCWrite, PCWriteCond, IorD, MemRead, MemWrite,
            IRWrite, MemtoReg, PCSource, ALUOp, ALUSrcB, ALUSrcA, RegWrite, RegDst} = 16'b0000000001000100;
            nextState  =  RType;
            stateNum = 4'd6;
        end

        RType: begin
            {PCWrite, PCWriteCond, IorD, MemRead, MemWrite,
            IRWrite, MemtoReg, PCSource, ALUOp, ALUSrcB, ALUSrcA, RegWrite, RegDst} = 16'b0000000000000011;
                        
            nextState =  Fetch;
            stateNum = 4'd7;
        end

        Branch: begin
            {PCWrite, PCWriteCond, IorD, MemRead, MemWrite,
            IRWrite, MemtoReg, PCSource, ALUOp, ALUSrcB, ALUSrcA, RegWrite, RegDst} = 16'b0100000010100100;            
            nextState =  Fetch;
            stateNum = 4'd8;
        end

        Jump: begin
            {PCWrite, PCWriteCond, IorD, MemRead, MemWrite,
            IRWrite, MemtoReg, PCSource, ALUOp, ALUSrcB, ALUSrcA, RegWrite, RegDst} = 16'b1000000100000000;   
            nextState =  Fetch;
            stateNum = 4'd9;
        end

        default: begin
            nextState = Fetch;
            {PCWrite, PCWriteCond, IorD, MemRead, MemWrite,
            IRWrite, MemtoReg, PCSource, ALUOp, ALUSrcB, ALUSrcA, RegWrite, RegDst} = 16'b1001010000001000;
            stateNum = 4'd0;
        end
        

    endcase
end
endmodule