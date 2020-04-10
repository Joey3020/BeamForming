function [Exa, Eya, Hxa, Hya] = Aperture_field_from_point_source(x0, y0, d, a, b, lamda, num)
    
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
            r = dis(x0, y0, x, y);
            R = sqrt(r*r + d*d);
            
            sin_theta = r / R;
            cos_theta = d / R;
            
            cos_a = 0;
            sin_a = 1;
            
            if r ~= 0
                cos_a = (x - x0) / r;
                sin_a = (y - y0) / r;
            end
            
            F = 0;
            if r~=0
                F = cos(pi() / 2 * cos_theta) / sin_theta;
            end
            
            H_phi = exp(- 1i * k * R) / R * k * F;
            E_theta = exp(- 1i * k * R) / R * k * n0 * F;
            
            Hxa(i, j) = - H_phi * sin_a;
            Hya(i, j) = H_phi * cos_a;
            Exa(i, j) = E_theta * cos_theta * cos_a;
            Eya(i, j) = E_theta * cos_theta * sin_a;
            
        end
    end
    maxV = max(max(abs(Exa)));
    Exa = Divide_Amplitude(Exa, maxV);
    Eya = Divide_Amplitude(Eya, maxV);
    Hxa = Divide_Amplitude(Hxa, maxV);
    Hya = Divide_Amplitude(Hya, maxV);
end