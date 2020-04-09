     
data_size = 2000;
lamda = 1;
num = 64;

 [ data, labels] = DL_generate_data_source(data_size, lamda, num);
     
     
filename = 'C:\Users\User\Documents\Beam_data\testdata_with_source_beam.xlsx';
writematrix(data, filename, 'Sheet', 1);
writematrix(labels, filename, 'Sheet', 2);

%label
% a, b, x, y, d
%100 개 생성하는데 3:30초 정도 걸림
