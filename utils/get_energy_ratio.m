function ratio = get_energy_ratio(a, b, d, A, B, R, k, num)
    [E_theta, E_phi] = horn_to_space(a, b, R, k, num);
    E_total_square = abs(E_theta) .* abs(E_theta)  +  abs(E_phi) .* abs(E_phi);
    th = linspace(0, pi() / 2, num);
    U = E_total_square .* sin(th)';
    Pr_tot = sum(sum(U));
    
    Pr_aperture = 0;
    for i = 1:1:num
        for j = 1:1:num
            theta = pi() / 2 * i /num;
            phi = 2 * pi() * j / num;
            x = d * tan(theta) * cos(phi);
            y = d * tan(theta) * sin(phi);
            if (-A/2 <= x) && ( x <= A / 2) && ( - B/2 <= y ) && (y<=B/2)
                Pr_aperture = Pr_aperture + ...
                    (abs(E_theta(i, j)) * abs(E_theta(i, j))...
                    + abs(E_phi(i, j)) * abs(E_phi(i, j)))...
                    * sin(theta);
            end
        end
    end
    ratio = Pr_aperture / Pr_tot;
end