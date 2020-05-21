function train_data = generate_train_data(A, B, a_min, a_max, b_min, b_max, d_min, d_max, theta_min, theta_max, N ,R, k, num)
    
    train_data = double.empty();
    
    %  N ^ 4 ê°œì˜ train data point ?˜•?„±
    for i = 1:1:N
        a = a_min + (a_max - a_min) * rand;
        b = b_min + (b_max - b_min) * rand;
        d = d_min + (d_max - d_min) * rand;
        t_max = theta_min + (theta_max - theta_min) * rand;

        [data, label] = generate_train_data_point(A, B, a, b, d, t_max, R, k, num);
        data_point = cat(2, data, label);
        train_data = cat(1, train_data, data_point);

    end
end