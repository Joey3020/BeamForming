function plot_D2d(D)
    [num, num] = size(D);
    theta = linspace(-90, 90,  2*num);
    
    D_x = D(:, 1);
    D_x2 = flip(D(:, num/2));
    D_xz = cat(1, D_x2, D_x);
    
    D_y = D(:, num/4);
    D_y2 = flip(D(:, num*3/4));
    D_yz = cat(1, D_y2, D_y);
    
    
    nexttile
    plot(theta, D_xz)
    axis([-90 90 -1 30])
    title('x - z  plane')
    
    nexttile
    plot(theta, D_yz)
    axis([-90 90 -1 30])
    title('y - z plane')    
end