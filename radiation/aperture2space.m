function [E_theta, E_phi] = aperture2space(Exa, Eya, Hxa, Hya, a, b, theta, phi)
    
    [num, num] = size(Exa);

    etha = 120 * pi();
    k = 2 * pi();
    R = 10;
    
    %field equivalence principle
    Ms_x = Eya;
    Ms_y = - Exa;
    Js_x = - Hya;
    Js_y = Hxa;
    
    N_phi = 0;
    N_theta = 0;
    L_phi = 0;
    L_theta = 0;
    
    coeff = 1i * k * exp(-1i * k * R) / ( 4 * pi() * R);
    
    %integral over aperture surface
    for m = 1:1:num
        for n = 1:1:num
            x = m / num * a - a / 2;
            y = n / num * b - b / 2;
            exponent = coeff * exp(1i*k*( x * sin(theta)' .* cos(phi) + y * sin(theta)'.*sin(phi))) * (a/num) * (b/num);
            
            N_phi = N_phi + ( - Js_x(m,n) * sin(phi) + Js_y(m,n) * cos(phi)) .* exponent;
            L_theta = L_theta + ( Ms_x(m,n) * cos(theta)' .* cos(phi) + Ms_y(m,n) * cos(theta)' .* sin(phi)) .* exponent;
            
            N_theta = N_theta + (Js_x(m,n) * cos(theta)' .* cos(phi) + Js_y(m,n) * cos(theta)' .* sin(phi)) .* exponent;
            L_phi = L_phi + ( - Ms_x(m,n) * sin(phi) + Ms_y(m,n) * cos(phi)) .* exponent;
            
        end
    end
    
    E_phi= (L_theta - N_phi * etha);
    E_theta = - (L_phi + N_theta * etha);
    
end