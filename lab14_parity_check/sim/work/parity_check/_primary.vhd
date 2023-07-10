library verilog;
use verilog.vl_types.all;
entity parity_check is
    port(
        din             : in     vl_logic_vector(3 downto 0);
        dout            : out    vl_logic
    );
end parity_check;
