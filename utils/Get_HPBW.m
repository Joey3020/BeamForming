function spaceangle = Get_HPBW(D)

    [num, num] = size(D);
    maxD = max(max(D));
    boundary = maxD - 3;
    spaceangle = 0;
    dA = pi()*pi() / num / num;
    for i = linspace(1, num, num)
        for j = linspace(1, num, num)
            if D(i, j) >= boundary
                spaceangle = spaceangle + sin(pi() / 2 / num * i) * dA;
            end
        end
    end
end
