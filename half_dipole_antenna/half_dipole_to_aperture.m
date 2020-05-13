
% get E field of half dipole antenna on metasurface

function [Exa, Eya, Hxa, Hya] = half_dipole_to_aperture(d, a, b, k, num)

    n0 = 120 * pi();
    
    Exa = zeros(num, num);
    Eya = zeros(num, num);
    Hxa = zeros(num, num);
    Hya = zeros(num, num);
    
    coeff = 1i * 60;

    for i = 1:1:num
        for j = 1:1:num
            x = a * i/num - a/2;
            y = b * j/num - b/2;
            
            r = sqrt(d*d + y*y);
            R = sqrt(r*r + x*x);
            
            cos_theta = x / R;
            sin_theta = r / R;
            cos_phi = y / r;
            sin_phi = d / r;
            
            F = cos(pi() / 2 * cos_theta) / sin_theta;
            
            H_phi = 1 / n0 * exp(- 1i * k * R) / R  * F;
            E_theta = exp(- 1i * k * R) / R * F;
            
            Hxa(i, j) = 0;
            Hya(i, j) = - coeff * H_phi * sin_phi;
            Exa(i, j) = - coeff * E_theta * sin_theta;
            Eya(i, j) = coeff * E_theta * cos_theta * cos_phi;
            
        end
    end
    
end
