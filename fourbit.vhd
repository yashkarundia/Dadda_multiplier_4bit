----------------------------------------------------------------------------------
-- Company: Sardar Patel Institute Of Technology

-- Engineer: Yash Karundia
-- 
-- Create Date:    12:35:42 04/23/2016 
-- Design Name: 
-- Module Name:    mymul - Behavioral 
-- Project Name: Dadda Multiplier- 4bit
-- Target Devices:  Spartan 6
-- Tool versions: Xilinx ISE
-- Description: 
--
-- Dependencies: 
--use work.and_4bit_pack.all;
--use work.add_3bit_pack.all;
--use work.add_2bit_pack.all;
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
---------------------
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD
-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponen


use work.and_4bit_pack.all;
use work.add_3bit_pack.all;
use work.add_2bit_pack.all;

library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity yash is
port(
	a   :in std_logic_vector(3 downto 0);
	b   :in std_logic_vector(3 downto 0);
	ans :out std_logic_vector(7 downto 0)
	);
end yash;

architecture dadda_mul_4bit of yash is
--Generation of partial product
signal mul_1 : std_logic_vector(3 downto 0);
signal mul_2 : std_logic_vector(3 downto 0);
signal mul_3 : std_logic_vector(3 downto 0);
signal mul_4 : std_logic_vector(3 downto 0);


--First Step
signal fst1_1 : std_logic_vector(6 downto 0);	
signal fst2_1 : std_logic_vector(4 downto 0);	
signal fst3_1 : std_logic_vector(5 downto 3);	
--Intermediate Step
signal int1_1 : std_logic_vector(6 downto 0);	
signal int1_2 : std_logic_vector(7 downto 0);	
signal chk1_1 : std_logic_vector(5 downto 3);	

--Second Step
signal snd1_1 : std_logic_vector(7 downto 0);	
--Third Step
signal thrd1_1 : std_logic_vector(7 downto 0);	

begin

mul_1<=and_4bit(b(0),a);
mul_2<=and_4bit(b(1),a);
mul_3<=and_4bit(b(2),a);
mul_4<=and_4bit(b(3),a);

--Step1 Work: Convert from 4 to 2 lines

fst1_1(0) <= mul_1(0);
fst1_1(1) <= mul_1(1);
fst1_1(2) <= sum_2bit(mul_1(2),mul_2(1));
fst1_1(3) <= sum_3bit(mul_1(3),mul_2(2),mul_3(1));
fst1_1(4) <= sum_2bit(mul_2(3),mul_3(2));
fst1_1(5) <= mul_3(3);
fst1_1(6) <= mul_4(3);

fst2_1(0) <= mul_2(0);
fst2_1(1) <= mul_3(0);
fst2_1(2) <= mul_4(0);
fst2_1(3) <= mul_4(1);
fst2_1(4) <= mul_4(2);


fst3_1(3) <= carry_2bit(mul_1(2),mul_2(1));
fst3_1(4) <= carry_3bit(mul_1(3),mul_2(2),mul_3(1));
fst3_1(5) <= carry_2bit(mul_2(3),mul_3(2));


--Intermediate Step:


int1_1(0) <= fst1_1(0) ;
int1_1(1) <= fst1_1(1) ;
int1_1(2) <= fst1_1(2) ;
int1_1(3) <= sum_2bit(fst1_1(3),carry_2bit(mul_1(2),mul_2(1)));
int1_1(4) <= sum_2bit(fst1_1(4),carry_3bit(mul_1(3),mul_2(2),mul_3(1)));
int1_1(5) <= sum_2bit(fst1_1(5),carry_2bit(mul_2(3),mul_3(2)));
int1_1(6) <= fst1_1(6) ;

chk1_1(3) <= carry_2bit(fst1_1(3),carry_2bit(mul_1(2),mul_2(1)));
chk1_1(4) <= carry_2bit(fst1_1(4),carry_3bit(mul_1(3),mul_2(2),mul_3(1)));
chk1_1(5) <= carry_2bit(fst1_1(5),carry_2bit(mul_2(3),mul_3(2)));

