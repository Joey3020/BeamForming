lambda = 1;
k = 2 * pi() / lambda;
A = 25;
B = 25;
a_min = 3;
a_max = 9;
b_min = 3;
b_max = 9;
d_min = 1;
d_max = 5;
theta_min = 0;
theta_max = pi() / 4;
N = 500;

a_min_test = 3;
a_max_test = 5;
b_min_test = 3;
b_max_test = 5;
t_min_test = 0;
t_max_test = pi() / 4;
N_test = 200;

num = 64;
R = 10;
files = 40;

%processbar = waitbar(0, 'processing output');
%for i = 1:1:files
%    train_data = generate_train_data(A, B, a_min, a_max, b_min, b_max, d_min, d_max, theta_min, theta_max, N ,R, k, num);
%    filename = sprintf('train_val_data%d.csv', i);
%    csvwrite(filename, train_data);
%    waitbar(i/files)
%end
%close(processbar)

test_data = generate_test_data(a_min_test, a_max_test, b_min_test, b_max_test, t_min_test, t_max_test, N_test, R, k, num);
csvwrite('test_data.csv', test_data);