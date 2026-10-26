`timescale 1ns / 1ps

module tb_watch_case1 ();
    parameter BD_PUSH_TIME = 10 * 100;
    parameter MSEC = 100_000 * 10;
    reg
        clk,
        rst,
        btnR,
        btnL,
        btnU,
        btnD,
        sw_show_mode,
        sw_display_mode,
        sw_time_edit;
    wire [7:0] fnd_font;
    wire [3:0] fnd_com;
    watch_stopwatch_top dut (
        .clk(clk),
        .rst(rst),
        .btnR(btnR),
        .btnL(btnL),
        .btnU(btnU),
        .btnD(btnD),  //랩타임 OR DOWN
        .sw_show_mode(sw_show_mode),
        .sw_display_mode(sw_display_mode),
        .sw_time_edit(sw_time_edit),
        .fnd_com(fnd_com),
        .fnd_font(fnd_font)
    );

    always #5 clk = ~clk;
    // 모듈 안, initial 밖에 둘 것

    //watch - counter 자리올림
    // initial begin
    //     rst = 1;
    //     clk = 0;
    //     btnR = 0;
    //     btnL = 0;
    //     btnU = 0;
    //     btnD = 0;
    //     sw_show_mode = 0; 
    //     sw_display_mode = 0;
    //     sw_time_edit = 0;
    //     #10;
    //     rst = 0;
    //     @(negedge clk);
    //     dut.U_WATCH_DATAPATH.U_HOUR_COUNTER_WATCH.counter_reg = 23;
    //     dut.U_WATCH_DATAPATH.U_MIN_COUNTER_WATCH.counter_reg  = 59;
    //     dut.U_WATCH_DATAPATH.U_SEC_COUNTER_WATCH.counter_reg  = 59;
    //     dut.U_WATCH_DATAPATH.U_MSEC_COUNTER_WATCH.counter_reg = 95;


    //     //시간 증가 - 시작 12:00, 00:00
    //     repeat (100) begin
    //         #(MSEC * 10);
    //     end

    //     $stop;
    // end


    //watch 수정 커서 이동
    // initial begin
    //     rst = 1;
    //     clk = 0;
    //     btnR = 0;
    //     btnL = 0;
    //     btnU = 0;
    //     btnD = 0;
    //     sw_show_mode = 0; 
    //     sw_display_mode = 0;
    //     sw_time_edit = 0;
    //     #10;
    //     rst = 0;

    //     //시간 증가 - 시작 12:00, 00:00
    //     repeat (10) begin
    //         #(MSEC * 3);
    //     end

    //     // sw2=1 수정모드 진입, 카운터 증가 x ,1의 자리 fnd_font출력 ff -> 그 숫자엿다가 반복
    //     sw_time_edit = 1;
    //     #1000;
    //     //btn R - 1000자리로 이동(경게값)
    //     btnR = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnR = 0;
    //     #1000;
    //     //btn R - 100자리로 이동(경게값)
    //     btnR = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnR = 0;
    //     #1000;
    //     //btn R - 10자리로 이동(경게값)
    //     btnR = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnR = 0;
    //     #1000;
    //     //btn R - 1자리로 이동(경게값)
    //     btnR = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnR = 0;
    //     #1000;

    //     //btn L - 10자리로 이동(경게값)
    //     btnL = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnL = 0;
    //     #1000;
    //     //btn L - 100자리로 이동(경게값)
    //     btnL = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnL = 0;
    //     #1000;
    //     //btn L - 1000자리로 이동(경게값)
    //     btnL = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnL = 0;
    //     #1000;
    //     //btn L - 1자리로 이동(경게값)
    //     btnL = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnL = 0;
    //     #1000;

    //     sw_time_edit = 0;
    //     //수정된 값에서 증가
    //     repeat (10) begin
    //         #(MSEC * 3);
    //     end
    //     $stop;
    // end

    //수정 / 자리별로 +- 2씩
    // initial begin
    //     rst = 1;
    //     clk = 0;
    //     btnR = 0;
    //     btnL = 0;
    //     btnU = 0;
    //     btnD = 0;
    //     sw_show_mode = 0; 
    //     sw_display_mode = 0;
    //     sw_time_edit = 0;
    //     #10;
    //     rst = 0;

    //     //시간 증가 - 시작 12:00, 00:00
    //     repeat (10) begin
    //         #(MSEC * 1);
    //     end

    //     // sw2=1 수정모드 진입
    //     sw_time_edit = 1;
    //     #1000;

    //     // hour:min
    //     //1의자리
    //     //btnD - 
    //     btnD = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnD = 0;
    //     #1000;
    //     //btnD - 
    //     btnD = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnD = 0;
    //     #1000;

    //     //btnU - 
    //     btnU = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnU = 0;
    //     #1000;
    //     //btnU - 
    //     btnU = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnU = 0;
    //     #1000;

    //     //btnL - 10의 자리
    //     btnL = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnL = 0;
    //     #1000;
    //     //btnD - 
    //     btnD = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnD = 0;
    //     #1000;
    //     //btnD - 
    //     btnD = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnD = 0;
    //     #1000;

    //     //btnU - 
    //     btnU = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnU = 0;
    //     #1000;
    //     //btnU - 
    //     btnU = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnU = 0;
    //     #1000;


    //     //btnL - 100의 자리
    //     btnL = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnL = 0;
    //     #1000;
    //     //btnD - 
    //     btnD = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnD = 0;
    //     #1000;
    //     //btnD - 
    //     btnD = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnD = 0;
    //     #1000;

    //     //btnU - 
    //     btnU = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnU = 0;
    //     #1000;
    //     //btnU - 
    //     btnU = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnU = 0;
    //     #1000;

    //     //btnL - 1000의 자리
    //     btnL = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnL = 0;
    //     #1000;
    //     //btnD - 
    //     btnD = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnD = 0;
    //     #1000;
    //     //btnD - 
    //     btnD = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnD = 0;
    //     #1000;

    //     //btnU - 
    //     btnU = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnU = 0;
    //     #1000;
    //     //btnU - 
    //     btnU = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnU = 0;
    //     #1000;

    //     repeat (1) begin
    //         #(MSEC * 10);
    //     end


    //     // sec:msec
    //     sw_display_mode = 1;
    //     //1의자리
    //     //btnD - 
    //     #1000;
    //     btnD = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnD = 0;
    //     #1000;
    //     //btnD - 
    //     btnD = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnD = 0;
    //     #1000;

    //     //btnU - 
    //     btnU = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnU = 0;
    //     #1000;
    //     //btnU - 
    //     btnU = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnU = 0;
    //     #1000;

    //     //btnL - 10의 자리
    //     btnL = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnL = 0;
    //     #1000;
    //     //btnD - 
    //     btnD = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnD = 0;
    //     #1000;
    //     //btnD - 
    //     btnD = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnD = 0;
    //     #1000;

    //     //btnU - 
    //     btnU = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnU = 0;
    //     #1000;
    //     //btnU - 
    //     btnU = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnU = 0;
    //     #1000;


    //     //btnL - 100의 자리
    //     btnL = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnL = 0;
    //     #1000;
    //     //btnD - 
    //     btnD = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnD = 0;
    //     #1000;
    //     //btnD - 
    //     btnD = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnD = 0;
    //     #1000;

    //     //btnU - 
    //     btnU = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnU = 0;
    //     #1000;
    //     //btnU - 
    //     btnU = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnU = 0;
    //     #1000;

    //     //btnL - 1000의 자리
    //     btnL = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnL = 0;
    //     #1000;

    //     //btnD - 
    //     btnD = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnD = 0;
    //     #1000;
    //     //btnD - 
    //     btnD = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnD = 0;
    //     #1000;

    //     //btnU - 
    //     btnU = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnU = 0;
    //     #1000;
    //     //btnU - 
    //     btnU = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnU = 0;
    //     #1000;
    //     sw_time_edit = 0;
    //     //수정된 값에서 증가
    //     repeat (1) begin
    //         #(MSEC * 3);
    //     end
    //     $stop;
    // end
    //********************************************************

    //엣지 케이스********************************************************
    //23 -> 20 -> 23
    initial begin
        rst = 1;
        clk = 0;
        btnR = 0;
        btnL = 0;
        btnU = 0;
        btnD = 0;
        sw_show_mode = 0; 
        sw_display_mode = 0;
        sw_time_edit = 0;
        #10;
        rst = 0;

        //시간 증가 - 시작 12:00, 00:00
        repeat (10) begin
            #(MSEC * 1);
        end

        // sw2=1 수정모드 진입
        sw_time_edit = 1;
        #1000;

        // hour:min
        //1000의자리
        //btnR - 
        btnR = 1;
        repeat (BD_PUSH_TIME) @(posedge clk);
        btnR = 0;
        #1000;
        //btnU - 
        btnU = 1;
        repeat (BD_PUSH_TIME) @(posedge clk);
        btnU = 0;
        #1000;

        //100의자리
        //btnR - 
        btnR = 1;
        repeat (BD_PUSH_TIME) @(posedge clk);
        btnR = 0;
        #1000;
        //btnD - 
        btnD = 1;
        repeat (BD_PUSH_TIME) @(posedge clk);
        btnD = 0;
        #1000;
        //btnU - 
        btnU = 1;
        repeat (BD_PUSH_TIME) @(posedge clk);
        btnU = 0;
        #1000;

       
        sw_time_edit = 0;
        //수정된 값에서 증가
        repeat (1) begin
            #(MSEC * 3);
        end
        $stop;
    end
    //********************************************************

    //14 -> 04


endmodule
