clear;
%% Read input
inp = readlines("input.txt");inp = strsplit(inp,{',','-'});inp = reshape(inp,2,[])'; inp = str2double(inp);
N = size(inp,1);
invalid_IDs = 0;
for i = 1:N
    IDs = (inp(i,1):inp(i,2))';
    digits = floor(log10(IDs))+1;
    IDs(mod(digits,2)~=0) = [];
    digits(mod(digits,2)~=0) = [];
    p1 = floor(IDs./(10.^(digits/2)));
    p2 = IDs-p1.*10.^(digits/2);
    p = [p1 p2];
    invalid_IDs = invalid_IDs + sum(IDs(p1==p2));
end
fprintf('Part 1 Solution: %d \n', invalid_IDs);
%% Part 2 (maximum digits = 10)
invalid_IDs = 0;
for i = 1:N
    IDs = (inp(i,1):inp(i,2))';
    digits = floor(log10(IDs))+1;
    U_digits = unique(digits);
    for k = 1:numel(U_digits)
        packs = divisors(U_digits(k));
        IDs_k=IDs(digits==U_digits(k));
        digits_k=digits(digits==U_digits(k));
        IDs_mat = num2str(IDs_k)-'0';
        is_invalid = false(numel(IDs_k),1);
        for d = 1:(numel(packs)-1)       
            if d == 1
                is_invalid = all(IDs_mat==IDs_mat(:,1),2) | is_invalid;
            else
                if U_digits(k) == 4
                    is_invalid = all(IDs_mat(:,1:2) == IDs_mat(:,3:4),2) | is_invalid;
                elseif U_digits(k) == 6
                    if d == 2
                        is_invalid = all(IDs_mat(:,1:3) == IDs_mat(:,4:6),2) | is_invalid;
                    else
                        is_invalid = all((IDs_mat(:,1:2) == IDs_mat(:,3:4)) & (IDs_mat(:,1:2) == IDs_mat(:,5:6)),2) | is_invalid;
                    end
                elseif U_digits(k) == 8
                    if d == 2
                        is_invalid = all(IDs_mat(:,1:4) == IDs_mat(:,5:8),2) | is_invalid;
                    else
                        is_invalid = all((IDs_mat(:,1:2) == IDs_mat(:,3:4)) & (IDs_mat(:,1:2) == IDs_mat(:,5:6)) & (IDs_mat(:,1:2) == IDs_mat(:,7:8)),2) | is_invalid;
                    end
                elseif U_digits(k) == 9
                    is_invalid = all((IDs_mat(:,1:3) == IDs_mat(:,4:6)) & (IDs_mat(:,1:3) == IDs_mat(:,7:9)),2) | is_invalid;
                elseif U_digits(k) == 10
                    if d == 2
                        is_invalid = all(IDs_mat(:,1:5) == IDs_mat(:,6:10),2) | is_invalid;
                    else
                        is_invalid = all((IDs_mat(:,1:2) == IDs_mat(:,3:4)) & (IDs_mat(:,1:2) == IDs_mat(:,5:6)) & (IDs_mat(:,1:2) == IDs_mat(:,7:8)) & (IDs_mat(:,1:2) == IDs_mat(:,9:10)),2) | is_invalid;
                    end
                end
            end
        end
        invalid_IDs = invalid_IDs + sum(IDs_k(is_invalid));
    end
end
fprintf('Part 2 Solution: %d \n', invalid_IDs);
