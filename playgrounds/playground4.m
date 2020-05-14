a = 6;
b = 6;
d = 2;
R = 10 * d;
phase = pi() / 4;
k = 2 * pi();
num = 64;
green = [0.0, 1.0, 0.0];

[E_theta, E_phi] = half_dipole_array_to_aperture_space(a, b, d, R, phase, k, num);

D = get_D_space(E_theta, E_phi, num);

plot_D(D, green);