
a = 1;
b = 1;
d = 5;
A = 3;
B = 3;
k = 2 * pi();
num = 64;
R = 10;
phase_angle = pi() /4;

%[Exa, Eya] = horn_to_aperture(a, b, d, A, B, k, num);
[E_theta, E_phi] = horn_to_aperture_to_space(a, b, d, A, B, phase_angle, R, k, num);
%[data, label] = generate_train_data_point2(a, b, d, A, B, phase_angle, R, k, num);
%ratio = get_energy_ratio(a, b, d, A, B, R, k, num);
[data, label] = generate_test_data_point(A, B, phase_angle, R, k, num);