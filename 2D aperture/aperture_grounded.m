%not grounded
%aperture parameters
lamda = input('enter wavelength: ');
x_length = input('enter length of aperture in wavelengths(x axis) :');
y_length = input('enter width of aperture in wavelengths(y axis) :');
a= x_length*lamda;
b= y_length*lamda;
 
%wavelength, wavenumber, impedence of medium
k=2*pi()/lamda;
Zc = 120*pi();

%input / E field (magnitude and phase) at the aperture
Num=input('order of your square matrix for aperture field: ');

Ex_magnitude = zeros(Num);
%Ey_magnitude = ones(Num);
Phase_angle = zeros(Num);

%TE10 input
q=0:a/(Num-1):a;
Ey_magnitude = cos(pi()/a*(q-a/2))'.*ones(Num);

%{
for i=1:Num^2
    Ex_magnitude(i)=input('magnitude of Ex : ');
end
Ex_magnitude=reshape(Ex_magnitude,Num,Num)';

for i=1:Num^2
    Ey_magnitude(i)=input('magnitude of Ey : ');
end
Ey_magnitude=reshape(Ey_magnitude,Num,Num)';
%}

%{  
for i=1:Num^2
    Phase_angle(i)=input('element of phase angle : ');
end
Phase_angle=reshape(Phase_angle,Num,Num)';
%}

%{
for i=1:Num
    for j=1:Num
        Phase_angle(i,j)=(-1)*pi()/6/Num*k*j;
    end
end
Phase_angle=reshape(Phase_angle,Num,Num)';
    %linear phase increase in x&y direction
%}

Phase_exponential = exp(1i*Phase_angle);
Ex = Ex_magnitude.*Phase_exponential;
Ey = Ey_magnitude.*Phase_exponential;

%Equivalent of aperture
Ms_x = Ey;
Ms_y = (-1)*Ex;
Js_x = zeros(Num);
Js_y = zeros(Num);

%spherical coordinate variables
theta = 0:pi()/2/(Num-1):pi()/2;
phi= 0:2*pi()/(Num-1):2*pi();

%E theta field
E_t = E_azithumal(theta,phi, Js_x, Js_y, Ms_x, Ms_y,a,b,k,Num);
E_t_principle_yz=E_azithumal(theta, pi()/2, Js_x, Js_y, Ms_x, Ms_y,a,b,k,Num);
E_t_principle_xz=E_azithumal(theta, 0, Js_x, Js_y, Ms_x, Ms_y,a,b,k,Num);

%E phi field ( H field * 120pi())
E_p=E_horizontal(theta,phi, Js_x, Js_y, Ms_x, Ms_y,a,b,k,Num);
E_p_principle_yz=E_horizontal(theta, pi()/2, Js_x, Js_y, Ms_x, Ms_y,a,b,k,Num);
E_p_principle_xz=E_horizontal(theta, 0, Js_x, Js_y, Ms_x, Ms_y,a,b,k,Num);

%total E field
E_total = sqrt(abs(E_t).*abs(E_t)+abs(E_p).*abs(E_p));
       
%normalized E field / field pattern
E_total_normal=E_total./max(E_total);

%total radiated power
Pr = 0;
for x1=0:pi()/2/(Num-1):pi()/2
    for y1=0:2*pi()/(Num-1):2*pi()
       Pr= Pr +  sin(x1).*(abs(E_azithumal(x1,y1, Js_x, Js_y, Ms_x, Ms_y,a,b,k,Num)).*abs(E_azithumal(x1,y1, Js_x, Js_y, Ms_x, Ms_y,a,b,k,Num)) + abs(E_horizontal(x1,y1, Js_x, Js_y, Ms_x, Ms_y,a,b,k,Num)).*abs(E_horizontal(x1,y1, Js_x, Js_y, Ms_x, Ms_y,a,b,k,Num)))*pi()/2/Num*(2*pi())/Num;
    end
end

%Directivity
D = 10*log10(4*pi()*E_total.*E_total./Pr);
D_yz = 10*log10(4*pi()/Pr*(abs(E_t_principle_yz).*abs(E_t_principle_yz)+abs(E_p_principle_yz).*abs(E_p_principle_yz)));
D_xz = 10*log10(4*pi()/Pr*(abs(E_t_principle_xz).*abs(E_t_principle_xz)+abs(E_p_principle_xz).*abs(E_p_principle_xz)));

%graphing

[phi, theta]=meshgrid(phi,theta);

subplot(2,2,1);
[u,v,w]=sph2cart(phi,pi()/2 - theta,D);
surf(u,v,w)
xlim([-15 15])
ylim([-15 15])
zlim([0 30])
xlabel('x axis')
ylabel('y-axis')
title('Directivity in spherical coordinates')

subplot(2,2,2);
[u,v,w]=sph2cart(phi,pi()/2 - theta,D);
surf(u,v,w)
xlim([-15 15])
ylim([-15 15])
zlim([0 30])
xlabel('x axis')
ylabel('y-axis')
title('Directivity in spherical coordinates')

subplot(2,2,3);
plot(theta, D_yz)
axis([-1 4 -30 50])
xlabel('theta')
ylabel('D(theta)')
title('D theta : y-z plane')

subplot(2,2,4);
plot(theta, D_xz)
axis([-1 4 -30 50])
xlabel('theta')
ylabel('D(theta)')
title('D theta : x-z plane')


