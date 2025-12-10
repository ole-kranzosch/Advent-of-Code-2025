clear;
%% Read input
inp = char(readlines("input.txt"))-'0'; inp(inp==-2) = 0; inp(inp==16) = 1;
neighbours = conv2(inp,[1 1 1; 1 0 1; 1 1 1],'same');
fprintf('Part 1 Solution: %d \n', sum(neighbours<4 & inp,"all"));
%% Part 2
rolls = inp;
rem_rolls = 0;
rem_rolls_current = 1;
while rem_rolls_current ~= 0
    neighbours = conv2(rolls,[1 1 1; 1 0 1; 1 1 1],'same');
    rem_rolls_current = sum(neighbours<4 & rolls,"all");
    rem_rolls = rem_rolls + rem_rolls_current;
    rolls((inp == 1) & ((neighbours<4 & rolls) == 1)) = 0;
end
fprintf('Part 2 Solution: %d \n', rem_rolls);
