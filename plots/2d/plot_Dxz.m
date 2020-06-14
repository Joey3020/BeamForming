function plot_Dxz(D)
    [num, num] = size(D);
    theta = linspace(-90, 90,  2*num);
    
    D_x = D(:, 1);
    D_x2 = flip(D(:, num/2));
    D_xz = cat(1, D_x2, D_x);

    plot(theta, D_xz)
    ylim([-1, inf])
    title('x - z  plane')
     
end