

% generates a data point used in DL
% a, b : source parameters
% A, B : metasurface parameters
% theta_max : max steering angle
function [data, label] = gen_data_point(a, b, d, A, B, theta_max, num, source_name)
    
    n0 = 120 * pi();
    theta = linspace(0, pi() / 2, num);
    phi = linspace(0, 2 * pi(), num);
    
    data = double.empty();
    label = [a, b, d, A, B, theta_max];

    for i = 0:1:3
        s_angle = theta_max / 3 * i;
        
        if strcmp(source_name,'hdpa')
            [E_theta, E_phi] = hdpa2metasurface2space(a, b, d, A, B, s_angle, num);
        elseif strcmp(source_name,'horn')
            [E_theta, E_phi] = horn2metasurface2space(a, b, d, A, B, s_angle, num);
        elseif strcmp(source_name, 'uniform')
            [Exa, Eya] = uniform_aperture_field(s_angle, A, B, num);
            [E_theta, E_phi] = aperture2space(Exa, Eya, - Eya / n0, Exa / n0, A, B, theta, phi);
        else
            fprintf('wrong source name');
        end
        
        D = get_D(E_theta, E_phi);        
        D = reshape(D, 1, []);
        data = cat(2, data, D);
    end
end