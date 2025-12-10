clear;
%% Read input
inp = readlines("input.txt");
inp = strrep(inp,'+','0.1');
inp = strrep(inp,'*','0.2');
inp = str2num(char(inp)); %#ok<ST2NM>
sum_mat = inp(1:end-1,inp(end,:)==0.1);
mul_mat = inp(1:end-1,inp(end,:)==0.2);
sol1 = sum(sum(sum_mat,1)) + sum(prod(mul_mat,1));
fprintf('Part 1 Solution: %d \n', sol1);
%% Part 2
inp = char(readlines("input.txt"));
[~,col2] = find(all(inp==' '));
sol2 = 0;
for i = 1:numel(col2)+1
    if i ==1
        df = inp(:,1:col2(i)-1);     
    elseif i<=numel(col2)
        df = inp(:,col2(i-1)+1:col2(i)-1);
    else
        df = inp(:,col2(i-1)+1:end);
    end
    N = size(df,2);
    if any(df=='+',"all")
        sol = 0;
        for k = 1:N
            sol = sol + str2double(df(1:end-1,k));
        end        
    else
        sol = 1;
        for k = 1:N
            sol = sol * str2double(df(1:end-1,k));
        end 
    end
    sol2 = sol2 + sol;
end
fprintf('Part 2 Solution: %d \n', sol2);
