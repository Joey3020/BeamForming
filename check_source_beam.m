

lamda = 1;
num = 64;
%a = input('a : ');
%b = input('b : ');
%x0 = input('x0 : ');
%y0 = input('y0 : ');
%d = input('d : ');
a = 20;
b = 20;
x0 = 1;
y0 = 1;
d = 5;

[Exa, Eya, Hxa, Hya] = Aperture_field_from_point_source(x0, y0, d, a, b, lamda, num);
%Exa = ones(num);
%Eya = zeros(num);
%Hxa = zeros(num);
%Hya = ones(num) ./ (120*pi());
D = Get_Directivity_General(Exa, Eya, Hxa, Hya, a, b, lamda, num);
maxD = max(max(D));
fprintf('%f\n', maxD);
%plot_directivity(D, 1);
plot_single_beam(D);