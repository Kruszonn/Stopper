
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity stopwatch_tb is
end stopwatch_tb;

architecture Behavioral of stopwatch_tb is
    component top is
         port( 
             clk_i : in STD_LOGIC;
             rst_i : in STD_LOGIC;
             start_stop_button_i : in STD_LOGIC;
             led7_an_o : out STD_LOGIC_VECTOR (3 downto 0);
             led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0)
            );
    end component top;
    
    constant PERIOD : time := 10ns;
    
    signal clk : std_logic := '0';
    signal rst : std_logic := '0';
    signal start_stop_button : std_logic := '0';
    signal led7_an_o : STD_LOGIC_VECTOR (3 downto 0) := "0000";
    signal led7_seg_o : STD_LOGIC_VECTOR (7 downto 0) := "00000000";
       
begin
    uut: top
    port map(
        clk_i => clk,
        rst_i => rst,
        start_stop_button_i => start_stop_button,
        led7_an_o => led7_an_o,
        led7_seg_o => led7_seg_o
    );
    
    clk <= not clk after period/2;
    
    tb: process 
    begin
        wait for 1ms;
        start_stop_button <= '1';
        wait for 60ms;
        start_stop_button <= '0';
        
        wait for 200ms;
        
        start_stop_button <= '1';
        wait for 60ms;
        start_stop_button <= '0';
        
        wait for 50ms;
        
        start_stop_button <= '1';
        wait for 60ms;
        start_stop_button <= '0';
        
        wait;
    end process;

end Behavioral;
