function [E_theta, E_phi] = horn_to_space(a, b, R, k, num)
    n0 = 120 * pi();
    theta = linspace(0, pi()/2, num);
    phi = linspace(0, 2 * pi(), num);
    
    [Exa, Eya] = uniform_aperture_field(0, a, b, k, num);
    [E_theta, E_phi] = get_E(theta, phi, Exa, Eya, - Eya/n0, Exa/n0, a, b, R, k, num);
end

