function [theta, phi] = GetStearedAngle(D)
    [num, num] = size(D);
    
    ii = 0;
    jj = 0;
    maxD = -98765321;
    for i = 1:num
        for j = 1:num
            if D(i, j) > maxD
                maxD = D(i, j);
                ii = i;
                jj = j;
            end
        end
    end
    theta = ii * pi() / 2 / num;
    phi = jj * 2*pi() / num;
end