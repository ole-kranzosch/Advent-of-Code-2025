clear;
%% Read input
inp = readmatrix("input.txt");
M = 1000;
N = size(inp,1);
D = pdist2(inp,inp,'euclidean');
D_arr = tril(D,-1);
D_arr(D_arr == 0) = inf;
distances = mink(D_arr(:),M);
circuits = {};
k = 1;
for i = 1:M
    dist = distances(i);
    [rows, cols] = find(D_arr == dist);
    id = 0;
    for k = 1:size(circuits,1)
        if ismember(rows,circuits{k,1}) | ismember(cols,circuits{k,1})
            circuits{k,1} = unique([circuits{k,1}, rows, cols]);
            id = 1;
            rem_idx = false(size(circuits));
            for j = k+1:size(circuits,1)
                if ismember(rows,circuits{j,1}) | ismember(cols,circuits{j,1})
                    circuits{k,1} = unique([circuits{k,1}, circuits{j,1}]);
                    rem_idx(j) = 1;
                end
            end
            circuits(rem_idx) = [];
            break;
        end
    end
    if id == 0
        circuits{end+1,1} = [rows, cols];
    end
end
fprintf('Part 1 Solution: %d \n', prod(maxk(cellfun(@numel,circuits),3)));
%% Part 2
%% Read input
inp = readmatrix("input.txt");
M = M^2;
N = size(inp,1);
D = pdist2(inp,inp,'euclidean');
D_arr = tril(D,-1);
D_arr(D_arr == 0) = inf;
distances = mink(D_arr(:),M);
circuits = {};
k = 1;
for i = 1:M
    dist = distances(i);
    [rows, cols] = find(D_arr == dist);
    id = 0;
    for k = 1:size(circuits,1)
        if ismember(rows,circuits{k,1}) | ismember(cols,circuits{k,1})
            circuits{k,1} = unique([circuits{k,1}, rows, cols]);
            id = 1;
            rem_idx = false(size(circuits));
            for j = k+1:size(circuits,1)
                if ismember(rows,circuits{j,1}) | ismember(cols,circuits{j,1})
                    circuits{k,1} = unique([circuits{k,1}, circuits{j,1}]);
                    rem_idx(j) = 1;
                end
            end
            circuits(rem_idx) = [];
            break;
        end
    end
    if id == 0
        circuits{end+1,1} = [rows, cols];
    end
    if (size(circuits,1) == 1) & (size(circuits{1},2) == N)
        sol2 = inp(rows,1)*inp(cols,1);
        break;
    end
end
fprintf('Part 2 Solution: %d \n', sol2);
