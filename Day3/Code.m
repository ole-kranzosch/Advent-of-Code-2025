clear;
%% Read input
inp = char(readlines("input.txt"))-'0';
N = size(inp,1);
[~, col1] = max(inp(:,1:end-1) == max(inp(:,1:end-1),[],2),[],2);
total_jol = 0;
for i = 1:N
    b1 = inp(i,col1(i));
    bank = inp(i,:);
    b2 = max(bank((col1(i)+1):end));
    jol = b1*10+b2;
    total_jol = total_jol + jol;
end
fprintf('Part 1 Solution: %d \n', total_jol);
%% Part 2


total_jol = 0;
for i = 1:N
    bank = inp(i,:);
    col1 = 1;
    b = zeros(12,1);
    for k = 1:12       
        rem_bank = bank(:,col1:end-(12-k));
        [~, col2] = max(rem_bank == max(rem_bank,[],2),[],2);
        b(k) = rem_bank(col2);
        col1 = col2 + col1;
        
    end
        jol = 10.^(11:-1:0)*b;
        total_jol = total_jol + jol;
end
fprintf('Part 2 Solution: %d \n', total_jol);
