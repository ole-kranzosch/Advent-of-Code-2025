clear; close all;
%% Read input
inp = readlines("input.txt");
N = size(inp,1);
nodes = zeros(N+1,2);
A = zeros(N+1);
for i = 1:N
    row = char(inp(i,:));
    in(i,:) = row(1:3);  
end
for i = 1:N
    row = char(inp(i,:));
    out = strsplit(row(6:end),' ');
    if ~any(all(in==out{1},2))
        A(i,end)= 1;
    else
        idx = cellfun(@(x)(find(all(in==x,2))),out);
        A(i,idx)= 1;
    end
end
G = digraph(A);
paths = allpaths(G,find(all(in=='you',2)),N+1);
sol1 = size(paths,1);
fprintf('Part 1 Solution: %d \n', sol1);
%% Part 2
dac = find(all(in=='dac',2));
fft = find(all(in=='fft',2));
svr = find(all(in=='svr',2));
paths2svrfft = allpaths(G,svr,fft);
paths2fftdac = allpaths(G,fft,dac);
paths2dacout = allpaths(G,dac,N+1);

sol2 = size(paths2svrfft,1)*size(paths2fftdac,1)*size(paths2dacout,1);
fprintf('Part 2 Solution: %d \n', sol2);
