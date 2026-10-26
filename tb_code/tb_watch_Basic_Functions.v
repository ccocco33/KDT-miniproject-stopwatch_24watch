`timescale 1ns / 1ps

module tb_watch_stopwatch ();
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
    watch_stopwatch_top DUT (
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
    //     rst  = 0;

    //     //stopwatch : sec:msec start
    //     btnR = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnR = 0;

    //     //run 100msec
    //     repeat (10) begin
    //         #(MSEC * 10);
    //     end
    //     //스탑워치 sec:msec -> hour:min => 두개다 값은 증가하고 있고 보여지는 counter값만 바뀐다.
    //     sw_display_mode = 1;
    //     //run 100msec
    //     repeat (10) begin
    //         #(MSEC * 10);
    //     end
    //     //stop버튼 눌렀을 때
    //     btnR = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnR = 0;
    //     //run 100msec
    //     repeat (10) begin
    //         #(MSEC * 10);
    //     end
    //     //down으로 변경
    //     btnU = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnU = 0;
    //     #10;
    //     //run
    //     btnR = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnR = 0;
    //     //run 100msec
    //     repeat (10) begin
    //         #(MSEC * 10);
    //     end
    //     //hour:min-> sec:msec 
    //     sw_display_mode = 0;
    //     //run 100msec
    //     repeat (10) begin
    //         #(MSEC * 10);
    //     end
    //     btnR = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnR = 0;
    //     $stop;
    // end


    //스톱워치 업 다운, 경계값
    // initial begin
    //     rst = 1;
    //     clk = 0;
    //     btnR = 0;
    //     btnL = 0;
    //     btnU = 0;
    //     btnD = 0;
    //     sw_show_mode = 1; 
    //     sw_display_mode = 0;
    //     sw_time_edit = 0;
    //     #10;
    //     rst = 0;
    //     // repeat (10) begin
    //     //             #(MSEC * 10);
    //     //         end

    //     //run
    //     btnR = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnR = 0;
        
    //     //30ms
    //     repeat (10) begin
    //         #(MSEC * 3);
    //     end

    //     //stop
    //     btnR = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnR = 0;

    //     //mode - down
    //     btnU = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnU = 0;
        
    //     //50ms - 경계값
    //     repeat (10) begin
    //         #(MSEC * 5);
    //     end

    //     //stop
    //     btnR = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnR = 0;

    //     //mode - up
    //     btnU = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnU = 0;

    //     //run
    //     btnR = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnR = 0;

    //     //30ms - 경계값
    //     repeat (10) begin
    //         #(MSEC * 3);
    //     end
    //     $stop;
    // end

    //watch - 시간 수정
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
            #(MSEC * 3);
        end

        // sw2=1 수정모드 진입, 카운터 증가 x ,1의 자리 fnd_font출력 ff -> 그 숫자엿다가 반복
        sw_time_edit = 1;

        repeat (10) begin
            #(MSEC * 3);
        end

        //btn R - 1000자리로 이동(경게값)
        btnR = 1;
        repeat (BD_PUSH_TIME) @(posedge clk);
        btnR = 0;
        #1000;

        //hour:min
        sw_display_mode = 1;
        #1000;

        //btnU - 1 -> 2
        btnU = 1;
        repeat (BD_PUSH_TIME) @(posedge clk);
        btnU = 0;     
        #1000;

        //btnU - 2 -> 0
        btnU = 1;
        repeat (BD_PUSH_TIME) @(posedge clk);
        btnU = 0;  
        #1000;

        //btn R - 100 자리로 이동
        btnR = 1;
        repeat (BD_PUSH_TIME) @(posedge clk);
        btnR = 0;
        #1000;

        //btn D - 2 -> 1
        btnD = 1;
        repeat (BD_PUSH_TIME) @(posedge clk);
        btnD = 0;
        #1000;
        //btn D - 1 -> 0
        btnD = 1;
        repeat (BD_PUSH_TIME) @(posedge clk);
        btnD = 0;
        #1000;
        //btn D - 0 -> 9
        btnD = 1;
        repeat (BD_PUSH_TIME) @(posedge clk);
        btnD = 0;
        #1000;

        //btn R - 1000 자리로 이동
        btnL = 1;
        repeat (BD_PUSH_TIME) @(posedge clk);
        btnL = 0;
        #1000;

        //btnD - 0 -> 1 (2로 가지 않는다.)
        btnD = 1;
        repeat (BD_PUSH_TIME) @(posedge clk);
        btnD = 0;  

        sw_time_edit = 0;
        //수정된 값에서 증가
        repeat (10) begin
            #(MSEC * 3);
        end
        $stop;
    end

    //sec:msec -> hour:min => stopwatch
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
    //     repeat (3) begin
    //         #(MSEC * 10);
    //     end

    //     // sw2=1 수정모드 진입, 카운터 증가 x ,1의 자리 fnd_font출력 ff -> 그 숫자엿다가 반복
    //     sw_time_edit = 1;

    //     repeat (10) begin
    //         #(MSEC * 3);
    //     end

    //     //btn R - 1000자리로 이동(경게값)
    //     btnR = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnR = 0;
    //     #1000;

    //     //hour:min
    //     sw_display_mode = 1;
    //     #1000;

    //     //btnU - 1 -> 2
    //     btnU = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnU = 0;     
    //     #1000;

    //     //btnU - 2 -> 0
    //     btnU = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnU = 0;  
    //     #1000;

    //     //btn R - 100 자리로 이동
    //     btnR = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnR = 0;
    //     #1000;

    //     //btn D - 2 -> 1
    //     btnD = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnD = 0;
    //     #1000;
    //     //btn D - 1 -> 0
    //     btnD = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnD = 0;
    //     #1000;
    //     //btn D - 0 -> 9
    //     btnD = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnD = 0;
    //     #1000;
    //     sw_time_edit = 0;
    //     // hour:min
    //     // sw_display_mode = 1;

    //     repeat (10) begin
    //         #(MSEC * 3);
    //     end

    //     //stopwatch
    //     sw_show_mode =1;

    //     //run
    //     btnR = 1;
    //     repeat (BD_PUSH_TIME) @(posedge clk);
    //     btnR = 0;

    //     repeat (3) begin
    //         #(MSEC * 3);
    //     end
    //     // sec:min
    //     sw_display_mode = 1;
    //     repeat (10) begin
    //         #(MSEC * 3);
    //     end

    //     //watch
    //     sw_show_mode =0;
    //     repeat (10) begin
    //         #(MSEC * 3);
    //     end

    //     $stop;
    // end

    

endmodule
