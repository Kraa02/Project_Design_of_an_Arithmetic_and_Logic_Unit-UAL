library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

 entity test_ual_n_bits is
  generic (N : integer :=8);
end entity;

 architecture arc of test_ual_n_bits is
signal C : std_logic_vector (2 downto 0);
signal A,B,R : std_logic_vector ((N) downto 1);
signal clock,reset,overf,CF,ZF,SF,PF,egal : std_logic; 
 component ual_n_bits is
port (
A,B : in std_logic_vector ((N) downto 1);
C : in std_logic_vector (2 downto 0);
clock,reset: in std_logic;
R : out std_logic_vector ((N) downto 1);
CF,ZF,SF,PF,egal, overf: out std_logic
);
end component;
begin
inst_ual_en_test : ual_n_bits port map (A, B, C, clock, reset, R, CF, ZF, SF, PF,egal, overf);

 process
begin
clock <= '0';
wait for 5 ns;
clock <= '1';
wait for 5 ns;
 end process;

 process
begin
reset <= '1';
wait for 0 ns;
reset <= '0';
wait for 0 ns;
--end process;
 
--process
--begin
C <= "000";
A <= "00000000";
B <= "11110111";
wait for 5 ns;
A <= "11111111";
B <= "11101111";
wait for 5 ns;
A <= "01001000";
B <= "00110000";
wait for 5 ns;

C <= "001";
A <= "00000000";
B <= "11110111";
wait for 5 ns;
A <= "11111111";
B <= "11101111";
wait for 5 ns;
A <= "01001000";
B <= "00110000";
wait for 5 ns;

C <= "010";
A <= "00000000";
B <= "11110111";
wait for 5 ns;
A <= "11111111";
B <= "11101111";
wait for 5 ns;
A <= "01001000";
B <= "00110000";
wait for 5 ns;

C <= "011";
A <= "00000000";
B <= "11110111";
wait for 5 ns;
A <= "11111111";
B <= "11101111";
wait for 5 ns;
A <= "01001000";
B <= "00110000";
wait for 5 ns;

C <= "100";
A <= "00000000";
B <= "11110111";
wait for 5 ns;
A <= "11111111";
B <= "11101111";
wait for 5 ns;
A <= "01001000";
B <= "00110000";
wait for 5 ns;

C <= "101";
A <= "00000000";
B <= "11110111";
wait for 5 ns;
A <= "11111111";
B <= "11101111";
wait for 5 ns;
A <= "01001000";
B <= "00110000";
wait for 5 ns;

C<= "110";
A <= "00000000";
B <= "11110111";
wait for 5 ns;
A <= "11111111";
B <= "11101111";
wait for 5 ns;
A <= "01001000";
B <= "00110000";
wait for 5 ns;

C<= "111";
A <= "00000000";
B <= "11110111";
wait for 5 ns;
A <= "11111111";
B <= "11101111";
wait for 5 ns;
A <= "01001000";
B <= "00110000";
wait for 5 ns;

 end process;
end arc;