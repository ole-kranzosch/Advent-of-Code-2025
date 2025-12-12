clear; close all;
%% Read input
inp = readlines("input.txt");
regions = inp(31:end);
fits = 0;
for i = 1:size(regions,1)
    row = regions(i);
    splt_row = strsplit(row,':');
    grid = double(strsplit(splt_row(1),'x'));
    presents = str2num(splt_row(2)); %#ok<ST2NM>
    if sum(presents)*7<=grid(1)*grid(2)
        fits = fits +1;
    end
end
sol1 = fits;
fprintf('Part 1 Solution: %d \n', sol1);
%% Part 2
sol2 = NaN;
fprintf('Part 2 Solution: %d \n', sol2);
