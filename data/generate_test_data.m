function test_data = generate_test_data(a_min, a_max, b_min, b_max, theta_min, theta_max, N ,R, k, num)
    
    test_data = double.empty();
    
    %  N ^ 4 개의 train data point 형성
    for i = 1:1:N
        for j = 1:1:N
            for k = 1:1:N
                a = a_min + (a_max - a_min) * i / N;
                b = b_min + (b_max - b_min) * j / N;
                t_max = theta_min + (theta_max - theta_min) * k / N;

                [data, label] = generate_test_data_point(a, b, t_max, R, k, num);
                data_point = cat(2, data, label);
                test_data = cat(1, test_data, data_point);
            end
        end
    end
end