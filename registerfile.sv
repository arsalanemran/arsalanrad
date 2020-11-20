module registerfile 
(input logic [4:0] ra1, ra2, wa3,
input logic [63:0] Writedata,
input logic RegWrite,
output logic [63:0] A, B,
input logic clk, reset);

logic [63:0] rf[31:0];
// three ported register file
// read two ports combinationally
// write third port on rising edge of clock
// register 15 reads PC + 8 instead

// initial begin //load in data and instructions of program // in bayad kamel she hanuz
//  rf[0] <= 64'd0;
//  rf[1] <= 64'd32;
//  rf[8] <= 64'd8;
// end

    always_ff @(posedge clk)
    begin
        if(reset)begin
            
            rf[0] <= 64'b0;  
            rf[1] <= 64'd32 ;
            rf[8] <= 64'd8;
        end
        if (RegWrite) rf[wa3] <= Writedata ;
    end
    
    assign A = rf[ra1] ; 
    assign B = rf[ra2] ; 

endmodule