clear;
%% Read input
inp = readlines("input.txt");inp = strrep(inp,"L","-");inp = strrep(inp,"R","+");inp = str2double(inp);
dial_pos = 50;
N = numel(inp);
positions = [50 zeros(1,N)]';
for i = 1:N

    dial_pos = mod(dial_pos+inp(i),100);
    positions(i+1) = dial_pos;

end
fprintf('Part 1 Solution: %d \n', sum(positions==0));
fprintf('Part 2 Solution: %d \n', sum((positions(1:end-1)+sign(inp).*mod(abs(inp),100)<1 | positions(1:end-1)+sign(inp).*mod(abs(inp),100)>99) & (positions(1:end-1)~=0)) + sum(floor(abs(inp)/100)));
