module testbench();
logic clk;
logic reset, Zero, IorD;
logic [63:0] DataAdr;
logic [63:0] MemOut, PC, ALUOut, IR, MDR , ALUResultOut, A, B , RS1, RS2,ALUAin, ALUBin;
logic [3:0]  stateNum;
integer cycle;
RISCVCPU riscv(clk, reset, DataAdr, MemOut, PC, PCWrite, PCWriteCond,
ALUCtl, Zero, tempE, PCWriteE, MDR, ALUOut, IR,
PCWriteCond, PCWrite, IorD, MemRead, MemWrite,
MemtoReg, IRWrite, PCSource, ALUOp, ALUSrcB, ALUSrcA, RegWrite, RegDst, stateNum, ALUResultOut, A, B, RS1, RS2, ALUAin, ALUBin);
    initial
    begin
    reset <= 1; # 22; reset <= 0;
    end
    // generate clock to sequence tests
    always
    begin
    clk <= 1; # 20; clk <= 0; # 20;
    end

endmodule 