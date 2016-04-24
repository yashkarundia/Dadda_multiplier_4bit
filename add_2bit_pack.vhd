-- Company: Sardar Patel Institute Of Technology
-- Engineer: Yash Karundia
--
--
-- Create Date:    12:20:55 04/23/2016 
-- Design Name: 
-- Module Name:    adder_2bit - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
package add_2bit_pack is 
function sum_2bit(in1: std_logic; in2: std_logic) return std_logic;
function carry_2bit(in1: std_logic; in2: std_logic) return std_logic; 
end;

package body add_2bit_pack is
function sum_2bit(in1: std_logic; in2: std_logic) return std_logic is
begin
	return in1 xor in2;
end;

function carry_2bit(in1: std_logic; in2: std_logic) return std_logic is
begin
	return in1 and in2;
end;

end package body ;
