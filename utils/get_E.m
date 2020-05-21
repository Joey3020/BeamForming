function [E_theta, E_phi] = get_E(theta, phi, Exa, Eya, Hxa, Hya, a, b, R, k, num)
    etha = 120 * pi();
    
    Ms_x = Eya;
    Ms_y = - Exa;
    Js_x = - Hya;
    Js_y = Hxa;
    
    N_phi = 0;
    N_theta = 0;
    L_phi = 0;
    L_theta = 0;
    
    coeff = 1i * k * exp(-1i * k * R) / ( 4 * pi() * R);

    for m = 1:1:num
        for n = 1:1:num
            exponent = coeff * exp(1i*k*( (m - num/2)/num * a * sin(theta)' .* cos(phi) + (n - num/2)/num * b * sin(theta)'.*sin(phi)))* (a/num) * (b/num);
            
            N_phi = N_phi + ( - Js_x(m,n) * sin(phi) + Js_y(m,n) * cos(phi)) .* exponent;
            L_theta = L_theta + ( Ms_x(m,n) * cos(theta)' .* cos(phi) + Ms_y(m,n)*cos(theta).'*sin(phi)) .* exponent;
            
            N_theta = N_theta + (Js_x(m,n) .* cos(theta)' .* cos(phi) + Js_y(m,n) .* cos(theta)' .* sin(phi)) .* exponent;
            L_phi = L_phi + ( - Ms_x(m,n) .* sin(phi) + Ms_y(m,n) .* cos(phi)) .* exponent;
            
        end
    end
    E_phi= (L_theta - N_phi * etha);
    E_theta = - (L_phi + N_theta * etha);
    
end