library ieee;
use ieee.std_logic_arith.all;

entity adder is
    generic( N : integer := 5);
    port(
          a1 : in signed(N - 1 downto 0);
          a2 : in signed(N - 1 downto 0);
          out1: out signed(N - 1 downto 0)
    );
end adder;

architecture rtl of adder is 
begin
  ADD_PROC: process(a1, a2)
              begin
                out1 <= a1 + a2;
          end process;
end rtl;
