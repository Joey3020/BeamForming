
k = 2 * pi();
n0 = 120 * pi();
num = 32;
R = 20;
red = [1, 0, 0];
green = [0, 1, 0];

phase = pi()/4;
a_test = 2;
b_test = 3;
a = 1;
b = 1;

[data, label] = generate_test_data_point(a_test, b_test, phase, R, k, num);

[d_, A_, B_] = linesearch(data, a, b, phase, R, k, num);
[data_, label_] = generate_train_data_point2(a, b, d_, A_, B_, phase, R, k, num);

[D1, D2, D3, D4] = parse_Dtot(data, num);
[D1_, D2_, D3_, D4_] = parse_Dtot(data_, num);

plot_Dtot(D1, D2, D3, D4, D1_, D2_, D3_, D4_);