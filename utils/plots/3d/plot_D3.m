function plot_D3( D , color_label)

    [num, num] = size(D);
    
    theta = linspace(0, pi()/2, num);
    phi = linspace(0, 2*pi(), num);
    
    [phi, theta] = meshgrid(phi, theta);
    
    maxD = max(max(D));
    
    [x, y, z] = sph2cart(phi, pi()/2 - theta, D);

    
    %s = surf(x, y, z, 'FaceAlpha', 0.3)
    [dfdx,dfdy] = gradient(z);
    s = surf(x, y, z, sqrt(dfdx.^2 + dfdy.^2));
    %set(s,'FaceColor', color_label, 'FaceAlpha',0.4,'FaceLighting','gouraud','EdgeColor','none')
    set(s, 'FaceColor','interp', 'FaceAlpha',0.35, 'EdgeColor','none')
    
    xlim([-5 20])
    ylim([-10 10])
    zlim([0 maxD+5])
    xlabel('x axis')
    ylabel('y-axis')
    zlabel('z-axis')
    %camlight
    colormap hsv
    
    hold on
    plot([0 0],[-25 25],'r-.')
    plot([-25 25],[0 0],'r-.')
    plot3([0 0],[0 0],[-25 25],'r-.')
    hold off
end