
%E field in spherical coordinates
%produced by a x b horn antenna
%assuming that horn ~ aperture antenna

function [E_theta, E_phi] = horn2space(a, b, num)

    R = 10;
    k = 2 * pi();
    
    theta = linspace(0, pi()/2, num)';
    phi = linspace(0, 2 * pi(), num);
    
    coeff = 1i * a * b * k * exp(-1i * k * R) / (2 * pi() * R);
    
    X = k * a / 2 * sin(theta) .* cos(phi);
    Y = k * b / 2 * sin(theta) .* sin(phi);
    F = sinc_fn(X) .* sinc_fn(Y);
    
    E_theta = 0.5 * coeff .* (1 + cos(theta)) .* sin(phi) .* F;
    E_phi =   0.5 * coeff .* (1 + cos(theta)) .* cos(phi) .* F;
end