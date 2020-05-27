function [E_theta, E_phi] = horn_to_plane_to_space(a, b, d, A, B, AA, BB, phase_angle, R, k, num)
    theta = linspace(0, pi() / 2, num);
    phi = linspace(0, 2 * pi(), num);
    n0 = 120 * pi();
    
    Exa = zeros(num, num);
    Eya = zeros(num, num);
    Hxa = zeros(num, num);
    Hya = zeros(num, num);
    
    phase = - k * phase_angle * AA / num;
    ii = fix((AA - A) / 2 * num / AA);

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
            
            coeff = 1i * a * b * k * exp(-1i * k * R) / (2 * pi() * R);
            
            X = k * a / 2 * sin_theta * cos_phi;
            Y = k * b / 2 * sin_theta * sin_phi;
            if X == 0
                sinc_X = 1;
            else
                sinc_X = sin(X) / X;
            end
            if Y == 0
                sinc_Y = 1;
            else  
                sinc_Y = sin(Y) / Y;
            end
            F = sinc_X * sinc_Y;
            E_theta = coeff * sin_phi * F;
            E_phi = coeff * cos_theta * cos_phi * F;
            H_theta = - E_phi / n0;
            H_phi = E_theta / n0;
            
            Exa(i, j) = - E_theta * sin_theta;
            Eya(i, j) = E_theta * cos_theta * cos_phi - E_phi * sin_phi;
            Hxa(i, j) = - H_theta * sin_theta;
            Hya(i, j) = H_theta * cos_theta * cos_phi - H_phi * sin_phi;
                        
            if (-A/2 <= x ) && ( x <= A/2) && ( - B/2 <= y) && ( y <= B/2)
                exponent = exp(1i * phase * (i - ii));
                Exa(i, j) = abs(Exa(i, j)) * exponent;
                Eya(i, j) = abs(Eya(i, j)) * exponent;
                Hxa(i, j) = abs(Hxa(i, j)) * exponent;
                Hya(i, j) = abs(Hya(i, j)) * exponent;
            end
        end
    end

    [E_theta, E_phi] = get_E(theta, phi, Exa, Eya, Hxa, Hya, AA, BB, R, k, num);
end