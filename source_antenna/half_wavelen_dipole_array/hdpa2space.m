
%E_theta of half wavelenght dipole antenna in 3d space

function [E_theta, E_phi] = hdpa2space(a, b, num)

    coeff = 1i * 60 * exp(-1i * k * R) / R;

    E_theta = zeros(num, num);
    E_phi = zeros(num, num);
    
    for i = 1:1:num
        for j = 1:1:num
            theta = pi() / 2 / num * i;
            phi = 2 * pi() / num * j;
            
            cos_theta_ = sin(theta) * cos(phi);
            sin_theta_ = sqrt(sin(theta) * sin(theta) * sin(phi) * sin(phi) + cos(theta) * cos(theta));
            
            F = cos(pi() / 2 * cos_theta_) / sin_theta_;
            AF = (1 + 2 * cos(pi() * sin(theta) * cos(phi))) * (1 + 2 * cos(pi() * sin(theta) * sin(phi)));
            
            E_theta(i, j) = coeff * F * AF;
        end
    end
end