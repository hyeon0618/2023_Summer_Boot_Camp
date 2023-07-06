library verilog;
use verilog.vl_types.all;
entity t_ff is
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        t               : in     vl_logic;
        q_t_1           : out    vl_logic
    );
end t_ff;
