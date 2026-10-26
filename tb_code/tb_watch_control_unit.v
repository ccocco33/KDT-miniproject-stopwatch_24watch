`timescale 1ns / 1ps

module tb_watch_control_unit ();
    reg clk, rst;
    reg btn_R, btn_L, btn_U, btn_D;
    reg sw_display_mode, sw_show_mode, sw_time_edit;
    wire up, down, run_stop;
    wire [1:0] selected_digit;
    watch_control_unit dut (
        .clk(clk),
        .rst(rst),
        .btn_R(btn_R),
        .btn_L(btn_L),
        .btn_U(btn_U),
        .btn_D(btn_D),
        .sw_display_mode(sw_display_mode),
        .sw_show_mode(sw_show_mode),
        .sw_time_edit(sw_time_edit),
        .up(up),
        .down(down),
        .run_stop(run_stop),
        .selected_digit(selected_digit)
    );

    always #5 clk = ~clk;

    // 수정 상태 전이, 좌/우 연속 입력과 자리 순환, 입력 우선순위
    // 값을 바꾸고 기다린 뒤 파형에서 변화를 확인
    initial begin
        clk = 0;
        rst = 1;
        btn_R=0;
        btn_L=0;
        btn_U=0;
        btn_D=0;
        sw_display_mode=0;
        sw_show_mode=0;
        sw_time_edit=0;
        #30;
        rst = 0;

        // 1번: 일반 모드: WATCH=0, selected_digit=0, run_stop(edit)=0. 좌우는 무시.
        #10;
        btn_R = 1;
        #10;
        btn_R = 0;
        #20;

        // 2번: 수정 진입: S1=1, digit=0. 오른쪽 4번: 0 -> 3 -> 2 -> 1 -> 0.
        sw_time_edit=1;
        #30;
        btn_R = 1;
        #10;
        btn_R = 0;
        #30;
        btn_R = 1;
        #10;
        btn_R = 0;
        #30;
        btn_R = 1;
        #10;
        btn_R = 0;
        #30;
        btn_R = 1;
        #10;
        btn_R = 0;
        #20;

        // 3번: 왼쪽 4번: 0 -> 1 -> 2 -> 3 -> 0.
        #10;
        btn_L = 1;
        #10;
        btn_L = 0;
        #30;
        btn_L = 1;
        #10;
        btn_L = 0;
        #30;
        btn_L = 1;
        #10;
        btn_L = 0;
        #30;
        btn_L = 1;
        #10;
        btn_L = 0;
        #20;

        // 4번: 연속 교차 입력 R,L,R,L: 3,0,3,0. 동시 R/L 입력은 R 우선.
        #10;
        btn_R = 1;
        #10;
        btn_R = 0;
        #20;
        btn_L = 1;
        #10;
        btn_L = 0;
        #20;
        btn_R = 1;
        #10;
        btn_R = 0;
        #20;
        btn_L = 1;
        #10;
        btn_L = 0;
        #10;
        btn_R=1;
        btn_L=1;
        #10;
        btn_R=0;
        btn_L=0;

        // 5번: U/D는 한 클럭 등록 후 up/down에 전달. 동시 U/D는 둘 다 1; 우선순위는 DP에서 결정.
        btn_U=1;
        btn_D=1;
        #10;
        btn_U=0;
        btn_D=0;
        #10;

        // 6번: 표시단위/화면 선택만 바꾸면 자리 유지. CU 자체에는 버튼 화면 차단 기능이 없음.
        sw_display_mode=1;
        sw_show_mode=1;
        #20;

        // 7번: 수정 해제 후 WATCH/digit=0. 다시 진입 시 S1부터. 수정 중 리셋 초기화.
        sw_time_edit=0;
        #20;
        sw_time_edit=1;
        #20;
        rst=1;
        #20;
        $stop;
    end
endmodule
