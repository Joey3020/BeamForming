
a = 1;
b = 1;
d = 5;
A = 3;
B = 3;
ratio = 8;
AA = ratio * A;
BB = ratio * B;
k = 2 * pi();
num = 64;
R = 10;
phase_angle = pi() /4;

%[Exa, Eya] = horn_to_aperture(a, b, d, A, B, k, num);
[E_theta, E_phi] = horn_to_plane_to_space2(a, b, d, A, B, AA, BB, phase_angle, R, k, num);
D = get_D_space(E_theta, E_phi, num);
plot_D(D, [1.0, 0.0, 0.0]);
%[data, label] = generate_train_data_point3(a, b, d, A, B, AA, BB, phase_angle, R, k, num);
%train_data = generate_train_data3(a, b, 1, 5, 3, 9, 0, pi()/4, ratio, 1, R, k, num);
%energy_ratio = get_energy_ratio(a, b, d, AA, BB, R, k, num);
%[data, label] = generate_test_data_point(A, B, phase_angle, R, k, num);