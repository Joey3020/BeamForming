function sa = get_space_angle(D, crit)
    [num, num] = size(D);
    
    sa = 0;
    
    for i = 1:1:num
        for j = 1:1:num
            if D(i, j) >= crit - 3
                sa = sa + sin(i / num * pi() / 2) * pi() * pi() / (num * num);
            end
        end
    end
end