
data_size = 250;
lamda = 1;
num = 64;

for k = 1:160


     [ data, labels] = DL_generate_data_source(data_size, lamda, num);


    filename = sprintf('data_with_source_by_regression%d.xlsx', k);
    writematrix(data, filename, 'Sheet', 1);
    writematrix(labels, filename, 'Sheet', 2);
    
end

%label
% a, b, x, y, d
%100 개 생성하는데 3:30초 정도 걸림
