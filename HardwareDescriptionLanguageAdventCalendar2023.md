# [Hardware Description Language Advent Calendar 2023 の 13日目](https://qiita.com/advent-calendar/2023/hdl)の記事です。


## 何の記事？
[AI Generated Design Contest 2](https://efabless.com/ai-generated-design-contest-2) に、応募した[Edge_Circuit_Designer](https://github.com/noritsuna/Edge_Circuit_Designer)についての記事です。残念ながら、入賞できなかったので、供養をするために投稿しました！


# [Edge_Circuit_Designer](https://github.com/noritsuna/Edge_Circuit_Designer) とは？
要は、最近はやりのChatGPT系のエンジンを利用して、Raspberry Pi 4上に構築したVerilogコードのジェネレータです。  


## 結果
prompt:  
```
Please generate a 16 bits counter in verilog.
```
![Prompt of Edge Circuit Designer](AI_generation_information/RPi4_prompt.jpg)

### Code LLaMa(Q4)
```
./main -m ./models/7B/codellama-7b.ggmlv3.Q4_K_M.bin \
       --color \
       --ctx_size 2048 \
       -n -1 \
       -ins -b 256 \
       --top_k 10000 \
       --temp 0.2 \
       --repeat_penalty 1.1 \
       -t 8
```


### Output by Code LLaMa(Q4)
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
![Result of Code LLaMa](AI_generation_information/result_codellama.png)


# まとめ
16ビットのカウンターという最低限の機能ですが、一応出力出来ました。  
現時点では、まともなコードを出そうとすると、「指令を与えるプロンプトがほぼコードになるので、いまいち実用性がない」ってのが正直なところです。  
ただ、ちゃんとしたVerilogのコードは出てくるので、未来は見たかなという印象であります。なんせ、ラズパイで動いていますから、理論上はスマホでも動くってことなので。  

以上、お粗末様でした。
