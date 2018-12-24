-- Filename: datapath.vhd 
-- Author: Christos Vasilopoulos
-- Description: Data path component 
-- Date: 19/5/2015

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use work.my_constants.all;


entity datapath is
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
end datapath;

architecture str of datapath is
  component register_N_bits
      generic(N : integer := 5);
        port(   
             d:    in std_logic_vector(N - 1 downto 0);
             clk:  in std_logic;
             rst:  in std_logic;
             en:   in std_logic;
             q:    out std_logic_vector(N - 1 downto 0)
        );
  end component register_N_bits;
  
  
  component mux is
      generic(N : integer := 5);
        port( 
            in1  : in std_logic_vector(N - 1 downto 0);
      	     in2  : in std_logic_vector(N - 1 downto 0);
      	     sel  : in std_logic;
      	     out1 : out std_logic_vector(N - 1 downto 0)
  	     );
  end component mux;
  
  component MAC
      port( 
          mult1 : in std_logic_vector(K - 1 downto 0);
          mult2 : in std_logic_vector(K - 1 downto 0);
          a  : in std_logic_vector(2 * K - 1 downto 0);
          y  : out std_logic_vector(2 * K - 1 downto 0)
      );
  end component MAC;
  
  signal sign_extension_i : std_logic_vector(N - 4 downto 0);
  signal fract_extension_i : std_logic_vector(N - 3 downto 0);
  signal mux2_in1_i : std_logic_vector(2 * N - 1 downto 0);
  signal reg_out1_i : std_logic_vector(N - 1 downto 0);
  signal reg_out2_i : std_logic_vector(N - 1 downto 0);
  signal reg_out3_i : std_logic_vector(N - 1 downto 0);
  signal reg_out4_i : std_logic_vector(N - 1 downto 0);
  signal reg_out5_i : std_logic_vector(2 * N - 1 downto 0);
  signal reg_out6_i : std_logic_vector(2 * N - 1 downto 0);
  signal mac_out_i  : std_logic_vector(2 * N - 1 downto 0);
  signal mux_out1_i : std_logic_vector(N - 1 downto 0);
  signal mux_out2_i : std_logic_vector(2 * N - 1 downto 0);
  signal mux_out3_i : std_logic_vector(N - 1 downto 0);
  
begin 

U_REG1:  register_N_bits generic map(N => 5)
              port map(   
                        d   => x,
                        clk => clk,
                        rst => rst,
                        en  => en1,
                        q   => reg_out1_i
              );
              
        
U_REG2:  register_N_bits generic map(N => 5)
              port map(   
                        d   => y,
                        clk => clk,
                        rst => rst,
                        en  => en2,
                        q   => reg_out2_i
                );
                
                
U_REG3:  register_N_bits generic map(N => 5)
              port map(   
                        d   => y,
                        clk => clk,
                        rst => rst,
                        en  => en3,
                        q   => reg_out3_i
              );
             
              
U_REG4:  register_N_bits generic map(N => 5)
              port map(   
                        d   => x,
                        clk => clk,
                        rst => rst,
                        en  => en4,
                        q   => reg_out4_i
              );
              
              
U_REG5:  register_N_bits generic map(N => 10)
              port map(   
                        d   => mac_out_i,
                        clk => clk,
                        rst => rst,
                        en  => en5,
                        q   => reg_out5_i
              );
              
              
U_REG6:  register_N_bits generic map(N => 10)
              port map(   
                        d   => mac_out_i,
                        clk => clk,
                        rst => rst,
                        en  => en6,
                        q   => reg_out6_i
              );
              
              
U_MUX1:   mux generic map(N => 5) 
              port map( 
                        in1  => reg_out2_i, 
      	                 in2  => reg_out5_i(2 * N - 3 downto N - 2),  
    	                   sel  => sel1,  
    	                   out1 => mux_out1_i
	            );
	            
	       
sign_extension_i  <= (others => mux_out3_i(N - 1));
fract_extension_i <= (others => '0');
mux2_in1_i <= (sign_extension_i & mux_out3_i & fract_extension_i);
	            
U_MUX2:   mux generic map(N => 10) 
              port map( 
                        in1  => mux2_in1_i, 
      	                 in2  => reg_out5_i,  
    	                   sel  => sel2,  
    	                   out1 => mux_out2_i
	            );
	            
	            
U_MUX3:   mux generic map(N => 5) 
              port map( 
                        in1  => reg_out4_i, 
      	                 in2  => reg_out3_i,  
    	                   sel  => sel3,  
    	                   out1 => mux_out3_i
	            );
	            
        
        
U_MAC:    MAC 
              port map( 
                        mult1 => reg_out1_i,
      	                 mult2 => mux_out1_i,
    	                   a     => mux_out2_i,
    	                   y     => mac_out_i
	            );
	            


r <= reg_out6_i(2 * N - 3 downto N - 2);

end str;


  
