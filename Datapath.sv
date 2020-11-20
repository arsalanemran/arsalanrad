module Datapath (ALUOp, MemtoReg, MemRead, MemWrite, IorD, RegWrite,
IRWrite,
PCWrite, PCWriteCond, ALUSrcA, ALUSrcB, PCSource,
opcode, clock, RegDst, MemOut, DataAdr, B, reset, PC,
ALUCtl, Zero, tempE, PCWriteE, MDR, ALUOut, IR, ALUResultOut, A, B, RS1, RS2, ALUAin, ALUBin); // the control inputs + clock // ALUResultOut, A

input logic [1:0] ALUOp, ALUSrcB; // 2-bit control signals

input logic MemtoReg, MemRead, MemWrite, IorD, RegWrite, IRWrite, PCWrite,
PCWriteCond,ALUSrcA, PCSource, clock, RegDst, reset; // 1-bit control signals

// input logic [63:0] MemOut;
output logic [6:0] opcode; // opcode is needed as an output by control
output logic [63:0] DataAdr;
output logic [63:0] B, PC,MemOut, ALUResultOut, A,ALUAin, ALUBin;

output logic [63:0] MDR, ALUOut; // CPU state + some temporaries

output logic [63:0] IR, RS1, RS2; // CPU state + some temporaries

logic [63:0] SignExtendOffset, PCOffset, PCValue, JumpAddr,  // B inja bude 
Writedata, bt, PC_Temp; //MemOut; // these are signals derived from registers

output logic [3:0] ALUCtl; // the ALU control lines
output logic Zero, tempE, PCWriteE; // the Zero out signal from the ALU

// initial PC = 64'd80; //start the PC at 0
// Combinational signals used in the datapath
// Read using word address with either ALUOut or PC as the address source

//initial DataAdr = 64'd80;

assign tempE = Zero & PCWriteCond;
assign PCWriteE = tempE | PCWrite; 




// assign DataAdr = PC;

PCreg #(64) PC_FF(clock, reset, PCWriteE, PCValue, PC);
 // assign PC_Temp = PC;
 //assign DataAdr = IorD ? ALUOut : PC ; 
 Mult2to1 memMux(PC, ALUOut, IorD, DataAdr);
flopr #(64) MDR_FF(clock, reset, MemOut, MDR);
// Save the ALU result for use on a later clock cycle
flopr #(64) ALUOut_FF(clock, reset, ALUResultOut, ALUOut);
// flopr #(64) branchTargetFF (clock , reset ,ALUBin , bt);
// Saves RS1 for use on a later clock cycle
flopr #(64) B_FF(clock, reset, RS2, B);
// Saves RS2 for use on a later clock cycle
// flopr #(64) A_FF(clock, reset, RS1, A);



// assign MemOut = MemRead ? Memory[(IorD ? ALUOut : PC) >> 2] : 0;

assign opcode = IR[6:0]; // opcode shortcut

assign Writedata = MemtoReg ? MDR : ALUOut;
// Get the write register data either from the ALUOut or from the MDR

// Generate immediate
assign ImmGen = (opcode == 7'b0000011) ? {{53{IR[31]}}, IR[30:20]} : /* (opcode == SD) */ {{53{IR[31]}}, IR[30:25], IR[11:7]};

// Generate pc offset for branches
assign PCOffset = {{52{IR[31]}}, IR[7], IR[30:25], IR[11:8], 1'b0};

// The A input to the ALU is either the rs register or the PC
assign ALUAin = ALUSrcA ? A : PC; // ALU input is PC or A
// Mult2to1 aluMux(A, PC, ALUSrcA, ALUAin);

flopenr IR_FF(clock, reset, IRWrite, MemOut, IR);



// Creates an instance of the ALU control unit (see the module defined in Figure B.5.16
// Input ALUOp is control-unit set and used to describe the instruction class as in Chapter 4
// Input IR[31:25] is the function code field for an ALU instruction
// Output ALUCtl are the actual ALU control bits as in Chapter 4

ALUControl alucontroller (ALUOp, IR[31:25],IR[14:12], ALUCtl); // ALU control unit


// Creates a 2-to-1 multiplexor used to select the source of the next PC
// Inputs are ALUResultOut (the incremented PC), ALUOut (the branch address)
// PCSource is the selector input and PCValue is the multiplexor output
Mult2to1 PCdatasrc (ALUResultOut, ALUOut, PCSource, PCValue); // aluout was instead of bt


// Creates a 4-to-1 multiplexor used to select the B input of the ALU
// Inputs are register B, constant 4, generated immediate, PC offset
// ALUSrcB is the select or input
// ALUBin is the multiplexor output
Mult4to1 ALUBinput (B, 64'd8, ImmGen, PCOffset, ALUSrcB, ALUBin);



// Creates a RISC-V ALU
// Inputs are ALUCtl (the ALU control), ALU value inputs (ALUAin, ALUBin)
// Outputs are ALUResultOut (the 64-bit output) and Zero (zero detection output)
RISCVALU ALU (ALUCtl, ALUAin, ALUBin, ALUResultOut, Zero); // the ALU




// Creates a RISC-V register file
// Inputs are the rs1 and rs2 fields of the IR used to specify which registers to read,
// Writereg (the write register number), Writedata (the data to be written),
// RegWrite (indicates a write), the clock
// Outputs are A and B, the registers read
registerfile regs (IR[19:15], IR[24:20], IR[11:7], Writedata, RegWrite, A, RS2, clock, reset); // Register file
// assign RS1 = A;

DataMemory dataMemory(clk, MemWrite, MemRead, DataAdr, B ,ALUOut, MemOut);

// The clock-triggered actions of the datapath
// always @(posedge clock)
// begin
// // if (MemWrite) Memory[ALUOut >> 2] <= B; // Write memory--must be a store
// // ALUOut <= ALUResultOut; // Save the ALU result for use on a later clock cycle
// if (IRWrite) IR <= MemOut; // Write the IR if an instruction fetch
// // MDR <= MemOut; // Always save the memory read value
// // The PC is written both conditionally (controlled by PCWrite) and unconditionally
// // if (PCWriteE) PC <= PCValue;
// end

endmodule