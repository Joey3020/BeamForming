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
            
            r = sqrt(d*d + (y - y0) * (y - y0));
            R = sqrt(r*r + (x - x0) * (x - x0));
            
            cos_theta = (x - x0) / R;
            sin_theta = r / R;
            cos_phi = (y - y0) / r;
            sin_phi = d / r;
            
            F = cos(pi() / 2 * cos_theta) / sin_theta;
            
            H_phi = exp(- 1i * k * R) / R  * F;
            E_theta = exp(- 1i * k * R) / R * n0 * F;
            
            Hxa(i, j) = 0;
            Hya(i, j) = - H_phi * sin_phi;
            Exa(i, j) = - E_theta * sin_theta;
            Eya(i, j) = E_theta * cos_theta * cos_phi;
            
        end
    end
    %maxV = max(max(abs(Exa)));
    %Exa = Divide_Amplitude(Exa, maxV);
    %Eya = Divide_Amplitude(Eya, maxV);
    %Hxa = Divide_Amplitude(Hxa, maxV);
    %Hya = Divide_Amplitude(Hya, maxV);
end