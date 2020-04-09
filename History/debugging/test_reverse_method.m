
%original input
lamda = input('enter wavelength: ');
x_length = input('enter length of aperture in wavelengths(x axis) :');
y_length = input('enter width of aperture in wavelengths(y axis) :');
Num=input('order of your square matrix for aperture field: ');

a= x_length*lamda;
b= y_length*lamda;

%wavelength, wavenumber, impedence of medium
k=2*pi()/lamda;
Zc = 120*pi();

%input / E field (magnitude and phase) at the aperture
Ex_magnitude = ones(Num);
Ey_magnitude = zeros(Num);
Phase_angle = zeros(Num);

%TE10 input
%q=0:a/(Num-1):a;
%Ey_magnitude = cos(pi()/a*(q-a/2))'.*ones(Num);

%linear phase increase in y direction input
%{
for i=1:Num
    for j=1:Num
        Phase_angle(i,j)=(-1)*pi()/6/Num*k*(j);
    end
end
Phase_angle=reshape(Phase_angle,Num,Num)';
%}

Phase_exponential = exp(1i*Phase_angle);
Ex = Ex_magnitude.*Phase_exponential;
Ey = Ey_magnitude.*Phase_exponential;

Direct = Get_Directivity_grounded(Ex, Ey,a,b,k,Num);

x=(-1)*a/2 : a/(Num-1) : a/2;
y=(-1)*b/2 : b/(Num-1) : b/2;

%aperture field and apterture parameters from reverse method
%[c, d, D_NP,hpbw_xz,hpbw_yz, Exa, Eya] = reverse_method_grounded(Direct,lamda,x,y);
[Exa, Eya] = reverse_method_2(Direct,lamda,x,y);


%obtain directivity from Exa, Eya, a, b obtained from reverse method
Direct_reverse_method_ab_known=Get_Directivity_grounded(Exa, Eya, a, b, k, Num);
%Direct_reverse_method=Get_Directivity_grounded(Exa, Eya, c, d, k, Num);

%graphing and comparison
plot_directivity(Direct, 0)
hold on
plot_directivity(Direct_reverse_method_ab_known,1)

%subplot(1,2,2);
%plot_directivity(Direct_reverse_method)
