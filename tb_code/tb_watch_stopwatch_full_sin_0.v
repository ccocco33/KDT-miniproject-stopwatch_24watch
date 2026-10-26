`timescale 1ns / 1ps

module tb_watch_stopwatch_full_sin_0 ();


    reg clk, rst, btnR, btnL, btnU, btnD;
    reg sw_show_mode, sw_display_mode, sw_time_edit;
    wire [3:0] fnd_com;
    wire [7:0] fnd_font;

    parameter BD_PUSH_TIME = 10 *100;
    parameter MSEC         = 100_000 * 10;

    watch_stopwatch_top dut (
        .clk            (clk),
        .rst            (rst),
        .btnR           (btnR),
        .btnL           (btnL),
        .btnU           (btnU),
        .btnD           (btnD),             //랩타임 OR DOWN
        .sw_show_mode   (sw_show_mode),
        .sw_display_mode(sw_display_mode),
        .sw_time_edit   (sw_time_edit),
        .fnd_com        (fnd_com),
        .fnd_font       (fnd_font)
    );

    always #5 clk = ~clk;

    initial begin
        rst = 1;
        clk = 0;
        btnR = 0;
        btnL = 0;
        btnU = 0;
        btnD = 0;
        sw_show_mode = 1;
        sw_display_mode = 0;
        sw_time_edit = 0;
        #10;
        rst  = 0;
        // repeat (10) begin
        // #(MSEC * 10);
        // end

        //run
        btnR = 1;
        repeat (BD_PUSH_TIME) @(posedge clk);
        btnR = 0;

        //30ms
        repeat (10) begin
            #(MSEC * 3);
        end

        //stop
        btnR = 1;
        repeat (BD_PUSH_TIME) @(posedge clk);
        btnR = 0;

        //mode - down
        btnU = 1;
        repeat (BD_PUSH_TIME) @(posedge clk);
        btnU = 0;

        //50ms - 경계값
        repeat (10) begin
            #(MSEC * 5);
        end

        //stop
        btnR = 1;
        repeat (BD_PUSH_TIME) @(posedge clk);
        btnR = 0;

        //mode - up
        btnU = 1;
        repeat (BD_PUSH_TIME) @(posedge clk);
        btnU = 0;

        //run
        btnR = 1;
        repeat (BD_PUSH_TIME) @(posedge clk);
        btnR = 0;

        //30ms - 경계값
        repeat (10) begin
            #(MSEC * 3);
        end
        $stop;
    end

endmodule
