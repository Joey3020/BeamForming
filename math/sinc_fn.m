function s = sinc_fn(A)
    [num, num] = size(A);
    s = zeros(num, num);
    
    for i = 1:1:num
        for j = 1:1:num
            if abs(A(i, j)) < 1e-12
                s(i, j) = 1;
            else
                s(i, j) = sin(A(i, j)) / A(i, j);
            end
        end
    end
end