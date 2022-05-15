library ieee;
use ieee.std_logic_1164.all;

entity soustracteur is
    generic( 
        N: integer := 8
    );
    port(
        A:   in  std_logic_vector(N downto 1);
        B:   in  std_logic_vector(N downto 1);
        Q:   out std_logic_vector(N downto 1);
        OVF: out std_logic                      
    );
end;

architecture behavior of soustracteur is
    component complement_deux
        generic (
            cN : integer := 8
        );
        port (
            VEC_BIN:   in  std_logic_vector(cN downto 1);
            BIN_C2:    out std_logic_vector(cN downto 1);
            OVF:       out std_logic
        );
    end component;
    
    component additionneur_n_bits
        generic(
            N : integer := 8
        );
        port(
            A:    in  std_logic_vector(N downto 1);
            B:    in  std_logic_vector(N downto 1);
            Cin:  in  std_logic;
            Q:    out std_logic_vector(N downto 1);
            Cout: out std_logic
        );
    end component;
    signal s_COMPB: std_logic_vector(N downto 1);
    signal s_Q:     std_logic_vector(N downto 1);
begin
    comp2: complement_deux
        generic map(
            cN => N
        )
        port map(
            VEC_BIN => B,
            BIN_C2  => s_COMPB,
            OVF     => open
        );
        
    adder: additionneur_n_bits
        generic map(
            N => N
        )
        port map(
            A    => A,
            B    => s_COMPB,
            Q    => s_Q,
            Cin  => '0',
            Cout => open
        );
    OVF <= '1' when (A(N) = s_COMPB(N)) and (s_Q(N) /= A(N)) else '0';
    Q   <= s_Q;
end behavior;
