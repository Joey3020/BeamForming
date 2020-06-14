

a = 1;
b = 1;
A_min = 1;
A_max = 5;
d_min = 1;
d_max = 6;
N = 2;
num = 64;
source_name = 'horn';

files = 1;

processbar = waitbar(0, 'processing output');
for i = 1:1:files
    train_data = gen_data_set(a, b, d_min, d_max, A_min, A_max, N, num, source_name);
    filename = sprintf('train_val_data%d.csv', i);
    csvwrite(filename, train_data);
    waitbar(i/files)
end
close(processbar)

a_test = 1;
b_test = 1;
A_min_test = 1;
A_max_test = 3.5;
N_test = 200;
d_min_test = 100;
d_max_test = 100;
souce_name_test = 'uniform';
test_data = gen_data_set(a_test, b_test, d_min_test, d_max_test, A_min_test, A_max_test, N_test, num, source_name_test);
csvwrite('test_data.csv', test_data);