-- Filename: top.vhd 
-- Author: Christos Vasilopoulos
-- Description: Top level component 
-- Date: 19/5/2015


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use work.rom_constants.all;

entity top is 
  generic(N : integer := 5);
      port(
            clk  : in std_logic;
            rst  : in std_logic;
            mode : in std_logic;
            dataoutready : out std_logic;
            r : out std_logic_vector(N -1 downto 0)
      );
      
end top;
      
architecture str of top is 
      
      
      
      component datapath
           generic(N : integer := 5);
              port(
                    x : in std_logic_vector(N - 1 downto 0);
                    y : in std_logic_vector(N - 1 downto 0);
                    clk : in std_logic;
                    rst: in std_logic; 
                    en1 : in std_logic;
                    en2 : in std_logic;
                    en3 : in std_logic;
                    en4 : in std_logic;
                    en5 : in std_logic;
                    en6 : in std_logic;
                    sel1: in std_logic;
                    sel2: in std_logic;
                    sel3: in std_logic;
                    r : out std_logic_vector(N - 1 downto 0)
              );
      end component datapath;
      
      component fsm_with_rom is 
              port(
                    clk : in std_logic;
                    rst :in std_logic;
                    mode: in std_logic;
                    en1 : out std_logic;
                    en2 : out std_logic;
                    en3 : out std_logic;
                    en4 : out std_logic;
                    en5 : out std_logic;
                    en6 : out std_logic;
                    sel1 : out std_logic;
                    sel2 : out std_logic;
                    sel3 : out std_logic;
                    dataoutready : out std_logic;
                    romx : out std_logic_vector(ROM_LENGTH-1 downto 0);
                    romy : out std_logic_vector(ROM_LENGTH-1 downto 0)
              );
      end component fsm_with_rom;
      
      signal en1_i: std_logic;
      signal en2_i: std_logic;
      signal en3_i: std_logic;
      signal en4_i: std_logic;
      signal en5_i: std_logic;
      signal en6_i: std_logic;
      signal sel1_i: std_logic;
      signal sel2_i: std_logic;
      signal sel3_i: std_logic;
      signal data_out_ready_i: std_logic;
      signal x_i : ROM_ENTRY;
      signal y_i : ROM_ENTRY;
      
     
      
     
begin
      U_FSM_WITH_ROM: fsm_with_rom
        port map(  
                  clk  => clk,
                  rst => rst,
                  mode => mode,
                  en1 => en1_i,
                  en2 => en2_i,
                  en3 => en3_i,
                  en4 => en4_i,
                  en5 => en5_i,
                  en6 => en6_i,
                  sel1 => sel1_i,
                  sel2 => sel2_i,
                  sel3 => sel3_i,
                  dataoutready => data_out_ready_i,
                  romx => x_i,
                  romy => y_i
    
        );

      
      U_DATAPATH: datapath generic map (N => 5)
		        port map(	
				              x => x_i,
                      y => y_i,
                      clk => clk,
                      rst => rst,
                      en1 => en1_i,
                      en2 => en2_i,
                      en3 => en3_i,
                      en4 => en4_i,
                      en5 => en5_i,
                      en6 => en6_i,
                      sel1 => sel1_i,
                      sel2 => sel2_i,
                      sel3 => sel3_i,
                      r => r	
          );

            
          dataoutready <= data_out_ready_i; 									

end str;
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  