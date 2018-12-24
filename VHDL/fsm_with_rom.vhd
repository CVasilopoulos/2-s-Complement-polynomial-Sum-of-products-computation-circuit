library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.rom_constants.all;

entity fsm_with_rom is 
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
          romx : out std_logic_vector(ROM_LENGTH - 1 downto 0);
          romy : out std_logic_vector(ROM_LENGTH - 1 downto 0)
    );
end fsm_with_rom;

architecture str of fsm_with_rom is
    component rom
        port( 
              clk: in std_logic;
              rst: in std_logic;
              readdata : in std_logic; 
              datainready : out std_logic;
              address : out std_logic_vector(ROM_ROWS - 1 downto 0);
              romx : out std_logic_vector(ROM_LENGTH - 1 downto 0);
              romy : out std_logic_vector(ROM_LENGTH - 1 downto 0)
    );
    end component rom;
    
    component fsm
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
    end component fsm;
    
    signal read_data_i : std_logic;
    signal data_in_ready_i : std_logic;
    signal address_i: std_logic_vector(ROM_ROWS - 1 downto 0);
    
    begin
      
        U_ROM: rom port map(
                  clk => clk,
                  rst => rst,
                  readdata => read_data_i, 
                  datainready => data_in_ready_i,
                  address => address_i,
                  romx => romx,
                  romy => romy
        );
        
        U_FSM: fsm port map(
                  clk  => clk,
                  rst  => rst,
                  mode => mode,
                  datainready => data_in_ready_i,
                  address => address_i,
                  en1  => en1,
                  en2  => en2,
                  en3  => en3,
                  en4  => en4,
                  en5  => en5,
                  en6  => en6,
                  sel1 => sel1,
                  sel2 => sel2,
                  sel3 => sel3,
                  dataoutready => dataoutready,
                  readdata => read_data_i
        );
        
end str;
