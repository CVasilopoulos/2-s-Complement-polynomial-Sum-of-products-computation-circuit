library ieee;
use ieee.std_logic_1164.all;

-- ROM CONSTANTS

package rom_constants is 
  constant ROM_ROWS: integer := 8;
  constant ROM_LENGTH: integer := 5;
  subtype ROM_ENTRY is std_logic_vector(ROM_LENGTH - 1 downto 0);
  type ROM_MATRIX is array (0 to ROM_ROWS - 1) of ROM_ENTRY;
  constant ROM_X_ENTRIES: ROM_MATRIX :=(	
              "01110",
              "01001",
              "11101",
              "01001",
              "00100",
              "01010",
              "01110",
              "10110"	
    );
    constant ROM_Y_ENTRIES: ROM_MATRIX :=(	
              "11111",
              "10100",
              "01100",
              "01110",
              "10001",
              "01101",
              "11000",
              "00011"
    );	
    
end rom_constants;
