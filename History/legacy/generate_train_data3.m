function train_data = generate_train_data3(a, b, d_min, d_max, AB_min, AB_max, theta_min, theta_max, ratio, N ,R, k, num)
    
    train_data = double.empty();
    
    %  N ^ 4 ê°œì˜ train data point ?˜•?„±
    for i = 1:1:N
        A = AB_min + (AB_max - AB_min) * rand;
        B = AB_min + (AB_max - AB_min) * rand;
        d = d_min + (d_max - d_min) * rand;
        t_max = theta_min + (theta_max - theta_min) * rand;
        AA = A * ratio;
        BB = B * ratio;
        
        [data, label] = generate_train_data_point3(a, b, d, A, B, AA, BB, t_max, R, k, num);
        data_point = cat(2, data, label);
        train_data = cat(1, train_data, data_point);

    end
end