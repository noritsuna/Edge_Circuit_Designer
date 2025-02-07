// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
// Copyright 2023 Noritsuna Imamura with ISHI-KAI (noritsuna@siprop.org, https://ishi-kai.org/)

`default_nettype none
/*
 *-------------------------------------------------------------
 *
 * Edge_Circuit_Designer
 *
 * "module counter" is generated by LLaMa2.
 *
 *-------------------------------------------------------------
 */

module Edge_Circuit_Designer #(
    parameter BITS = 16
)(
`ifdef USE_POWER_PINS
    inout vccd1,	// User area 1 1.8V supply
    inout vssd1,	// User area 1 digital ground
`endif

    // Wishbone Slave ports (WB MI A)
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    output wbs_ack_o,
    output [31:0] wbs_dat_o,

    // Logic Analyzer Signals
    input  [127:0] la_data_in,
    output [127:0] la_data_out,
    input  [127:0] la_oenb,

    // IOs
    input  [BITS-1:0] io_in,
    output [BITS-1:0] io_out,
    output [BITS-1:0] io_oeb,

    // IRQ
    output [2:0] irq
);
    wire clk;
    wire reset;

    wire [BITS-1:0] rdata; 
    wire [BITS-1:0] wdata;
    wire [15:0] count;

    wire valid;
    wire [3:0] wstrb;
    wire [BITS-1:0] la_write;

    // WB MI A
    assign valid = wbs_cyc_i && wbs_stb_i; 
    assign wstrb = wbs_sel_i & {4{wbs_we_i}};
    assign wbs_dat_o = {{(32-BITS){1'b0}}, rdata};
    assign wdata = wbs_dat_i[BITS-1:0];

    // IO
    assign io_out = count;
    assign io_oeb = {(BITS){reset}};

    // IRQ
    assign irq = 3'b000;	// Unused

    // LA
    assign la_data_out = {{(128-BITS){1'b0}}, count};
    // Assuming LA probes [63:32] are for controlling the count register  
    assign la_write = ~la_oenb[63:64-BITS] & ~{BITS{valid}};
    // Assuming LA probes [65:64] are for controlling the count clk & reset  
    assign clk = (~la_oenb[64]) ? la_data_in[64]: wb_clk_i;
    assign reset = (~la_oenb[65]) ? la_data_in[65]: wb_rst_i;
    // LA
    la_reg_copy #(
    ) la_reg_copy(
        .clk(clk),
        .ready(wbs_ack_o),
        .valid(valid),
        .rdata(rdata),
        .wdata(wbs_dat_i[BITS-1:0]),
        .wstrb(wstrb),
        .count(count)
    );


    counter #(
    ) counter(
        .clk(clk),
        .rst(reset),
        .q(count)
    );

endmodule

module la_reg_copy(
    input clk,
    input valid,
    input [3:0] wstrb,
    input [15:0] wdata,
    input [15:0] count,
    output reg ready,
    output reg [15:0] rdata
);

    always @(posedge clk) begin
            if (valid && !ready) begin
                ready <= 1'b1;
                rdata <= count;
            end
    end

endmodule


/*
 *-------------------------------------------------------------
 *
 * "module counter" is generated by CodeLLaMa.
 * > Please generate a 16 bits counter in verilog.
 *
 *-------------------------------------------------------------
 */
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


`default_nettype wire
