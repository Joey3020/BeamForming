function plot_directivity( D , color_label)

    [num, num] = size(D);
    
    theta = linspace(0, pi()/2, num);
    phi = linspace(0, 2*pi(), num);
    
    [phi, theta] = meshgrid(phi, theta);
    
    maxD = max(max(D));
    
    [x, y, z] = sph2cart(phi, pi()/2 - theta, D);

    %s = surf(u,v,w, 'FaceAlpha', 0.3)
    s = surf(x, y, z, 0.4);
    s.EdgeColor = 'none';

    if color_label == 1 %green reverse beam
        s.FaceColor = [0.0, 1.0, 0.0];
        alpha(s, 0.2)
    elseif color_label == 2 %blue test beam
        s.FaceColor = [0.0, 0.0 , 1.0];
        alpha(s, 0.2)
    else %red °ãÄ¡´Â
        s.FaceColor = [1.0, 0.0, 0.0];
    end
    
    xlim([-35 35])
    ylim([-35 35])
    zlim([0  maxD + 10])
    xlabel('x axis')
    ylabel('y-axis')

end