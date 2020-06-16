% E field in + z space
% half wl diple antenna propagating
% to space blocked by metasurface

function [E_theta, E_phi] = hdpa2metasurface2space(a, b, d, A, B, s_angle, num)
    theta = linspace(0, pi() / 2, num);
    phi = linspace(0, 2 * pi(), num);

    [Exa, Eya, Hxa, Hya] = hdpa2metasurface(d, A, B, num);
    [Exa, Eya, Hxa, Hya] = metasurface_phase_shift(Exa, Eya, Hxa, Hya, A, B, s_angle);
    
    [E_theta, E_phi] = aperture2space(Exa, Eya, Hxa, Hya, A, B, theta, phi);
end