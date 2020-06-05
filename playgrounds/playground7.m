%[E_theta, E_phi] = horn_to_space2(1.5, .15, 20, 2 * pi(), 64);


a = 1.5;
b = 1.5;
d = 4;
A = 3;
B = 3;
k = 2 * pi();
R = 20;
num = 64;
s_angle = pi()/4;
phase = linspace(0, k * sin(s_angle) * A, num)';
exp_ = exp(1i * phase);


[E_theta, E_phi] = horn_to_aperture_to_space(a, b, d, A, B, s_angle, R, k, num);
D = get_D_space(E_theta, E_phi, num);
plot_D(D, [1.0, 0.0, 0.0]);
%plot_D2d(D);