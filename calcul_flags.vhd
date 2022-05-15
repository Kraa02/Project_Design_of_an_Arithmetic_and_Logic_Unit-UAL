library ieee;
use ieee.std_logic_1164.all;

entity calcul_flags is
    generic(
        N: integer := 8
    );
    port(
        A:  in  std_logic_vector(N downto 1);
        SF: out std_logic;
        ZF: out std_logic;
        PF: out std_logic
    );
end;

architecture behavior of calcul_flags is
    signal s_pf_counter: integer := 0;
    signal s_zf_counter: integer := 0;
begin
    main_process: process(A)
    variable v_pf_counter: integer := 0;
    variable v_zf_counter: integer := 0;
    begin
        v_pf_counter := 0;
        v_zf_counter := 0;

        flag_loop: for i in 1 to N loop

            if( A(i) = '1' ) then
                v_pf_counter := v_pf_counter + 1;
            else
                v_zf_counter := v_zf_counter + 1;
            end if;
            
        end loop flag_loop;

        s_pf_counter <= v_pf_counter;
        s_zf_counter <= v_zf_counter;
    end process;

    ZF <= '1'when (s_zf_counter = N) and (s_pf_counter = 0) else '0';
    PF <= '1' when (s_pf_counter /= 0) and ((s_pf_counter mod 2) = 0) else '0';
    SF <= A(N);
end;
