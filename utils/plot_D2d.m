function plot_D2d(D)
    [num, num] = size(D);
    theta = linspace(-90, 90,  2*num);
    D_t = D(:, 1);
    D_t2 = flip(D(:, num/2));
    D_tot = cat(1, D_t2, D_t);
    plot(theta, D_tot)
end