function train_data = generate_train_data2(a, b, d_min, d_max, A_min, A_max, B_min, B_max, theta_min, theta_max, N ,R, k, num)
    
    train_data = double.empty();
    
    %  N ^ 4 ê°œì˜ train data point ?˜•?„±
    for i = 1:1:N
        A = A_min + (A_max - A_min) * rand;
        B = B_min + (B_max - B_min) * rand;
        d = d_min + (d_max - d_min) * rand;
        t_max = theta_min + (theta_max - theta_min) * rand;

        [data, label] = generate_train_data_point2(a, b, d, A, B, t_max, R, k, num);
        data_point = cat(2, data, label);
        train_data = cat(1, train_data, data_point);

    end
end