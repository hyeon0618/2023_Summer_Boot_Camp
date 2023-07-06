library verilog;
use verilog.vl_types.all;
entity binary_cnt is
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        start           : in     vl_logic;
        cnt             : out    vl_logic_vector(3 downto 0)
    );
end binary_cnt;
