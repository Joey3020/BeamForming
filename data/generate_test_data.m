function test_data = generate_test_data(a_min, a_max, b_min, b_max, theta_min, theta_max, N ,R, k, num)
    
    test_data = double.empty();
    
    %  N ^ 4 ê°œì˜ train data point ?˜•?„±
    for i = 1:1:N

        a = a_min + (a_max - a_min) * rand;
        b = b_min + (b_max - b_min) * rand;
        t_max = theta_min + (theta_max - theta_min) * rand;

        [data, label] = generate_test_data_point(a, b, t_max, R, k, num);
        data_point = cat(2, data, label);
        test_data = cat(1, test_data, data_point);

    end
end