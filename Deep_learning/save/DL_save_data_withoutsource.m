     
for k = 1:1
    data_size = 1;
    lamda = 1;
    num = 64;

     [ data, labels] = DL_generate_test_data_withoutsource(data_size, lamda, num);


    filename = sprintf('testdata_without_source%d.xlsx', k);
    writematrix(data, filename, 'Sheet', 1);
    writematrix(labels, filename, 'Sheet', 2);
end