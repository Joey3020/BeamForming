function [Exa, Eya, Hxa, Hya] = half_dipole_array_to_aperture(d, A, B, k, num)
    
    n0 = 120 * pi();
    
    Exa = zeros(num, num);
    Eya = zeros(num, num);
    Hxa = zeros(num, num);
    Hya = zeros(num, num);
    
    coeff = 1i * 60;

    for i = 1:1:num
        for j = 1:1:num
            x = A * i/num - A/2;
            y = B * j/num - B/2;
            
            r = sqrt(d*d + y*y);
            R = sqrt(r*r + x*x);
            
            cos_theta = x / R;
            sin_theta = r / R;
            cos_phi = y / r;
            sin_phi = d / r;
            
            F = cos(pi() / 2 * cos_theta) / sin_theta;
            %3 x 3 array factor
            AF = (1 + 2 * cos(pi() * sin_theta * cos_phi)) * (1 + 2 * cos(pi() * sin_theta * sin_phi));
       
            %4 x 4 array factor
            %AF = 4 * (cos(pi() / 2 * sin_theta * cos_phi) + cos( 3 * pi() / 2 * sin_theta * cos_phi)) * (cos(pi() / 2 * sin_theta * sin_phi) + cos( 3 * pi() / 2 * sin_theta * sin_phi));
            F = F * AF;
            H_phi = 1 / n0 * exp(- 1i * k * R) / R  * F;
            E_theta = exp(- 1i * k * R) / R * F;
            
            Hxa(i, j) = 0;
            Hya(i, j) = - coeff * H_phi * sin_phi;
            Exa(i, j) = - coeff * E_theta * sin_theta;
            Eya(i, j) = coeff * E_theta * cos_theta * cos_phi;
            
        end
    end
end