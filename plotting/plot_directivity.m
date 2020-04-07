function plot_directivity( D , color_label)

[num, num]=size(D);
theta = 0:pi()/2/(num-1):pi()/2;
phi= 0:2*pi()/(num-1):2*pi();

[phi, theta]=meshgrid(phi,theta);

max_D = max(max(D));

%graphing in spherical coordinates
[u,v,w] =  sph2cart(phi,pi()/2 - theta,D);

%s = surf(u,v,w, 'FaceAlpha', 0.3)
s = surf(u,v,w, 0.3)
s.EdgeColor = 'none';

if color_label == 1 %green reverse beam
    s.FaceColor = [0.0, 1.0, 0.0];
    alpha(s, 0.2)
elseif color_label == 2 %blue test beam
    s.FaceColor = [0.0, 0.0 , 1.0];
    alpha(s, 0.2)
else %red °ãÄ¡´Â
    s.FaceColor = [1.0, 0.0, 0.0];
    
xlim([-35 35])
ylim([-35 35])
zlim([0  max_D + 10])
xlabel('x axis')
ylabel('y-axis')

end