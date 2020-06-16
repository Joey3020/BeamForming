
%plot directivity in entire 3d space

function plot_D2( D , color_label)

    [num, num] = size(D);
    
    theta = linspace(0, pi(), num);
    phi = linspace(0, 2*pi(), num);
    
    [phi, theta] = meshgrid(phi, theta);
    
    maxD = max(max(D));
    
    [x, y, z] = sph2cart(phi, pi()/2 - theta, D);

    %s = surf(x, y, z, 'FaceAlpha', 0.3)
    s = surf(x, y, z, 0.4);
    s.EdgeColor = 'none';
    s.FaceColor = color_label;
    alpha(s, 0.2);

    
    xlim([-15 15])
    ylim([-15 15])
    zlim([-10 10])
    xlabel('x axis')
    ylabel('y-axis')

end