

lamda = 1;
num = 64;
%a = input('a : ');
%b = input('b : ');
%x0 = input('x0 : ');
%y0 = input('y0 : ');
%d = input('d : ');
a = 12;
b = 12;
x01 = 11;
y01 = 6;
d1 = 10;

x02 = 1;
y02 = 6;
d2 = 10;

[Exa1, Eya1, Hxa1, Hya1] = Aperture_field_from_point_source(x01, y01, d1, a, b, lamda, num);
[Exa2, Eya2, Hxa2, Hya2] = Aperture_field_from_point_source(x02, y02, d2, a, b, lamda, num);
%Exa = ones(num);
%Eya = zeros(num);
%Hxa = zeros(num);
%Hya = ones(num) ./ (120*pi());
D = Get_Directivity_General(Exa1 + Exa2, Eya1 + Eya2, Hxa1 + Hxa2, Hya1 + Hya2, a, b, lamda, num);
maxD = max(max(D));
fprintf('%f\n', maxD);
%plot_directivity(D, 1);
plot_single_beam(D);