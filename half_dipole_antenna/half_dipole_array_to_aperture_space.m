
% E field in + z space
% half wl diple antenna propagating
% to space blocked by metasurface

function [E_theta, E_phi] = half_dipole_array_to_aperture_space(d, A, B, R, steer_angle, k, num)
    theta = linspace(0, pi() / 2, num);
    phi = linspace(0, 2 * pi(), num);

    [Exa, Eya, Hxa, Hya] = half_dipole_array_to_aperture(d, A, B, k, num);
    phase = linspace(0, -k * A * sin(steer_angle), num)';
    exp_ = exp(1i * phase);
    
    Exa = Exa .* exp_;
    Eya = Eya .* exp_;
    Hxa = Hxa .* exp_;
    Hya = Hya .* exp_;
    
    [E_theta, E_phi] = get_E(theta, phi, Exa, Eya, Hxa, Hya, A, B, R, k, num);
end