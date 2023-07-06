library verilog;
use verilog.vl_types.all;
entity jk_ff is
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        j               : in     vl_logic;
        k               : in     vl_logic;
        q_t             : out    vl_logic
    );
end jk_ff;
