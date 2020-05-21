function [E_theta, E_phi] = horn_to_aperture_to_space(a, b, d, A, B, phase_angle, R, k, num)
    theta = linspace(0, pi() / 2, num);
    phi = linspace(0, 2 * pi(), num);
    
    [Ex, Ey, Hx, Hy] = horn_to_aperture(a, b, d, A, B, k, num);
    phase = - k * phase_angle * A / num;
    
    Exa = modify_phase(Ex, phase, num);
    Eya = modify_phase(Ey, phase, num);
    Hxa = modify_phase(Hx, phase, num);
    Hya = modify_phase(Hy, phase, num);
    [E_theta, E_phi] = get_E(theta, phi, Exa, Eya, Hxa, Hya, A, B, R, k, num);
end