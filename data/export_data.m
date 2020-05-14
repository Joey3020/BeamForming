lambda = 1;
k = 2 * pi() / lambda;
A = 25;
B = 25;
a_min = 2;
a_max = 6;
b_min = 2;
b_max = 6;
d_min = 1;
d_max = 5;
theta_min = 0;
theta_max = pi() / 4;
N = 3;
num = 64;
R = 10;

train_data = generate_train_data(A, B, a_min, a_max, b_min, b_max, d_min, d_max, theta_min, theta_max, N ,R, k, num);
csvwrite('train_data.csv', train_data);

test_data = generate_test_data(a_min, a_max, b_min, b_max, theta_min, theta_max, N, R, k, num);
csvwrite('test_data.csv', test_data);