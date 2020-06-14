function [data, label] = generate_train_data_point(a, b, d, A, B, theta_max, R, k, num)

    %a, b : spaceing btw array elements in x, y direction
    
    data = double.empty();
    label = [a, b, d, A, B, theta_max];

    for i = 0:1:3
        steer_angle = theta_max / 3 * i;
        [E_theta, E_phi] = half_dipole_array_to_aperture_space(d, A, B, R, steer_angle, k, num);    
        D = get_D_space(E_theta, E_phi, num);
        D = reshape(D, 1, []);
        data = cat(2, data, D);
    end
end