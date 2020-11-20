module ALUControl(input logic[1:0] ALUOp,
                  input logic[6:0] Funct7,
                  input logic[2:0] Funct3,
                  output logic[3:0] ALUCtl
);

  always_comb
    case (ALUOp)
        0: ALUCtl <= 2;
        1: ALUCtl <= 6;
        2: begin
            if (Funct7 == 0)begin
                case (Funct3)
                    0: ALUCtl <= 2;
                    6: ALUCtl <= 1;
                    7: ALUCtl <= 0;
					default: ALUCtl <= 2;
                endcase
            end
            else
                ALUCtl <= 6;
				end 
		default : ALUCtl <= 2;
    endcase
endmodule
