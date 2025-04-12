----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.04.2025 10:52:31
-- Design Name: 
-- Module Name: tb_redundancia - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_redundancia is
--  Port ( );
end tb_redundancia;

architecture Behavioral of tb_redundancia is

    component redundancia
        generic (SIMULATION_MODE : boolean := true);
        port (
            CLK100MHZ : in STD_LOGIC;
            RESET : in STD_LOGIC;
            SW : in STD_LOGIC_VECTOR (0 downto 0);
            LED : out STD_LOGIC_VECTOR (7 downto 0);
            LED_CONTADOR_1 : out STD_LOGIC;
            LED_CONTADOR_2 : out STD_LOGIC;
            AN : out STD_LOGIC_VECTOR (7 downto 0);
            SEG : out STD_LOGIC_VECTOR (6 downto 0)
        );
    end component;

    signal CLK100MHZ : STD_LOGIC := '0';
    signal RESET : STD_LOGIC := '1';
    signal SW : STD_LOGIC_VECTOR(0 downto 0) := "0";
    signal LED : STD_LOGIC_VECTOR(7 downto 0);
    signal LED_CONTADOR_1 : STD_LOGIC;
    signal LED_CONTADOR_2 : STD_LOGIC;
    signal AN : STD_LOGIC_VECTOR(7 downto 0);
    signal SEG : STD_LOGIC_VECTOR(6 downto 0);

    constant CLK_PERIOD : time := 10 ns; -- 100MHz = 10 ns

begin

    uut: redundancia
        generic map (SIMULATION_MODE => true)
        port map (
            CLK100MHZ => CLK100MHZ,
            RESET => RESET,
            SW => SW,
            LED => LED,
            LED_CONTADOR_1 => LED_CONTADOR_1,
            LED_CONTADOR_2 => LED_CONTADOR_2,
            AN => AN,
            SEG => SEG
        );

    clk_process : process
    begin
        while now < 100 us loop
            CLK100MHZ <= '0';
            wait for CLK_PERIOD / 2;
            CLK100MHZ <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;

    funcionamiento_proc : process
    begin
        RESET <= '0';       -- Activamos el reset
        wait for 50 ns;     -- Esperamos un poco
        RESET <= '1';       -- Desactivamos el reset

        -- Cambiamos al contador2
        SW <= "1";
        wait for 2000 ns;

        -- Volvemos al contador1
        SW <= "0";
        wait for 2000 ns;

        -- Cambiamos al contador2
        SW <= "1";
        wait for 10000 ns;
        
        -- Volvemos al contador1
        SW <= "0";
        wait for 13000 ns;

        assert false report "Fin de la simulación" severity failure;
    end process;
end Behavioral;