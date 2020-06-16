

%get directivity of a given beam
function D = get_D(E_theta, E_phi)

    [num, num] = size(E_theta);
    
    %spherical coordinate variables
    theta = linspace(0, pi()/2, num);
    
    %total E field
    U = abs(E_theta) .* abs(E_theta)  +  abs(E_phi) .* abs(E_phi);
    
    %total radiated power
    Pr = sum(sum(U .* sin(theta)')) * pi() * pi() / (num * num);  % 2pi/num  * pi/2/num
    D = 10 * log10( 4 * pi() * U ./ Pr);
end