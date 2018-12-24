-- Filename: Dff.vhd 
-- Author: Christos Vasilopoulos
-- Description: Dff component 
-- Date: 11/5/2015

library ieee;
use ieee.std_logic_1164.all;

entity Dff is
    port(   
            d:    in std_logic;
            clk:  in std_logic;
            rst:  in std_logic;
            en:   in std_logic;
            q:    out std_logic
    );
end Dff;

architecture rtl of Dff is
begin
  
      Dff_PROC: process(clk)
          begin
              if (clk'event and clk = '1') then
                  if (rst = '1') then 
                      q <= '0';
                  elsif (en = '1') then
                      q <= d;
                  end if;
               end if;
           end process Dff_PROC;
end rtl;
  
            
            
          
