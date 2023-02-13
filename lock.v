
/* -------------------------------------------------------------------------- */
/*                                 Main module                                */
/* -------------------------------------------------------------------------- */
module lock(
    digit_1,digit_2,digit_3,digit_4,
    start,
    reset,
    clk,
    out,
    buzzer,
    count,
    cp,
    ci
);

    input digit_1,digit_2,digit_3,digit_4;
    input reset,clk,start;
    output out,buzzer;
	 reg count2;
	 initial
	 begin
		count2=1;
	 end

    wire [3:0]current_pass;
    wire [2:0]wrong_attempt;
    wire [3:0]pass_serial;

    //assign current_pass=16'b0001000100011010;
    output [2:0]count; //verification purpose
    output [3:0]cp; //verification purpose
    output [3:0]ci;
    assign count=wrong_attempt; //verification purpose
    assign cp=current_pass; //verification purpose
    assign ci=pass_serial;

    hextobin h1(digit_1,digit_2,digit_3,digit_4,pass_serial);

    compare cmp(clk,pass_serial,current_pass,reset,wrong_attempt,out,start);

    update u1(current_pass,pass_serial,clk,reset,start,out);

    buzzer_ctrl buzz(wrong_attempt,buzzer,out);


endmodule


/* -------------------------------------------------------------------------- */
/*                                 submodules                                 */
/* -------------------------------------------------------------------------- */


/* --------- module for comparing input password with saved password -------- */
module compare(
    clk,pass_in,current_pass,reset,wrong_attempt,out,start
);
    input [3:0] pass_in;
    input [3:0] current_pass;
    input clk,reset,start;
    output reg out;
    output reg [2:0]wrong_attempt;

    always @(negedge clk or negedge reset or negedge start) begin

        if(reset==0 || start==0)begin
            //out=0;
            wrong_attempt=3'b000;
        end
        // else if(start==0) begin
        //     wrong_attempt=3'b000;
        // end
        else if(pass_in==current_pass) begin
            out=1;
            wrong_attempt=3'b000;
        end

        else begin
            wrong_attempt=wrong_attempt+1;
            out=0;
        end

    end
endmodule


/* --- PISO to convert all 4-digit hex input into binary in serial manner --- */
module hextobin (
    digit_1,digit_2,digit_3,digit_4,
    pass_serial
);

    input digit_1,digit_2,digit_3,digit_4;
    output [3:0]pass_serial;

    assign pass_serial[3:0]={digit_1,digit_2,digit_3,digit_4};

endmodule


/* ------------------ module for store and update password ------------------ */
module  update(
    current_pass,
    pass_serial,
    clk,
    reset,
    start,
    out
);
    input [3:0]pass_serial;
    input clk,reset,out,start;
    output reg [3:0]current_pass;

    always @(negedge clk or negedge reset or negedge start) begin
        if (reset==0) begin
			if(out) begin
					current_pass<=pass_serial;
				end
        end
		  else if(start==0)begin
				current_pass<=pass_serial;
			end
		  
        else begin
            current_pass<=current_pass;
        end
    end

endmodule


/* ------------------ control module for controling buzzer ------------------ */
module buzzer_ctrl(wrong_attempt,buzzer,out);
    input [2:0]wrong_attempt;
    input out;
    output reg buzzer;

    always @ (wrong_attempt or out)
    begin
        if (wrong_attempt>3'b011 && out==0)
        begin
            buzzer=1;
        end
        else
            buzzer=0;
    end
endmodule
