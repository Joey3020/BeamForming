


%generate N datapoints
%A, B, d, t_max : random btw ranges

function dataset = gen_data_set(a, b, d_min, d_max, A_min, A_max, N, num, source_name)
    
    dataset = double.empty();
    theta_max = pi() / 4;
    theta_min = 0;
    
    for i = 1:1:N
        A = A_min + (A_max - A_min) * rand;
        B = A_min + (A_max - A_min) * rand;
        d = d_min + (d_max - d_min) * rand;
        t_max = theta_min + (theta_max - theta_min) * rand;

        [data, label] = gen_data_point(a, b, d, A, B, t_max, num, source_name);
        data_point = cat(2, data, label);
        dataset = cat(1, dataset, data_point);

    end
end