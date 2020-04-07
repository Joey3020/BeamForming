%각도에 따른 빔 plot 해줌 .. 만드는 중


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

for p = 1:1:Num
    %xy plane
    Ex_magnitude_xy = zeros(Num);
    Ey_magnitude_xy = ones(Num);
    %TE10 mode
    %q=0:a/(Num-1):a;
    %Ey_magnitude_xy = cos(pi()/a*(q-a/2))'.*cos(pi()/a*(q-a/2)).*ones(Num);
    Phase_angle_xy = zeros(Num);
    for i=1:Num
        for j=1:Num
            Phase_angle_xy(i,j)= pi()/2 * p / Num * k * (j);
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
    
    plot_directivity(Direct)
    hold on;
end




