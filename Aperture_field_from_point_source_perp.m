function [Exa, Eya, Hxa, Hya] = Aperture_field_from_point_source_perp(x0, y0, d, a, b, lamda, num)
    
    k = 2*pi() / lamda;
    n0 = 120 * pi();
    
    Exa = zeros(num, num);
    Eya = zeros(num, num);
    Hxa = zeros(num, num);
    Hya = zeros(num, num);
    
    for i = 1:1:num
        for j = 1:1:num
            x = a * i/num;
            y = b * j/num;
            
            r = sqrt(d*d + (x - x0) * (x - x0));
            R = sqrt(r*r + (y - y0) * (y - y0));
            
            cos_theta = (y - y0) / R;
            sin_theta = r / R;
            cos_phi = d / r;
            sin_phi = (x - x0) / r;
            
            F = cos(pi() / 2 * cos_theta) / sin_theta;
            
            H_phi = exp(- 1i * k * R) / R  * F;
            E_theta = exp(- 1i * k * R) / R * n0 * F;
            
            Hxa(i, j) = cos_phi * H_phi;
            Hya(i, j) = 0;
            Exa(i, j) = cos_theta * sin_phi * E_theta;
            Eya(i, j) = -sin_theta * E_theta;
            
        end
    end
end