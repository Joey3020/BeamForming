function [D1, D2, D3, D4] = parse_Dtot(Dtot, num)
    len = num * num;
    
    D1 = reshape(Dtot(:, 1:len), num, num);
    D2 = reshape(Dtot(:, len + 1: 2*len), num, num);
    D3 = reshape(Dtot(:, 2*len + 1:3*len), num,num);
    D4 = reshape(Dtot(:, 3*len + 1:4*len), num, num);
end