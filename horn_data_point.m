function [data, label] = horn_data_point(a, b, d, A, B, theta_max, num)

    %a, b : spaceing btw array elements in x, y direction
    
    data = double.empty();
    label = [a, b, d, A, B, theta_max];

    for i = 0:1:3
        s_angle = theta_max / 3 * i;
        [E_theta, E_phi] = hdpa2metasurface2space(d, A, B, s_angle, num);    
        D = get_D(E_theta, E_phi);
        D = reshape(D, 1, []);
        data = cat(2, data, D);
    end
end