int1_2(0) <= fst1_1(0) ;
int1_2(1) <= fst1_1(1) ;
int1_2(2) <= fst1_1(2) ;
int1_2(3) <= sum_2bit(fst1_1(3),carry_2bit(mul_1(2),mul_2(1))) ;

int1_2(4) <= sum_2bit(int1_1(4),carry_2bit(fst1_1(3),carry_2bit(mul_1(2),mul_2(1)))) ;
int1_2(5) <= sum_3bit(int1_1(5),carry_2bit(fst1_1(4),carry_3bit(mul_1(3),mul_2(2),mul_3(1))),     carry_2bit(int1_1(4),carry_2bit(fst1_1(3),carry_2bit(mul_1(2),mul_2(1))))) ;
int1_2(6) <= sum_2bit(int1_1(6),carry_2bit(fst1_1(5),carry_2bit(mul_2(3),mul_3(2)))) ;
int1_2(7) <= carry_2bit(int1_1(6),carry_2bit(fst1_1(5),carry_2bit(mul_2(3),mul_3(2)))) ;

--Step2 Work: Convert from 2 lines to 1 line:
snd1_1(0) <= int1_2(0) ;
snd1_1(1) <= sum_2bit(int1_2(1),fst2_1(0)) ;
snd1_1(2) <= sum_2bit(int1_2(2),fst2_1(1)) ;
snd1_1(3) <= sum_2bit(int1_2(3),fst2_1(2)) ;
snd1_1(4) <= sum_2bit(int1_2(4),fst2_1(3)) ;
snd1_1(5) <= sum_2bit(int1_2(5),fst2_1(4)) ;
snd1_1(6) <= int1_2(6);
snd1_1(7) <= int1_2(7);

--Step 3 Work: Convert from 2lines to single line

thrd1_1(0) <= snd1_1(0);
thrd1_1(1) <= snd1_1(1);
thrd1_1(2) <= sum_2bit(snd1_1(2),carry_2bit(int1_2(1),fst2_1(0)));
thrd1_1(3) <= sum_3bit(snd1_1(3),carry_2bit(int1_2(2),fst2_1(1)),carry_2bit(snd1_1(2),carry_2bit(int1_2(1),fst2_1(0))));
thrd1_1(4) <= sum_3bit(snd1_1(4),carry_2bit(int1_2(3),fst2_1(2)),carry_3bit(snd1_1(3),carry_2bit(int1_2(2),fst2_1(1)),carry_2bit(snd1_1(2),carry_2bit(int1_2(1),fst2_1(0)))));
thrd1_1(5) <= sum_3bit(snd1_1(5),carry_2bit(int1_2(4),fst2_1(3)),carry_3bit(snd1_1(4),carry_2bit(int1_2(3),fst2_1(2)),carry_3bit(snd1_1(3),carry_2bit(int1_2(2),fst2_1(1)),carry_2bit(snd1_1(2),carry_2bit(int1_2(1),fst2_1(0))))));
thrd1_1(6) <= sum_3bit(snd1_1(6),carry_2bit(int1_2(5),fst2_1(4)),carry_2bit(snd1_1(5),carry_3bit(snd1_1(5),carry_2bit(int1_2(4),fst2_1(3)),carry_3bit(snd1_1(4),carry_2bit(int1_2(3),fst2_1(2)),carry_3bit(snd1_1(3),carry_2bit(int1_2(2),fst2_1(1)),carry_2bit(snd1_1(2),carry_2bit(int1_2(1),fst2_1(0))))))));
thrd1_1(7) <= sum_2bit(int1_2(7),carry_3bit(snd1_1(6),carry_2bit(int1_2(5),fst2_1(4)),carry_2bit(snd1_1(5),carry_3bit(snd1_1(5),carry_2bit(int1_2(4),fst2_1(3)),carry_3bit(snd1_1(4),carry_2bit(int1_2(3),fst2_1(2)),carry_3bit(snd1_1(3),carry_2bit(int1_2(2),fst2_1(1)),carry_2bit(snd1_1(2),carry_2bit(int1_2(1),fst2_1(0)))))))));
end architecture;
