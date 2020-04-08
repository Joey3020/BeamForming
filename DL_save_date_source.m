     
data_size = 10;
lamda = 1;
num = 64;

 [ data, labels_ab, labels_source] = DL_generate_data_source(data_size, lamda, num);
     
     
filename = 'C:\Users\User\Documents\Beam_data\totaldata_with_source_beam.xlsx';
writematrix(data, filename, 'Sheet', 1);
writematrix(labels_ab, filename, 'Sheet', 2);
writematrix(labels_source, filename, 'Sheet', 3);
