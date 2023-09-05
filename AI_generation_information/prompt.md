# Prompt Documentation
## Prompt
The prompts used in the Edge_Circuit_Designer Project are as follows:  
```
Please generate a 16 bits counter in verilog.
```

## Output by LLaMa2(Q4)
The following output is the result of the output by LLaMa2.    
Build fails because `reg [15:0] count;` does not match the grammar.

```
module counter(
        input clk,
        input reset,
        output [15:0] count);

        reg [15:0] count;

        always @ (posedge clk) begin
                if (!reset) begin
                        count <= 16'h0000;
                end else begin
                        count <= count + 1;
                end
        end

endmodule
```
![Result of LLaMa2](result_llama2.png)


## Output by Code LLaMa(Q4)
The following output by Code LLaMa, which is based on LLaMa2 and fine-tuned for programming languages.  
Unlike LLaMa2, the operable code is output. However, only about 1 in 10 times is output correctly.  
This time, the GDSII output is based on this.

```
module counter(clk,rst,q);
        input clk, rst;
        output [15:0] q;

        reg [15:0] q;

        always @ (posedge clk or posedge rst) begin

                if (rst == 1'b1) begin

                        q <= 16'h000;

                        end else begin


                                q <= q + 16'h0001;

                                end


                                end


                                endmodule
```
![Result of Code LLaMa](result_codellama.png)
