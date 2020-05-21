function [Exa, Eya] = horn_to_aperture(a, b, d, A, B, k, num)    
    
    [Ex, Ey] = uniform_aperture_field(0, a, b, k, num);

    n0 = 120 * pi();    
    Exa = zeros(num, num);
    Eya = zeros(num, num);

    for i = 1:1:num
        for j = 1:1:num
            x = A * i/num - A/2;
            y = B * j/num - B/2;
            
            rho = sqrt(d*d + y*y);
            r = sqrt(rho*rho + x*x);
            
            cos_theta = x / r;
            sin_theta = rho / r;
            cos_phi = y / rho;
            sin_phi = d / rho;
            
            if x==0
                phi = 0;
            else
                phi = atan(y / x);
            end
            [E_theta, E_phi] = get_E(asin(sin_theta), phi, Ex,Ey, -Ey/n0, Ex/n0, a, b, r, k, num);
           
            Exa(i, j) = - E_theta * sin_theta;
            Eya(i, j) = E_theta * cos_theta * cos_phi - E_phi * sin_phi;
        end
    end
    
end