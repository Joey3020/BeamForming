function [data, labels] = generate_train_data_point2( a, b, d, A, B, theta_max, R, k, num)

    data = double.empty();
    labels = [a, b, d, A, B, theta_max];

    
    for i = 0:1:3
        phase = theta_max / 3 * i;
        [E_theta, E_phi] = horn_to_aperture_to_space(a, b, d, A, B, phase, R, k, num);
        D = get_D_space(E_theta, E_phi, num);
        %plot_D(D, [0, 1, 0]);
        D = reshape(D, 1, []);
        data = cat(2, data, D);
    end
end