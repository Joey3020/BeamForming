function train_data = generate_train_data(A, B, a_min, a_max, b_min, b_max, d_min, d_max, theta_min, theta_max, N ,R, k, num)
    
    train_data = double.empty();
    
    %  N ^ 4 개의 train data point 형성
    for i = 1:1:N
        for j = 1:1:N
            for k = 1:1:N
                for l = 1:1:N
                    a = a_min + (a_max - a_min) * i / N;
                    b = b_min + (b_max - b_min) * j / N;
                    d = d_min + (d_max - d_min) * k / N;
                    t_max = theta_min + (theta_max - theta_min) * l / N;

                    [data, label] = generate_train_data_point(A, B, a, b, d, t_max, R, k, num);
                    data_point = cat(2, data, label);
                    train_data = cat(1, train_data, data_point);
                end
            end
        end
    end
end