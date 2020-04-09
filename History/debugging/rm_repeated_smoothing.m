%testing reverse method : get the phase from the reverse method and apply
%the phase to a uniform E field
% we will call this the uniform filter


%original input
lamda = input('enter wavelength: ');
x_length = input('enter length of aperture in wavelengths(x axis) :');
y_length = input('enter width of aperture in wavelengths(y axis) :');
z_length = input('enter height of aperture in wavelengths(z axis) :');
Num=input('order of your square matrix for aperture field: ');

a= x_length*lamda;
b= y_length*lamda;
c= z_length*lamda;

%wavelength, wavenumber, impedence of medium
k=2*pi()/lamda;
Zc = 120*pi();

%input / E field (magnitude and phase) at the aperture 
%xy plane
Ex_magnitude_xy = zeros(Num);
Ey_magnitude_xy = ones(Num);
%TE10 mode
%q=0:a/(Num-1):a;
%Ey_magnitude_xy = cos(pi()/a*(q-a/2))'.*cos(pi()/a*(q-a/2)).*ones(Num);
Phase_angle_xy = zeros(Num);

for i=1:Num
    for j=1:Num
        Phase_angle_xy(i,j)=(-1)*pi()/40/Num*k*(j);
    end
end
Phase_angle_xy=reshape(Phase_angle_xy,Num,Num)';
%}

Phase_exponential_xy = exp(1i*Phase_angle_xy);
Ex_xy = Ex_magnitude_xy.*Phase_exponential_xy;
Ey_xy = Ey_magnitude_xy.*Phase_exponential_xy;
 
%yz plane
Ey_magnitude_yz = zeros(Num);
Ez_magnitude_yz = zeros(Num);
Phase_angle_yz = zeros(Num);

Phase_exponential_yz = exp(1i*Phase_angle_yz);
Ey_yz = Ey_magnitude_yz.*Phase_exponential_yz;
Ez_yz = Ez_magnitude_yz.*Phase_exponential_yz;

%yz plane backside
Ey_magnitude_yz_bs = zeros(Num);
Ez_magnitude_yz_bs = zeros(Num);
Phase_angle_yz_bs = zeros(Num);

Phase_exponential_yz_bs = exp(1i*Phase_angle_yz_bs);
Ey_yz_bs = Ey_magnitude_yz_bs.*Phase_exponential_yz_bs;
Ez_yz_bs = Ez_magnitude_yz_bs.*Phase_exponential_yz_bs;

%zx plane
Ez_magnitude_zx = zeros(Num);
Ex_magnitude_zx = zeros(Num);
Phase_angle_zx = zeros(Num);

Phase_exponential_zx = exp(1i*Phase_angle_zx);
Ez_zx = Ez_magnitude_zx.*Phase_exponential_zx;
Ex_zx = Ex_magnitude_zx.*Phase_exponential_zx;

%zx plane backside
Ez_magnitude_zx_bs = zeros(Num);
Ex_magnitude_zx_bs = zeros(Num);
Phase_angle_zx_bs = zeros(Num);

Phase_exponential_zx_bs = exp(1i*Phase_angle_zx_bs);
Ez_zx_bs = Ez_magnitude_zx_bs.*Phase_exponential_zx_bs;
Ex_zx_bs = Ex_magnitude_zx_bs.*Phase_exponential_zx_bs;

%obtain directivity matrix
[Pr, Dmax, Direct] = Get_directivity_open_3d(Ex_xy, Ey_xy, Ey_yz, Ez_yz, Ey_yz_bs, Ez_yz_bs, Ez_zx, Ex_zx, Ez_zx_bs, Ex_zx_bs, a, b, c, k, Num);

%test for reverse method
x=(-1)*a/2 : a/(Num-1) : a/2;
y=(-1)*b/2 : b/(Num-1) : b/2;
[Exa2, Eya2] = reverse_method_2(Direct,lamda,x,y);

Exa2_phase = Exa2./abs(Exa2);
%Eya2_phase = Eya2./abs(Eya2);
Exa2_mag = Exa2./Exa2_phase;

temp = smoothdata(Exa2_mag);
for n = 1:1:Num
    temp = smoothdata(temp);
end

Exa2_smooth = temp .* Exa2_phase;
zeromatrix = zeros(Num);
[Pr_reverse2, Dmax_reverse2, Direct_reverse2] = Get_directivity_open_3d(Exa2_smooth, Eya2, zeromatrix, zeromatrix, zeromatrix, zeromatrix, zeromatrix, zeromatrix, zeromatrix, zeromatrix, a, b, c, k, Num);

All_D = [Dmax, Dmax_reverse2];

subplot(1,2,1);
plot_directivity(Direct)

subplot(1,2,2);
plot_directivity(Direct_reverse2)