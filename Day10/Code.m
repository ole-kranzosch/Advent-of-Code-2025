clear; close all;
if isempty(gcp('nocreate'))
parpool("threads")
end
%% Read input
inp = readlines("input.txt");
N = size(inp,1);
presses = inf(N,1);
for i = 1:N
    A = char(inp(i,:));

    lights = A(find(A=='[')+1:find(A==']')-1);
    lights = str2num(replace(lights,{'.','#'},{'0,','1,'})); %#ok<ST2NM>
    buttons = A(find(A==']')+2:find(A=='{')-1);
    buttons = replace(buttons,{'(',')'},'');
    buttons = textscan(buttons,'%s','Delimiter',' ')';
    buttons = buttons{1};
    buttons = cellfun(@(x)(str2num(x)+1),buttons,'UniformOutput',false); %#ok<ST2NM>
    M = size(buttons,1);
    stop = 0;
    lit = find(lights);
    iters = decimalToBinaryVector(1:2^M-1);
    [~,pt] = sort(sum(iters,2));
    iters = iters(pt,:);
    for k = 1:2^M-1
        idx = find(flip(iters(k,:)));
        for p = 1:numel(idx)
            if p == 1
                b = buttons{idx(1)};
            else
                b = setxor(b,buttons{idx(p)});
            end
        end
        if size(lit,2) == size(b,2)
            if all(lit==b)
                presses(i) = numel(idx);
                break
            end
        end
    end

end
fprintf('Part 1 Solution: %d \n', sum(presses));
%% Part 2
presses = zeros(N,1);
opts = optimoptions("intlinprog","Display","none");
for i = 1:N
    A = char(inp(i,:));

    jol = A(find(A=='{')+1:find(A=='}')-1);
    jol = str2num(jol); %#ok<ST2NM>
    buttons = A(find(A==']')+2:find(A=='{')-1);
    buttons = replace(buttons,{'(',')'},'');
    buttons = textscan(buttons,'%s','Delimiter',' ')';
    buttons = buttons{1};
    buttons = cellfun(@(x)(getButton(x,numel(jol))),buttons,'UniformOutput',false);
    M = size(buttons,1);
    L = [];
    for k = 1:M
        L(:,k) = buttons{k};
    end
    x = intlinprog(ones(M,1),1:M,[],[],L,jol',zeros(M,1),inf(M,1),[],opts);
    presses(i) = sum(x);

end
fprintf('Part 2 Solution: %d \n', sum(presses));

function B = getButton(x,n)
    B = zeros(1,n);
    B(str2num(x)+1) = 1; %#ok<ST2NM>
end