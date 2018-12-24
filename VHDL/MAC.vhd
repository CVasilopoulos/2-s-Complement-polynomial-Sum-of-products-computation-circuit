-- Filename: MAC.vhd 
-- Author: Christos Vasilopoulos
-- Description: Mac component 
-- Date: 22/5/2015

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use work.my_constants.all;

entity MAC is
   port( 
        mult1 : in std_logic_vector(K - 1 downto 0);
      	 mult2 : in std_logic_vector(K - 1 downto 0);
      	 a     : in std_logic_vector(2 * K - 1 downto 0);
      	 y     : out std_logic_vector(2 * K - 1 downto 0)
	 );
end MAC;

architecture rtl of MAC is
signal p   : std_logic_vector(2 * K - 1 downto 0);
signal sum : std_logic_vector(2 * K - 1 downto 0);
signal sign_i : std_logic_vector(K - 4 downto 0);
signal temp: std_logic;

begin
  
  MAC_PROC: process(mult1, mult2, a, p, sum, sign_i, temp)
    begin
      p <= mult1 * mult2; 
      sum<= p + a; 
      sign_i <= p(2 * K - 1) & a(2 * K - 1);
      temp <= sum(2 * K - 1);
		  case sign_i is
				  when "11"=>   
			         if (sum >= MIN_V and temp = '1'  ) then
				           y <= sum;
				       else
				           y <= MIN_V;  
				       end if; 
			     when "00"=>  
			         if (sum <= MAX_V and temp = '0' ) then
					         y <= sum;
				       else
					         y <= MAX_V;   
				       end if;
			    
			     when others=>  
			          if (sum>=MAX_V and  temp = '0' ) then 
					         	y <= MAX_V;
				        else 
					         if (sum<=MIN_V and  temp = '1' ) then
					             y <= MIN_V;
				           else
						           y <= sum;
						      end if;
				        end if;
	   end case;
	end process MAC_PROC;
end rtl;


