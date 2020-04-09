     
data_size = 10;
lamda = 1;
num = 64;

 data = DL_generate_test_data_withoutsource(data_size, lamda, num);
     
     
filename = 'C:\Users\User\Documents\Beam_data\testdata_without_source.xlsx';
writematrix(data, filename, 'Sheet', 1);

%label
% a, b, x, y, d
%100 개 생성하는데 3:30초 정도 걸림
