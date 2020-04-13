data_size = 1;
lamda = 1;
num = 64;

for k = 1:1


     [ data, labels] = DL_generate_data_by_class(data_size, lamda, num);


    filename = sprintf('data_with_source_by_class%d.xlsx', k);
    writematrix(data, filename, 'Sheet', 1);
    writematrix(labels, filename, 'Sheet', 2);
    
end