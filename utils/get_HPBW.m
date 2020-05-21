% dA = r^2 sin_t * dt * dp

function hpbw = get_HPBW(D)

    [num, num] = size(D);
    maxD = max(max(D));
    hpbw = 0;
    for i = 1:1:num
        for j = 1:1:num
            if D(i, j) - maxD >= -3
                hpbw = hpbw + sin(i / num * pi() / 2) * pi() * pi() / (num * num);
            end
        end
    end
end