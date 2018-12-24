-- Filename: mux.vhd 
-- Author: Christos Vasilopoulos
-- Description: Mux component 
-- Date: 11/5/2015

library ieee;
use ieee.std_logic_1164.all;

entity mux is
 generic (N: integer:= 5); 
   port( 
        in1  : in std_logic_vector(N - 1 downto 0);
      	 in2  : in std_logic_vector(N - 1 downto 0);
      	 sel  : in std_logic;
      	 out1 : out std_logic_vector(N - 1 downto 0)
	 );
end mux;

architecture rtl of mux is
begin
  MUX_PROC: process(in1, in2, sel)
            begin
                   if (sel = '0') then
                       out1 <= in1;
                   else 
                       out1 <= in2;
                   end if;
            end process MUX_PROC;
end rtl;
