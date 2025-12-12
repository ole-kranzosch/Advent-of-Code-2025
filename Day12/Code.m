clear; close all;
%% Read input
inp = readlines("input.txt");
shapes = inp(1:30);
for i = 1:5
    st = 5*(i-1)+2;
    shape_mat(:,:,i) = char(shapes(st:st+2))-'0';
end
shape_mat(shape_mat==-13)=1;
shape_mat(shape_mat==-2)=0;
regions = inp(31:end);
fits = 0;
for i = 1:size(regions,1)
    row = regions(i);
    splt_row = strsplit(row,':');
    grid = double(strsplit(splt_row(1),'x'));
    grid = zeros(grid(2),grid(1));
    presents = str2num(splt_row(2)); %#ok<ST2NM>
    if sum(presents)*7<=size(grid,1)*size(grid,2)
        fits = fits +1;
    end
end
sol1 = fits;
fprintf('Part 1 Solution: %d \n', sol1);
%% Part 2
sol2 = NaN;
fprintf('Part 2 Solution: %d \n', sol2);
