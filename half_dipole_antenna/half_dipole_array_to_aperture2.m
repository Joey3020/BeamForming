function [Exa, Eya, Hxa, Hya] = half_dipole_array_to_aperture2(A, B, a, b, d, phase, k, num)
    [Exa, Eya, Hxa, Hya] = half_dipole_array_to_aperture(A, B, d, k, num);
    
    ii = fix((A - a) / 2 * num / A);
    phase_label =  - k * phase *  A / num;
    
    for i = 1:1:num
        for j = 1:1:num
            x = i / num * A - A / 2;
            y = j / num * B - B / 2;
            
            if (-a/2 < x) && ( x < a / 2) && ( - b/ 2 < y ) && ( y < b / 2)
                exponent = exp(1i * (i - ii) * phase_label);
                Exa(i, j) = abs(Exa(i, j)) * exponent;
                Eya(i, j) = abs(Eya(i, j)) * exponent;
                Hxa(i, j) = abs(Hxa(i, j)) * exponent;
                Hya(i, j) = abs(Hya(i, j)) * exponent;
            end
        end
    end
end