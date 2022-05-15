library ieee;
use ieee.std_logic_1164.all;

entity decalage_gauche is
    generic(
        N: integer := 8
    );
    port(
        A: in  std_logic_vector(N downto 1);
        B: out std_logic_vector(N downto 1)
    );
end;

architecture behavior of decalage_gauche is
    signal s_tmp: std_logic_vector(N downto 1);
begin
    main_process: process(A)
    begin
        s_tmp(1) <= '0';
        shift_loop: for i in 1 to (N-1) loop
            s_tmp(i+1) <= A(i);
        end loop shift_loop;
    end process;
    B <= s_tmp;
end;
