library verilog;
use verilog.vl_types.all;
entity ring_counter is
    port(
        Clock           : in     vl_logic;
        Reset           : in     vl_logic;
        Count_out       : out    vl_logic_vector(3 downto 0)
    );
end ring_counter;
