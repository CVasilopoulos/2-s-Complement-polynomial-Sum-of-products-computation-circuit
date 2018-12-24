library ieee;
use ieee.std_logic_1164.all;

-- COMPONENT CONSTANTS

package my_constants is 
  constant K   : integer := 5;
  constant MIN_V : std_logic_vector(2 * K - 1 downto 0) := "1110000000";
  constant MAX_V : std_logic_vector(2 * K - 1 downto 0) := "0001111111";
  
 
end my_constants; 


