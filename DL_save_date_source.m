     
data_size = 100000;
lamda = 1;
num = 64;

 [ data, labels_ab, labels_source] = DL_generate_data(data_size, lamda, num);
     
     
filename = 'C:\Users\User\Documents\MATLAB\DL_data\test_data.xlsx';
writematrix(data, filename, 'Sheet', 1);
writematrix(labels_ab, filename, 'Sheet', 2);
writematrix(labels_source, filename, 'Sheet', 3);
