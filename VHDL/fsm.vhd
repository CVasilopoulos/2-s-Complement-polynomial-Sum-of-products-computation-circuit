-- Filename: fsm.vhd 
-- Author: Christos Vasilopoulos
-- Description: Fsm component 
-- Date: 18/5/2015

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.rom_constants.all;

entity fsm is
  port( 
        clk  : in std_logic;
        rst  : in std_logic;
        mode : in std_logic;
        datainready : in std_logic;
        address : in std_logic_vector(ROM_ROWS - 1 downto 0);
        en1  : out std_logic;
        en2  : out std_logic;
        en3  : out std_logic;
        en4  : out std_logic;
        en5  : out std_logic;
        en6  : out std_logic;
        sel1 : out std_logic;
        sel2 : out std_logic;
        sel3 : out std_logic;
        dataoutready : out std_logic;
        readdata : out std_logic
    
  );
  
end fsm;

architecture rtl of fsm is 
    type STATE_TYPE is (S0, S1, S2, S3, S4, S5, S6);
    signal curr_state: STATE_TYPE;
begin
  
      S_COMP_PROC:  process(curr_state, address, mode, datainready)
              begin
                  case curr_state is
                      when S0 =>
                         if (address /= ROM_ROWS - 1) then	
                              en1 <= '0';
                              en2 <= '0';
                              en3 <= '0';
                              en4 <= '0';
                              en5 <= '0';
                              en6 <= '0';
                              sel1 <= '0';
                              sel2 <= '0';
                              sel3 <= '0';
                              readdata <= '1';
                              dataoutready <= '0';
                           else
                              en1 <= '0';
                              en2 <= '0';
                              en3 <= '0';
                              en4 <= '0';
                              en5 <= '1';
                              en6 <= '0';
                              sel1 <= '0';
                              sel2 <= '0';
                              sel3 <= '0';
                              readdata <= '0';
                              dataoutready <= '0';
                           end if;
                      when S1 =>
                            en1 <= '1';
                            en2 <= '1';
                            en3 <= '0';
                            en4 <= '0';
                            en5 <= '0';
                            en6 <= '0';
                            sel1 <= '0';
                            sel2 <= '1';
                            sel3 <= '0';
                            readdata <= '1';
                            dataoutready <= '0';
                        when S2 =>
                          if (address /= ROM_ROWS - 1) then 
                              en1 <= '1';
                              en2 <= '1';
                              en3 <= '0';
                              en4 <= '0';
                              en5 <= '1';
                              en6 <= '1';
                              sel1 <= '0';
                              sel2 <= '1';
                              sel3 <= '0';
                              readdata <= '1';
                              dataoutready <= '1';
                           else
                              en1 <= '1';
                              en2 <= '1';
                              en3 <= '0';
                              en4 <= '0';
                              en5 <= '1';
                              en6 <= '1';
                              sel1 <= '0';
                              sel2 <= '1';
                              sel3 <= '0';
                              readdata <= '0';
                              dataoutready <= '1';
                           end if;
                        when S3 =>
                            en1 <= '1';
                            en2 <= '1';
                            en3 <= '0';
                            en4 <= '0';
                            en5 <= '0';
                            en6 <= '0';
                            sel1 <= '0';
                            sel2 <= '0';
                            sel3 <= '0';
                            readdata <= '1';
                            dataoutready <= '0';
                        when S4 =>
                            en1 <= '0';
                            en2 <= '0';
                            en3 <= '1';
                            en4 <= '1';
                            en5 <= '0';
                            en6 <= '0';
                            sel1 <= '0';
                            sel2 <= '0';
                            sel3 <= '0';
                            readdata <= '0';
                            dataoutready <= '0';
                        when S5 =>
                          if (address /= ROM_ROWS - 1) then	
                              en1 <= '0';
                              en2 <= '0';
                              en3 <= '0';
                              en4 <= '0';
                              en5 <= '1';
                              en6 <= '0';
                              sel1 <= '0';
                              sel2 <= '0';
                              sel3 <= '0';
                              readdata <= '1';
                              dataoutready <= '0';
                           else  
                               en1 <= '0';
                               en2 <= '0';
                               en3 <= '0';
                               en4 <= '0';
                               en5 <= '1';
                               en6 <= '0';
                               sel1 <= '0';
                               sel2 <= '0';
                               sel3 <= '0';
                               readdata <= '0';
                               dataoutready <= '0';
                             end if;
                        when S6 => 
                            if (mode = '0' and datainready = '1') then
                                en1 <= '1';
                                en2 <= '1';
                                en3 <= '0';
                                en4 <= '0';
                                en5 <= '0';
                                en6 <= '1';
                                sel1 <= '1';
                                sel2 <= '0';
                                sel3 <= '1';
                                readdata <= '1';
                                dataoutready <= '1';
                            else
                                en1 <= '0';
                                en2 <= '0';
                                en3 <= '0';
                                en4 <= '0';
                                en5 <= '0';
                                en6 <= '1';
                                sel1 <= '1';
                                sel2 <= '0';
                                sel3 <= '1';
                                readdata <= '0';
                                dataoutready <= '1';
                            end if;
                            when others =>
                                en1 <= '0';
                                en2 <= '0';
                                en3 <= '0';
                                en4 <= '0';
                                en5 <= '0';
                                en6 <= '0';
                                sel1 <= '0';
                                sel2 <= '0';
                                sel3 <= '0';
                                readdata <= '0';
                                dataoutready <= '0';
                            
              end case;
      end process S_COMP_PROC;
      
      ST_COMP_PROC:  process(clk)
                    begin
                        if (clk'event and clk = '1') then
                            if(rst = '1') then
                                  curr_state <= S0;
                            else
                                case curr_state is 
                                    when S0 => 
                                          if (datainready = '1') then
                                                  if (mode = '1') then
                                                      curr_state <= S1;
                                                  else 
                                                      curr_state <= S3;
                                                  end if;
                                          else
                                                  curr_state <= S0;
                                          end if;   
                                     when s1 => 
                                          if (mode = '1' and datainready = '1') then
                                                  curr_state <= S2;
                                          else 
                                                  curr_state <= S0;
                                          end if;
                                     when s2 => 
                                          if (mode = '1' and datainready = '1') then
                                                  curr_state <= S2;
                                          else 
                                                  curr_state <= S0;
                                          end if;
                                     when s3 => 
                                          if (mode = '0' and datainready = '1') then
                                                  curr_state <= S4;
                                          else 
                                                  curr_state <= S0;
                                          end if;
                                     when s4 => 
                                          if (mode = '0') then
                                                  curr_state <= S5;
                                          else 
                                                  curr_state <= S0;
                                          end if;
                                     when s5 => 
                                          if (mode = '0') then
                                                  curr_state <= S6;
                                          else 
                                                  curr_state <= S0;
                                          end if;
                                     when s6 => 
                                          if (mode = '0' and datainready = '1') then
                                                  curr_state <= S4;
                                          else 
                                                  curr_state <= S0;
                                          end if;
                                    when others =>  
                                          curr_state <= S0;
                                end case;
                            end if; 
                      end if;  
      end process ST_COMP_PROC;
end rtl;
      
    
    
    