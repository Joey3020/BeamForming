function plot_Dyz(D)
    [num, num] = size(D);
    theta = linspace(-90, 90,  2*num);
    
    D_y = D(:, num/4);
    D_y2 = flip(D(:, num*3/4));
    D_yz = cat(1, D_y2, D_y);
 
    plot(theta, D_yz)
    ylim([-1, inf]);
    title('y - z plane')    
end