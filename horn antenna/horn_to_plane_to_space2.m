function [E_theta, E_phi] = horn_to_plane_to_space2(a, b, d, A, B, AA, BB, phase_angle, R, k, num)
    theta = linspace(0, pi() / 2, num);
    phi = linspace(0, 2 * pi(), num);
    
    [Ex, Ey, Hx, Hy] = horn_to_aperture(a, b, d, AA, BB, k, num);
    
    phase = - k * phase_angle * AA / num;
    ii = fix((AA - A) / 2 * num / AA);
    
    Exa = Ex;
    Eya = Ey;
    Hxa = Hx;
    Hya = Hy;
    
    for i = 1:1:num
        for j = 1:1:num
            x = A * i/num - A/2;
            y = B * j/num - B/2;
            if (-A/2 <= x ) && ( x <= A/2) && ( - B/2 <= y) && ( y <= B/2)
                exponent = exp(1i * phase * (i - ii));
                Exa(i, j) = abs(Ex(i, j)) * exponent;
                Eya(i, j) = abs(Ey(i, j)) * exponent;
                Hxa(i, j) = abs(Hx(i, j)) * exponent;
                Hya(i, j) = abs(Hy(i, j)) * exponent;
            end
        end
    end

    [E_theta, E_phi] = get_E(theta, phi, Exa, Eya, Hxa, Hya, AA, BB, R, k, num);
end