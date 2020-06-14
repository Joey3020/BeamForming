function [E_theta, E_phi] = horn_to_aperture_to_space(a, b, d, A, B, phase_angle, R, k, num)
    theta = linspace(0, pi() / 2, num);
    phi = linspace(0, 2 * pi(), num);
    
    [Ex, Ey, Hx, Hy] = horn_to_aperture(a, b, d, A, B, k, num);
    
    phase = linspace(0, - k * A * sin(phase_angle), num)';
    exp_ = exp(1i * phase);
    Exa = Ex .* exp_;
    Eya = Ey .* exp_;
    Hxa = Hx .* exp_;
    Hya = Hy .* exp_;

    [E_theta, E_phi] = get_E(theta, phi, Exa, Eya, Hxa, Hya, A, B, R, k, num);
end