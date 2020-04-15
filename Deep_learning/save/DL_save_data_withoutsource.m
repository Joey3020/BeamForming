     
    data_size = 1000;
    lamda = 1;
    num = 64;

     [ data, labels] = DL_generate_test_data_withoutsource(data_size, lamda, num);


    filename = sprintf('testdata_without_source.xlsx');
    writematrix(data, filename, 'Sheet', 1);
    writematrix(labels, filename, 'Sheet', 2);
