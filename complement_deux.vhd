library ieee;
use ieee.std_logic_1164.all;

entity complement_deux is 
    generic ( cN : integer := 8);
    port (
        VEC_BIN:   in  std_logic_vector(cN downto 1);
        BIN_C2:    out std_logic_vector(cN downto 1);
        OVF:       out std_logic
    );
end;

architecture structurelle of complement_deux is
    component additionneur_n_bits
        generic ( N : integer := 8);
        port (
            A:   in std_logic_vector(N downto 1);
            B:   in std_logic_vector(N downto 1);
            Cin: in std_logic;
            Q:    out std_logic_vector(N downto 1);
            Cout: out std_logic
        );
    end component;
    
    signal s_VEC_BIN: std_logic_vector(cN downto 1);
    signal s_B:       std_logic_vector(cN downto 1) := (cN downto 1 => '0');
    signal s_Cin:     std_logic;
    signal s_BIN_C2:  std_logic_vector(cN downto 1);
    signal s_Cout:    std_logic;

begin
    additionneur_n: additionneur_n_bits
        generic map(
            N => cN
        )
        port map(
            A    => s_VEC_BIN,
            B    => s_B,
            Cin  => s_Cin,
            Q    => s_BIN_C2,
            Cout => s_Cout
        );
        
    s_VEC_BIN <= not VEC_BIN;
    
    s_Cin <= '0';
    
    s_B(1) <= '1';

    BIN_C2 <= s_BIN_C2;
    
    OVF <= s_Cout;
end structurelle;