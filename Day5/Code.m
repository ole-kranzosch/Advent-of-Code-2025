clear;
%% Read input
inp = readlines("input.txt");
idx1 = find(inp=="");
ID_ranges = inp(1:idx1-1);
IDs = inp(idx1+1:end);
ID_ranges = str2num(char(strrep(ID_ranges,'-',','))); %#ok<ST2NM>
IDs = str2double(IDs);
N = numel(IDs);
n_ranges = size(ID_ranges,1);
fresh_no = 0;
for i = 1:N
   for k = 1:n_ranges
       if (IDs(i) >= ID_ranges(k,1)) & (IDs(i) <= ID_ranges(k,2))
            fresh_no = fresh_no + 1;
            break;
       end   
   end
end
fprintf('Part 1 Solution: %d \n', fresh_no);
%% Part 2
ID_ranges = sortrows(ID_ranges);
idx2 = true(1,n_ranges);
k1 = unique(ID_ranges(:,1));
for k = 1:numel(k1)
    ranges = ID_ranges(ID_ranges(:,1) == k1(k),:);
    maxi = max(ranges(:,2));
    idx2((ID_ranges(:,1) == k1(k)) & (ID_ranges(:,2)<maxi)) = 0;
end
ID_ranges = ID_ranges(idx2,:);
n_ranges = size(ID_ranges,1);
tot_fresh_no = ID_ranges(1,2)-ID_ranges(1,1)+1;
for k = 2:n_ranges
        if ID_ranges(k,1)> ID_ranges(k-1,2)
            tot_fresh_no = tot_fresh_no + ID_ranges(k,2)-ID_ranges(k,1)+1;
        elseif ID_ranges(k,1)== ID_ranges(k-1,2)
            tot_fresh_no = tot_fresh_no + ID_ranges(k,2)-ID_ranges(k,1);
        elseif (ID_ranges(k,1)< ID_ranges(k-1,2)) & (ID_ranges(k,2)> ID_ranges(k-1,2))
            tot_fresh_no = tot_fresh_no + ID_ranges(k,2)-ID_ranges(k-1,2);
        end
end
fprintf('Part 2 Solution: %d \n', tot_fresh_no);
