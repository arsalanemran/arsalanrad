module RISCVALU(input  logic [3:0]  ALUControl,
           input  logic [63:0] A, B,
           output logic [63:0] Y,
           output logic zero);

  always_comb
    casex (ALUControl)
      0: Y = A & B;
      1: Y = A | B;
      2: Y = A + B;
      6: Y = A - B;
      7: Y = A<B ? 1 : 0;
      12: Y = ~(A | B);
      default: Y = 0;
    endcase

  assign zero = (Y == 0) ? 1'b1 : 1'b0;

endmodule
