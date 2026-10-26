`timescale 1ns / 1ps

module tb_stopwatch_control_unit ();
    reg clk, rst;
    reg btn_run_stop, btn_clear, btn_mode, btn_laptime;
    wire clear, run_stop, mode, laptime, lap_cap;
    stopwatch_control_unit dut (
        .clk(clk),
        .rst(rst),
        .btn_run_stop(btn_run_stop),
        .btn_clear(btn_clear),
        .btn_mode(btn_mode),
        .btn_laptime(btn_laptime),
        .clear(clear),
        .run_stop(run_stop),
        .mode(mode),
        .laptime(laptime),
        .lap_cap(lap_cap)
    );

    always #5 clk = ~clk;

    // STOP/RUN/CLEAR/MODE/LAPTIME 상태와 랩 캡처, 동시입력 우선순위
    // 값을 바꾸고 기다린 뒤 파형에서 변화를 확인
    initial begin
        clk = 0;
        rst = 1;
        btn_run_stop=0;
        btn_clear=0;
        btn_mode=0;
        btn_laptime=0;
        #30;
        rst = 0;

        // 1번: 리셋 STOP=0. STOP에서 LAP 입력은 무시.
        #10;
        btn_laptime = 1;
        #10;
        btn_laptime = 0;
        #20;

        // 2번: STOP -> RUN. RUN에서 CLEAR/MODE는 무시.
        #10;
        btn_run_stop = 1;
        #10;
        btn_run_stop = 0;
        #30;
        btn_clear = 1;
        #10;
        btn_clear = 0;
        #30;
        btn_mode = 1;
        #10;
        btn_mode = 0;
        #20;

        // 3번: RUN에서 LAP 누르는 동안 lap_cap=1, 다음 클럭 LAPTIME=4. 계속 카운트.
        btn_laptime=1;
        #10;
        btn_laptime=0;
        #20;
        btn_laptime=1;
        #10;
        btn_laptime=0;
        #10;

        // 4번: LAP에서 R -> STOP, 랩 표시 해제. STOP에서 CLEAR는 한 클럭 후 STOP 복귀.
        #10;
        btn_run_stop = 1;
        #10;
        btn_run_stop = 0;
        #20;
        btn_clear=1;
        #10;
        btn_clear=0;
        #10;

        // 5번: STOP -> MODE=3 -> STOP. mode는 MODE 다음 클럭에서 0->1, 재입력 1->0.
        btn_mode=1;
        #10;
        btn_mode=0;
        #20;
        btn_mode = 1;
        #10;
        btn_mode = 0;
        #20;

        // 6번: STOP 동시 R/CLEAR/MODE는 R 우선. RUN 동시 R/LAP는 정지 우선, 저장 안 함.
        btn_run_stop=1;
        btn_clear=1;
        btn_mode=1;
        #10;
        btn_run_stop=0;
        btn_clear=0;
        btn_mode=0;
        #10;
        btn_run_stop=1;
        btn_laptime=1;
        #10;
        btn_run_stop=0;
        btn_laptime=0;
        #10;

        // 7번: RUN 중 비동기 리셋: STOP/clear=0/run=0/mode=0/lap=0.
        #10;
        btn_run_stop = 1;
        #10;
        btn_run_stop = 0;
        #20;
        rst=1;
        #20;
        $stop;
    end
endmodule
