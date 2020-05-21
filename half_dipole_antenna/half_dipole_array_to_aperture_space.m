
% E field in + z space
% half wl diple antenna propagating
% to space blocked by metasurface

function [E_theta, E_phi] = half_dipole_array_to_aperture_space(a, b, d, R, phase, k, num)
    
    theta = linspace(0, pi()/2, num);
    phi = linspace(0, 2*pi(), num);
    phase_label = - k * phase * a / num;
    
    E_source = half_dipole_array_to_space( R + d, k, num); % theta : 0 ~ pi / 2  distance  R + d
    
    [Exa, Eya, Hxa, Hya] = half_dipole_array_to_aperture(a, b, d, k, num);
    Exa = modify_phase(Exa, phase_label, num);
    Eya = modify_phase(Eya, phase_label, num);
    Hxa = modify_phase(Hxa, phase_label, num);
    Hya = modify_phase(Hya, phase_label, num);

    
    [E_theta_aperture, E_phi_aperture] = get_E(theta, phi, Exa, Eya, Hxa, Hya, a, b, R, k, num); % theta : 0 ~ pi / 2, distance R
    


    
    E_theta = zeros(num, num);
    E_phi = E_phi_aperture;
    
    for i = 1:1:num
        for j = 1:1:num
            theta = pi() /num * i;
            phi = pi() / num * j;

            x = d * tan(theta) * cos(phi);
            y = d * tan(theta) * sin(phi);

            if (x < a/2) && ( x > - a/2) && ( y < b/2) && (y > -b/2) %E field goes through aperture
                E_theta(i, j) = E_theta_aperture(i, j);
            else
                %assume that R >> d
                E_theta(i, j) = E_source(i, j) * R / (R + d) * 0.5 + E_theta_aperture(i, j);
            end
        end
    end
end