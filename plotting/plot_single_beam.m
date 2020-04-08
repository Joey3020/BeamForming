function plot_single_beam(D)

    [num, num] = size(D);
    
    theta = linspace(0, pi()/2, num);
    phi = linspace(0, 2*pi(), num);
    
    [phi, theta] = meshgrid(phi, theta);
    
    maxD = max(max(D));
    
    [x, y, z] = sph2cart(phi, pi()/2 - theta, D);
    
    s = surf(x, y, z);
    s.EdgeColor = 'none';

    xlim([-35 35])
    ylim([-35 35])
    zlim([0  maxD + 10])
    xlabel('x axis')
    ylabel('y-axis')
    
    
end