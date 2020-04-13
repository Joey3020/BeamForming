

lamda = 1;
num = 64;
k = 2*pi() / lamda;
n0 = 120*pi();
color_label_green = 1;
color_label_blue = 2;
%a = input('a : ');
%b = input('b : ');
%x0 = input('x0 : ');
%y0 = input('y0 : ');
%d = input('d : ');
a = 25;
b = 25;
x01 = 12.5;
y01 = -25;
d1 = 40;

x02 = 1;
y02 = 3;
d2 = 40;

mode_label=0;
phi = pi()/4;
%phase_label = 0;
a_label = 3;
b_label = 3;
phase_label = - k * a_label / num * phi;

[Exa1, Eya1, Hxa1, Hya1] = Aperture_field_from_point_source(x01, y01, d1, a, b, lamda, num);
%[Exa2, Eya2, Hxa2, Hya2] = Aperture_field_from_point_source(x01, y02, d2, a, b, lamda, num);
%Exa = ones(num);
%Eya = zeros(num);
%Hxa = zeros(num);
%Hya = ones(num) ./ (120*pi());
%D = Get_Directivity_General(Exa1 + Exa2, Eya1 + Eya2, Hxa1 + Hxa2, Hya1 + Hya2, a, b, lamda, num);
D = Get_Directivity_General(Exa1, Eya1 , Hxa1 , Hya1 , a, b, lamda, num);

[Ex_label, Ey_label] = Set_E_field(mode_label, phase_label, a_label, b_label, num);
Dt = Get_Directivity_General(Ex_label, Ey_label, -Ey_label/n0, Ex_label/n0, a_label, b_label, lamda, num);

mD = max(max(D));
mDt = max(max(Dt));
%D = Get_Directivity_General(Exa1 + Exa2, Eya1 + Eya2, Hxa1 + Hxa2, Hya1 + Hya2, a, b, lamda, num);
%maxD = max(max(D));
%fprintf('%f\n', maxD);
%plot_directivity(D, 1);
%plot_single_beam(D);

fig = figure( 1 );
plot_directivity( Dt, color_label_blue ); % test beam is blue
hold on
plot_directivity( D, color_label_green ); %reverse beam is green
hold off
maximize_fig(fig);
%saveas(fig, sprintf('%d th result ', iter));

