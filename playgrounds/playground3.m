

lambda = 1;
k = 2 * pi() / lambda;
etha = 120 * pi();
green = [0.0, 1.0, 0.0];
blue = [0.0, 0.0, 1.0];
num = 64;

a = 16;
b = 16;
d = 1;
phi = 0;
phi = - k * a * phi / num;

%[Ex, Ey] = Set_E_field(0, phi, a, b, num);
%D = get_D(Ex, Ey, -Ey/etha, Ex/etha, a, b, k, num);
[Exa, Eya, Hxa, Hya] = half_dipole_antenna_array(d, a, b, k, num);
D = get_D(Exa, Eya, Hxa, Hya, a, b, k, num);
D_max = max(max(D));

fig = figure( 1 );
plot_D( D, blue );
maximize_fig(fig);