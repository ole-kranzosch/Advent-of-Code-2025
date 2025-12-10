clear; close all;
%% Read input
inp = readmatrix("input.txt");
D = pdist2(inp,inp,'cityblock');
D_arr = tril(D,-1);
D_arr(D_arr == 0) = 0;
distances = max(D_arr(:));
[row, col] = find(D_arr == distances,1);
area = (abs(inp(row,1)-inp(col,1))+1)*(abs(inp(row,2)-inp(col,2))+1);
fprintf('Part 1 Solution: %d \n', abs(area));
%% Part 2
distances = maxk(D_arr(:),sum(D_arr~=0,"all"));
b_line = [inp; inp(1,:)];
x = b_line(:,1);
y = b_line(:,2);
poly2 = polyshape(x,y);
stop = 0;
for i = 1:numel(distances)
    [n1, n2] = find(D_arr == distances(i));
    n = numel(n1);
    for k = 1:n
        x1 = inp(n1(k),1);
        y1 = inp(n1(k),2);
        x2 = inp(n2(k),1);
        y2 = inp(n2(k),2);
        xlimit = [min([x1,x2]) max([x1,x2])];
        ylimit = [min([y1,y2]) max([y1,y2])];
        xbox = xlimit([1 1 2 2 1]);
        ybox = ylimit([1 2 2 1 1]);
        poly1 = polyshape(xbox,ybox);
        polyout = intersect(poly1,poly2);
        if size(polyout.Vertices,1) == size(poly1.Vertices,1)
            if all(sort(polyout.Vertices) == sort(poly1.Vertices))
                stop = 1;
                break;
            end
        end       
    end
    if stop == 1
        break;
    end
end
area = (abs(inp(n1(k),1)-inp(n2(k),1))+1)*(abs(inp(n1(k),2)-inp(n2(k),2))+1);
fprintf('Part 2 Solution: %d \n', area);
