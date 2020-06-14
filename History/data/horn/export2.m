lambda = 1;
k = 2 * pi() / lambda;

a = 1;
b = 1;
A_min = 1;
A_max = 5;
d_min = 1;
d_max = 6;
theta_min = 0;
theta_max = pi() / 4;
N = 20;

a_min_test = 1;
a_max_test = 3.5;
b_min_test = 1;
b_max_test = 3.5;
t_min_test = 0;
t_max_test = pi() / 4;
N_test = 200;

num = 64;
R = 10;
files = 0;

processbar = waitbar(0, 'processing output');
for i = 1:1:files
    train_data = generate_train_data2(a, b, d_min, d_max, A_min, A_max, A_min, A_max, theta_min, theta_max, N, R, k, num);
    filename = sprintf('train_val_data%d.csv', i);
    csvwrite(filename, train_data);
    waitbar(i/files)
end
close(processbar)

d_min_test = 100;
d_max_test = 100;
test_data = generate_train_data2(a, b, d_min_test, d_max_test, a_min_test, a_max_test, a_min_test, a_max_test, theta_min, theta_max, N_test, R, k, num);
csvwrite('test_data.csv', test_data);