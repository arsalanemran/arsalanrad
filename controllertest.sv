module testbench();
logic clk;
logic reset;
// logic [31:0] WriteData, DataAdr;
logic [6:0] opcode;
// logic MemWrite;
integer cycle;

logic [1:0] ALUOp, ALUSrcB, PCSource;
logic PCWriteCond, PCWrite, lorD, MemRead, MemWrite, MemtoReg, IRWrite,
ALUSrcA, RegWrite, RegDst;

logic [15:0] ControlWord;

// instantiate device to be tested
// exerciseSix dut(clk, reset, WriteData, DataAdr, MemWrite);
Controller controller (clk, reset, opcode, PCWriteCond, PCWrite, lorD, MemRead, MemWrite,
MemtoReg, IRWrite, PCSource, ALUOp, ALUSrcB, ALUSrcA, RegWrite, RegDst);
// initialize test
initial
// begin
// reset <= 1; # 22; reset <= 0;
// end
// generate clock to sequence tests
// always
// begin
// clk <= 1; # 5; clk <= 0; # 5;
// end
// check that 7 (2 after adding BIC) gets written to address 0x64
// at end of program

begin
   clk = 0;
   reset = 1;
   #5 ;
   reset = 0;
	$display("================ R-TYPE INSTRUCTIONS ===================");
   //R-Type Instructions test
   opcode = 7'b0110011; 
   for(cycle = 1; cycle <= 4; cycle = cycle + 1)
        begin
            clk = 1; 
            #5 ;
            clk = 0;
            ControlWord = {PCWrite, PCWriteCond, lorD, MemRead, MemWrite,
				IRWrite, MemtoReg, PCSource, ALUOp, ALUSrcB, ALUSrcA, RegWrite, RegDst};
            // Fetch State
            if (cycle == 1)
                begin
                    if (ControlWord == 16'b1001010000001000)
                        $display("Successful: State = ", controller.currentState, " opcode = ", opcode, ", ControlWord = %h ", ControlWord);
                    else
                        $display("Faild %h" , ControlWord );
                end
            //Decode State
            if (cycle == 2)
                begin
                    if (ControlWord == 16'b0000000000011000)
                        $display("Successful: State = ", controller.currentState, " opcode = ", opcode, ", ControlWord = %h ", ControlWord);
                    else
                        $display("Faild %h" , ControlWord );
                end
            //Execution State
            if (cycle == 3)
                begin
                    if (ControlWord == 16'b0000000001000100)
                        $display("Successful: State = ", controller.currentState, " opcode = ", opcode, ", ControlWord = %h ", ControlWord);
                    else
                        $display("Faild %h" , ControlWord );
                end
            //R-Type State
            if (cycle == 4)
                begin
                    if (ControlWord == 16'b0000000000000011)
                        $display("Successful: State = ", controller.currentState, " opcode = ", opcode, ", ControlWord = %h ", ControlWord);
                    else
                       $display("Faild %h" , ControlWord );
                end
					 
				#5; 	 
        end
	$display("================ LOAD INSTRUCTION ===================");
   clk = 0;
   reset = 1;
   #5 ;
   reset = 0;

   opcode = 3; 
   for(cycle = 1; cycle <= 5; cycle = cycle + 1)
        begin
            clk = 1; 
            #5 ;
            clk = 0;
            ControlWord = {PCWrite, PCWriteCond, lorD, MemRead, MemWrite,
				IRWrite, MemtoReg, PCSource, ALUOp, ALUSrcB, ALUSrcA, RegWrite, RegDst};
            // Fetch State
            if (cycle == 1)
                begin
                    if (ControlWord == 16'b1001010000001000)
                        $display("Successful: State = ", controller.currentState, " opcode = ", opcode, ", ControlWord = %h ", ControlWord);
                    else
                        $display("Faild %b" , ControlWord );
                end
            //Decode State
            if (cycle == 2)
                begin
                    if (ControlWord == 16'b0000000000011000)
                        $display("Successful: State = ", controller.currentState, " opcode = ", opcode, ", ControlWord = %h ", ControlWord);
                    else
                        $display("Faild %b" , ControlWord );
                end
            //MemAdr State
            if (cycle == 3)
                begin
                    if (ControlWord == 16'b0000000000010100)
                        $display("Successful: State = ", controller.currentState, " opcode = ", opcode, ", ControlWord = %h ", ControlWord);
                    else
                        $display("Faild %b" , ControlWord );
                end
            //Mem_Read State
            if (cycle == 4)
                begin
                    if (ControlWord == 16'b0011000000000000)
                        $display("Successful: State = ", controller.currentState, " opcode = ", opcode, ", ControlWord = %h ", ControlWord);
                    else
                       $display("Faild %b" , ControlWord );
                end
            //MemWB State
            if (cycle == 5)
                begin
                    if (ControlWord == 16'b0000001000000010)
                        $display("Successful: State = ", controller.currentState, " opcode = ", opcode, ", ControlWord = %h ", ControlWord);
                    else
                       $display("Faild %b" , ControlWord );
                end
				#5; 	 
        end
		  
$display("================ STORE INSTRUCTION ===================");
   
	clk = 0;
   reset = 1;
   #5 ;
   reset = 0;

   opcode = 35; 
   for(cycle = 1; cycle <= 4; cycle = cycle + 1)
        begin
            clk = 1; 
            #5 ;
            clk = 0;
            ControlWord = {PCWrite, PCWriteCond, lorD, MemRead, MemWrite,
				IRWrite, MemtoReg, PCSource, ALUOp, ALUSrcB, ALUSrcA, RegWrite, RegDst};
            // Fetch State
            if (cycle == 1)
                begin
                    if (ControlWord == 16'b1001010000001000)
                        $display("Successful: State = ", controller.currentState, " opcode = ", opcode, ", ControlWord = %h ", ControlWord);
                    else
                        $display("Faild %b" , ControlWord );
                end
            //Decode State
            if (cycle == 2)
                begin
                    if (ControlWord == 16'b0000000000011000)
                        $display("Successful: State = ", controller.currentState, " opcode = ", opcode, ", ControlWord = %h ", ControlWord);
                    else
                        $display("Faild %b" , ControlWord );
                end
            //MemAdr State
            if (cycle == 3)
                begin
                    if (ControlWord == 16'b0000000000010100)
                        $display("Successful: State = ", controller.currentState, " opcode = ", opcode, ", ControlWord = %h ", ControlWord);
                    else
                        $display("Faild %b" , ControlWord );
                end
            //Mem_Write State
            if (cycle == 4)
                begin
                    if (ControlWord == 16'b0010100000000000)
                        $display("Successful: State = ", controller.currentState, " opcode = ", opcode, ", ControlWord = %h ", ControlWord);
                    else
                       $display("Faild %b" , ControlWord );
                end

				#5; 	 
        end
$display("================ Branch INSTRUCTION ===================");
   clk = 0;
   reset = 1;
   #5 ;
   reset = 0;

   opcode = 99; 
   for(cycle = 1; cycle <= 3; cycle = cycle + 1)
        begin
            clk = 1; 
            #5 ;
            clk = 0;
            ControlWord = {PCWrite, PCWriteCond, lorD, MemRead, MemWrite,
				IRWrite, MemtoReg, PCSource, ALUOp, ALUSrcB, ALUSrcA, RegWrite, RegDst};
            // Fetch State
            if (cycle == 1)
                begin
                    if (ControlWord == 16'b1001010000001000)
                        $display("Successful: State = ", controller.currentState, " opcode = ", opcode, ", ControlWord = %h ", ControlWord);
                    else
                        $display("Faild %b" , ControlWord );
                end
            //Decode State
            if (cycle == 2)
                begin
                    if (ControlWord == 16'b0000000000011000)
                        $display("Successful: State = ", controller.currentState, " opcode = ", opcode, ", ControlWord = %h ", ControlWord);
                    else
                        $display("Faild %b" , ControlWord );
                end
            //Branch State
            if (cycle == 3)
                begin
                    if (ControlWord == 16'b0100000010100100)
                        $display("Successful: State = ", controller.currentState, " opcode = ", opcode, ", ControlWord = %h ", ControlWord);
                    else
                        $display("Faild %b" , ControlWord );
                end

				#5; 	 
        end

end




// always @(negedge clk)
// begin
//     if(MemWrite) begin
//         if(DataAdr === 100 & WriteData === 2) begin
//         $display("Simulation succeeded");
//         $stop;
//         end else if (DataAdr !== 96) begin
//         $display("Simulation failed %d",WriteData);
//         $stop;
//         end
//     end
// end
endmodule