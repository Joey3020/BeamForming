function [ii, jj] = argmax(A)
    max = -inf;
    [num, num] = size(A);
    for i = 1:1:num
        for j = 1:1:num
            if max < A(i, j)
                max = A(i, j);
                ii = i;
                jj = j;
            end
        end
    end
end