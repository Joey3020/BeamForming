function ratio = get_energy_ratio(a, b, d, A, B, R, k, num)
    [E_theta, E_phi] = horn_to_space(a, b, R, k, num);

    Pr_tot = 0;
    Pr_aperture = 0;
    for i = 1:1:num
        for j = 1:1:num
            theta = pi() / 2 * i /num;
            phi = 2 * pi() * j / num;
            x = d * tan(theta) * cos(phi);
            y = d * tan(theta) * sin(phi);
            E_sq =  (abs(E_theta(i, j)) * abs(E_theta(i, j)) + abs(E_phi(i, j)) * abs(E_phi(i, j))) * sin(theta);
            Pr_tot = Pr_tot + E_sq;
            if (-A/2 <= x) && ( x <= A / 2) && ( - B/2 <= y ) && (y <= B/2)
                Pr_aperture = Pr_aperture + E_sq;
            end
        end
    end
    ratio = Pr_aperture / Pr_tot;
end