clear;
%% Read input
inp = char(readlines("input.txt"));
N = size(inp,1);
beam = inp(1,:)=='S';
splits = 0;
inp2 = inp;
for i = 2:N
    row = inp(i,:);
    splitters = row=='^';
    if any(splitters)
        split_idx = find(splitters);
        M = sum(splitters);
        new_beam = beam;
        for k = 1:M
            idx = split_idx(k);
            if beam(idx) == 1
                splits = splits + 1;
                new_beam(idx) = 0;
                new_beam(idx-1) = 1;
                new_beam(idx+1) = 1;
            end
        end
        beam = new_beam;
    end
    inp2(i,beam) = '|';
end
fprintf('Part 1 Solution: %d \n', splits);
%% Part 2
timelines = 1;
beam_times = zeros(1,size(inp2,2));
beam_times(inp(1,:)=='S') = 1;
for i = 3:N
    row = inp2(i,:);
    new_beam_times = beam_times;
    if sum(row == '|') > sum(inp2(i-1) == '|' )
        prev_row = inp2(i-1,:);
        M = sum(prev_row == '|');
        beam_idx = find(prev_row == '|');
        for k = 1:M
            idx = beam_idx(k);
            if row(idx) == '^'
                new_beam_times(idx-1) = new_beam_times(idx-1) +beam_times(idx);
                new_beam_times(idx+1) = new_beam_times(idx+1) +beam_times(idx);
                new_beam_times(idx) = 0;

            end
        end
    end
    beam_times = new_beam_times;
end
fprintf('Part 2 Solution: %d \n', sum(beam_times));
