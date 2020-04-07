function ret = GetRatio(D1, D2, num)
    % D1 : prediction
    % D2 : label
    
    
    error = [0.05, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 1.0];
    error_sz = 8;
    ret = zeros(1, error_sz);
    tot = 0;
    for i = 1:1:num
        for j = 1:1:num
            if D2(i,j) >=0
               tot = tot + pi()*pi()*1/(num*num) * sin(pi()/2 * i/num);
            end
        end
    end
    for i = 1:1:num
        for j = 1:1:num
            for k = 1:1:error_sz
                if (D1(i,j) >= 0) && (D2(i,j) >= 0)
                    if (D1(i, j) >= D2(i,j) * (1 - error(k)))
                        ret(1, k) = ret(1, k) + pi() * pi() * 1/(num * num) * sin(pi()/2* i / num);
                    end
                end
            end
        end
    end
    ret = ret./tot;
end