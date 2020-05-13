


function D = get_D_space(E_theta, E_phi, num)

    %spherical coordinate variables
    theta = linspace(0, pi()/2, num);
    
    %total E field
    E_total_square = abs(E_theta) .* abs(E_theta)  +  abs(E_phi) .* abs(E_phi);
    
    %total radiated power
    U = E_total_square .* sin(theta)';
    Pr = sum(sum(U));
    Pr = Pr * pi() * pi() / (num * num); % 2pi/num  * pi/2/num
    
    D = 10 * log10( 4 * pi() * E_total_square ./ Pr);
end