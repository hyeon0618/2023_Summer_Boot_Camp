library verilog;
use verilog.vl_types.all;
entity mux is
    port(
        din             : in     vl_logic_vector(3 downto 0);
        sel             : in     vl_logic_vector(1 downto 0);
        dout            : out    vl_logic
    );
end mux;
