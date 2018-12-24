-- Filename: register_N_bits.vhd 
-- Author: Christos Vasilopoulos
-- Description: Register N bits component 
-- Date: 11/5/2015

library ieee;
use ieee.std_logic_1164.all;

entity register_N_bits is
  generic(N : integer := 5);
    port(   
            d:    in std_logic_vector(N - 1 downto 0);
            clk:  in std_logic;
            rst:  in std_logic;
            en:   in std_logic;
            q:    out std_logic_vector(N - 1 downto 0)
    );
end register_N_bits;

architecture str of register_N_bits is
    component Dff
         port(   
                d:    in std_logic;
                clk:  in std_logic;
                rst:  in std_logic;
                en:   in std_logic;
                q:    out std_logic
         );
    end component Dff;
    
begin
  
      gener: for i in 0 to N - 1 generate
          U_Dff: Dff port map ( 
                                d   => d(i),
                                clk => clk,
                                rst =>rst,
                                en  => en,
                                q   => q(i)
                              );
      end generate gener;
end str;














