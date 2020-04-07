




     
testdata_size = input('input testdata size : ');
lamda = input('lamda : ');
num = 32;

[ data, labels_E, labels_ab, labels_mode, labels_phase ] ...
         = DL_generate_testdata(testdata_size, lamda, num)
     
     
filename = 'C:\Users\User\Documents\MATLAB\DL_data\test_data.xlsx';
writematrix(data, filename, 'Sheet', 1);
writematrix(labels_ab, filename, 'Sheet', 2);
writematrix(labels_mode, filename, 'Sheet', 3);
writematrix(labels_phase, filename, 'Sheet', 4);
writematrix(labels_E, filename, 'Sheet', 5);