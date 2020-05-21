lambda = 1;
k = 2 * pi() / lambda;

a_min_test = 3;
a_max_test = 7;
b_min_test = 3;
b_max_test = 7;
t_min_test = 0;
t_max_test = pi() / 4;
N_test = 200;

num = 64;
R = 10;

test_data = generate_test_data(a_min_test, a_max_test, b_min_test, b_max_test, t_min_test, t_max_test, N_test, R, k, num);
csvwrite('test_data1.csv', test_data);