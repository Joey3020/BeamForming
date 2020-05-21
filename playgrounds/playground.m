
a = 5;
b = 5;
d = 5;
R = 10;
phase =0;
k = 2 * pi();
num = 64;
[E_theta, E_phi] = half_dipole_array_to_aperture_space(a, b, d, R, phase, k, num);
D = get_D_space(E_theta, E_phi, num);
plot_D(D, [1.0, 0.0, 0.0])
max_D = max(max(D));
hpbw = get_HPBW(D);
hpbw_ratio = get_HPBW_ratio(D);