-- Filename: rom.vhd 
-- Author: Christos Vasilopoulos
-- Description: Rom component 
-- Date: 28/5/2015

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.rom_constants.all;

entity rom is
  port( 
        clk: in std_logic;
        rst: in std_logic;
        readdata : in std_logic; 
        datainready : out std_logic;
        address : out std_logic_vector(ROM_ROWS - 1 downto 0);
        romx : out std_logic_vector(ROM_LENGTH - 1 downto 0);
        romy : out std_logic_vector(ROM_LENGTH - 1 downto 0)
  );
end rom;

architecture rtl of rom is

attribute keep: string;
attribute keep of romx: signal is "true";
attribute keep of romy: signal is "true"; 
signal count: std_logic_vector(ROM_ROWS - 1 downto 0);
 
begin

ROM_PROC: process(clk)
  begin
    if (clk'event and clk = '1') then	 
        if (rst = '1') then
            count<= (others => '0'); 
            romx<= (others => '0');
            romy<= (others => '0');
            datainready <= '1';
            address <= (others=> '0');
        else 
          if (readdata = '1' and count /= ROM_ROWS) then 	
              romx <= ROM_X_ENTRIES(conv_integer(count));
              romy <= ROM_Y_ENTRIES(conv_integer(count));
              datainready <= '1';
              count <= count + 1;
              address <= count;
          else 
              count <= count;
              romx<= (others => '0');
              romy<= (others => '0');
              datainready <= '0';
              address <= count - 1;
          end if;
        end if;
    end if;
  end process ROM_PROC;
  
end rtl;
