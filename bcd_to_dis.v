module bcd_to_dis (
    input [3:0]in,
    output reg [0:6] disp
);

always @(*)
begin
    case (in)
        4'd0: disp=7'b 0000001;        
        4'd1: disp=7'b 1001111;        
        4'd2: disp=7'b 0010010;        
        4'd3: disp=7'b 0000110;        
        4'd4: disp=7'b 1001100;        
        4'd5: disp=7'b 0100100;        
        4'd6: disp=7'b 0100000;        
        4'd7: disp=7'b 0001111;        
        4'd8: disp=7'b 0000000;        
        4'd9: disp=7'b 0000100;              
        default: disp=7'b 1111111;
    endcase
end
    
endmodule
